# campaign-creator-app/server.R

# prior to the shiny server session block
# any variables declared here will be shared 
# between all Shiny app users
market <- read.csv("./data/market-data.csv")
market$`First Name` <- rep('Test', nrow(market))
market$`Last Name` <- rep('Test', nrow(market))
market$`Email` <- rep('Test@gmail.com', nrow(market))

shinyServer(function(input, output, session) {
  
  clustered_dataset <- reactive({
    
    # rebuild the kmeans model with the user specified cluster count
    # because this code is inside a "reactive" function
    # it will always re-execute whenever the user
    # changes input$cluster_count
    kmeans_model <- kmeans(x=market[,c('age_scale', 'inc_scale')], 
                           centers=input$cluster_count)
    
    # append the cluster_id to a result dataframe
    # remember to leave the market data.frame alone
    # since it's shared between other Shiny user sessions
    result_dat <- market
    result_dat$cluster_id <- as.factor(kmeans_model$cluster)
    return(result_dat)
  })
  
  # create the cluster summary dataset
  cluster_summary_dataset <- reactive({
    # this will always re-evaluate whenver 
    # clustered_dataset changes. This is
    # how reactive changes "bubble" through
    # the application
    summary <- clustered_dataset() %>% 
      group_by(cluster_id) %>% 
      summarise(min_age = min(age), avg_age = mean(age),
                max_age = max(age), avg_inc = mean(income), 
                min_inc = min(income), max_inc = max(income)) %>%
      arrange(avg_inc) %>% 
      select(`Avg. Age`=avg_age, `Avg. Income`=avg_inc, 
             `Cluster Id`=cluster_id,
             `Min. Age`=min_age, `Max. Age`=max_age,
             `Min. Income`=min_inc, `Max. Income`=max_inc
             )
    return(summary)
  })
  
  # create all aspects of the table of data
  # it is recommended to use DT:: notation
  # so shiny is not confused with shiny::renderDataTable
  output$campaign_summary_table <- DT::renderDataTable({
    
    # create a datatable with a specific
    # set of configuration options
    d <- DT::datatable(cluster_summary_dataset(), 
                       options = list(
                         deferRender = FALSE,
                         # center all of the columns using the dt-center class
                         # defined in our app-styling.css file
                         columnDefs = list(list(className = 'dt-center', targets = '_all')),
                         autoWidth = FALSE,
                         lengthChange = FALSE,
                         searching = FALSE,
                         paginate = FALSE,
                         info = FALSE,
                         ordering = FALSE
                       ),
                       filter = 'none',
                       selection = 'none',
                       class = 'cell-border stripe', 
                       rownames = FALSE,
                       escape = FALSE)
    
    # add formats to the columns for ease of interpretation
    d <- d %>% 
      formatRound('Avg. Age', digits=1) %>%
      formatCurrency(c('Avg. Income', 'Min. Income', 'Max. Income'), digits=0) %>%
      formatStyle('Avg. Income', fontWeight = 'bold',
                  background = styleColorBar(data=c(0, 125000), color='#d5fdd5'),
                  backgroundSize = '100% 70%',
                  backgroundRepeat = 'no-repeat',
                  backgroundPosition = 'center')
    # return the datatable object to be rendered
    return(d)
  })
  
  # create a visual representation of the clusters
  output$cluster_viz <- renderPlot({
    
    # calculate cluster centers so we can 
    # show a label at each center to denote
    # each cluster
    centers <- clustered_dataset() %>% 
      group_by(cluster_id) %>% 
      summarize(median_age=median(age), 
                median_income=median(income))
    
    # calcualte a total count of clusters to 
    # display in the plot title
    cluster_count <- nrow(centers)
    
    # create the cluster plot to help
    # the user visualize their choice
    # for the total number of clusters
    p <- ggplot(clustered_dataset(), aes(x = age, y = income, color = cluster_id)) + 
      geom_point() +
      geom_text(data = centers, 
                aes(x = median_age, 
                    y = median_income,
                    label = as.character(cluster_id)),
                    color = 'black',
                    size = 16) +
      scale_colour_discrete(guide = FALSE) +
      scale_y_continuous(labels=dollar, breaks=pretty_breaks(n=10)) + 
      scale_x_continuous(breaks=pretty_breaks(n=10)) + 
      xlab("Age") + 
      ylab("Income") +
      ggtitle(paste(cluster_count, '- Cluster Model')) + 
      theme_bw() + 
      theme(plot.title=element_text(face="bold", size=20, margin=margin(0,0,10,0)), 
            axis.title.x=element_text(margin=margin(10,0,0,0)),
            axis.title.y=element_text(margin=margin(0,10,0,0)))
    # after creating the plot, print it so
    # that it is made visible to the UI
    print(p)
  })
  
  # create a dataset to display in a table 
  # and download from
  table_data <- reactive({
    table_data <- clustered_dataset() %>% 
      group_by(cluster_id) %>% 
      mutate(age_ptile=round(rank(age)/length(age),4), 
             income_ptile=round(rank(income)/length(income),4), 
             income=round(income,2)) %>%
      ungroup() %>%
      arrange(-income_ptile) %>%
      select(`First Name`, `Last Name`, 
             `Email`, `Age`=age, `Income`=income, 
             `Age %Tile within Cluster`=age_ptile, 
             `Income %Tile within Cluster`=income_ptile, 
             `Cluster Id`=cluster_id)
    return(table_data)
  })
  
  # create the table using a variet of options
  # to configure the look and feel
  output$campaign_table <- DT::renderDataTable({
  
    d <- DT::datatable(table_data(), 
                       options = list(
                         columnDefs = list(list(width = '150px', targets = 0), 
                                           list(width = '50px', targets = c(3,7)),
                                           list(width = '110px', targets = c(4,5,6)),
                                           list(className = 'dt-center', targets = 3:7)),
                         deferRender = TRUE,
                         autoWidth = FALSE,
                         lengthChange = FALSE,
                         searching = TRUE,
                         paginate = TRUE,
                         pageLength = 25,
                         info = TRUE,
                         ordering = TRUE,
                         # sort by cluster id initially
                         order = list(list(7, 'asc'))
                       ),
                       filter = 'top',
                       selection = 'none',
                       class = 'cell-border stripe', 
                       rownames = FALSE,
                       escape = FALSE
                       )
    
    d <- d %>% formatCurrency('Income', digits=0) %>%
      formatPercentage(c('Age %Tile within Cluster', 
                         'Income %Tile within Cluster'), digits=1)
    
    return(d)
  })

  # provide a server-side method for handling user
  # downloads from the table of data
  output$downloadDataFromTable <- downloadHandler(
    filename = function() {
      paste0('CAMPAIGN_DATA_', format(Sys.Date(), '%Y-%m-%d'), '.csv')
    }
    , content = function(file) {
      write.csv(table_data()[input$campaign_table_rows_all,], file, row.names=FALSE)
    }
    , contentType = "text/csv"
  )
  
})

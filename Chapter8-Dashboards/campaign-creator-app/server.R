# campaign-creator-app/server.R

# prior to the shiny server session block
# any variables declared here will be shared 
# between all Shiny app users
market <- read.csv("./data/Ch5_age_income_data.csv")

shinyServer(function(input, output, session) {
  
  # inside the shiny server session block

  values <- reactiveValues(rows_selected=NULL)
  
  
  three <- kmeans(market[,2:3], 3)
  
  
  # create all aspects of the table of data
  # it is recommended to use DT:: notation
  # so shiny is not confused with shiny::renderDataTable
  output$campaign_table <- DT::renderDataTable({
    
    d <- DT::datatable(iris, 
                       options = list(
                         deferRender = TRUE,
                         columnDefs = list(list(width = '200px', targets = 0)),
                         autoWidth = FALSE,
                         lengthChange = FALSE,
                         searching = FALSE,
                         paginate = FALSE,
                         info = FALSE,
                         ordering = FALSE
                       ),
                       filter = 'none',
                       selection = 'multiple',
                       class = 'cell-border stripe', 
                       rownames = FALSE,
                       escape = FALSE)
    return(d)
  }, server=TRUE)
  
  # provide a server-side method for handling user
  # downloads from the table of data
  output$downloadDataFromTable <- downloadHandler(
    filename = function() {
      paste0('CAMPAIGN_DATA_', format(Sys.Date(), '%Y-%m-%d'), '.csv')
    }
    , content = function(file) {
      write.csv(iris, file, row.names=FALSE)
    }
    , contentType = "text/csv"
  )
  
})
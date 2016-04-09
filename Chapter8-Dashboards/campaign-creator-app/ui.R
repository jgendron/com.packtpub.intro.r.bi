# campaign-creator-app/ui.R

# every user interface starts with shinyUI
shinyUI(
  
  # fluidPage allows for a format that 
  # stretches or narrows elements relative
  # to the size of the browser window
  fluidPage(
    
    # adding a title makes for a more identifiable
    # tab in the brower window for a user
    tags$title("Campaign Creator"),
    
    # all resources typically put into an HTML head tag
    # can be specified using tags$head
    tags$head(
      
      # load the Sans Pro Font for cleaner look
      # consistent with RStudio projects
      tags$link(rel='stylesheet', 
                type='text/css', 
                href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600'),
      
      # load a style sheet specific to this application
      tags$link(rel='stylesheet', 
                type='text/css', 
                href='app-styling.css'),
      
      # include a browser shortcut icon
      # to make the app more visible in the 
      # browser window and bookmarks folder
      tags$link(rel="shortcut icon", 
                type="image/x-icon", 
                href="bike-shortcut-icon.ico")
    ), 
    
    # include a progress wheel whenever the app
    # is performing a calculation longer than 1 second
    busyIndicator(text = "Calculation in progress ... ", wait = 1000),
    
    fluidRow(
      h5('Hellow')
    ),
    
    fluidRow(
      column(12, DT::dataTableOutput("campaign_table", width = "100%"))
    )
    
  )
)
    
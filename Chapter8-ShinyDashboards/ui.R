library(shiny)

shinyUI(fluidPage(

    titlePanel("Revenue Prediction from Marketing Expenditures"),

  sidebarLayout(
       sidebarPanel(
            sliderInput("spend",
                        "Expenditure Level:",
                        min = 54, max = 481,
                        value = 250)
            ),
       
       mainPanel(
            plotOutput("prediction_plot")
            )
       )
  )
)
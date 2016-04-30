library(shiny)

revenue <- read.csv("./data/Ch8_marketing.csv")
model <- lm(revenues ~ marketing_total, data = revenue)

lo_hi <- range(revenue$marketing_total)
ylimdata <- data.frame(marketing_total = lo_hi[2])

y_range <- predict.lm(model, ylimdata, interval = 'predict')

shinyServer(function(input, output) {
     output$prediction_plot <- renderPlot({
          
          plot(revenue$marketing_total, revenue$revenues, 
               ylim = c(floor(min(revenue$revenues)), y_range[3]),
               xlab = 'Marketing Expenditures ($)',
               ylab = 'Revenues ($)')
          abline(model, col = 'blue')
          
          newdata <- data.frame(marketing_total = input$spend)
          pred <- predict.lm(model, newdata, interval = 'predict')
          
          points(c(rep(input$spend, 2)), c(pred[2], pred[3]),
                 pch = '-', cex = 2, col = 'orange')
          segments(input$spend, pred[2], input$spend, pred[3],
                   col = 'orange', lty = 2, lwd = 2)
          
          points(input$spend, pred[1], pch = 19, col = 'blue', cex = 2)
          
          text(min(revenue$marketing_total), y_range[3] - 2,
               paste0('Predicted revenues of $', round(pred[1], 2),
                      ' range of {', round(pred[2], 2), ' to ',
                      round(pred[3], 2), '}'), pos = 4, cex = 0.9)
          })
     })

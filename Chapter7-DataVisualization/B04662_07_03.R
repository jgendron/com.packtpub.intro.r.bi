# Copyright 2016 Packt Publishing

# Introduction to R for Business Intelligence
# Chapter 7, Part 3 - Interactive JavaScript Charting using rCharts

message("Introduction to R for Business Intelligence
        Chapter 7 - Visualizing the Data’s Story
        Copyright (2016) Packt Publishing \n
        Let's continue to learn about Interactive JavaScript Charting")

library(rCharts)
library(reshape2)

dat <- read.csv('./data/Ch7_email_marketing_campaign.csv', check.names = F)
dat2 <- melt(dat[,c('Promotion', 
                    'Opened Email', 'Clicked Email Link', 
                    'Created Account', 'Paid for Membership')], 
             id.vars='Promotion', 
             variable.name = "Event", 
             value.name = "Outcome")
dat2$Outcome <- ifelse(dat2$Outcome == 'Y', 1, 0)
aggregate <- aggregate(Outcome ~ Promotion + Event, FUN=sum, data=dat2)
n1 <- nPlot(Outcome ~ Event, group = "Promotion", data = aggregate, type = "multiBarChart")
n1$xAxis(axisLabel = 'Event Type',
         staggerLabels = FALSE,
         rotateLabels = 0)
n1$yAxis(axisLabel = 'Conversions',
         width = 40,
         tickFormat = "#! d3.format('.0f') !#",
         showMaxMin = TRUE)
n1$chart(color=c('#006CB8', '#ED1C24'))
n1$params$width <- 700
n1$params$height <- 400
n1

dat <- read.csv('./data/Ch7_email_marketing_conversions.csv', check.names = F)
promotion1 <- dat[dat$Promotion == '10% off', 2:4]
colnames(promotion1) <- c('source', 'target', 'value')
sankeyPlot <- rCharts$new()
sankeyPlot$setLib('http://timelyportfolio.github.io/rCharts_d3_sankey/libraries/widgets/d3_sankey')
sankeyPlot$set(
  data = promotion1,
  nodeWidth = 25,
  nodePadding = 100,
  layout = 800,
  width = 700,
  height = 500
)
sankeyPlot$setTemplate(
  afterScript = "
  <script>

  // loop through the nodes and find the total count of emails sent
  // we will use this to determine the percentages of each descendant node
  var total_emails_sent = 0;
  d3.selectAll('#{{ chartId }} svg .node text')
    .text( function(d) { 
    if(d.name == 'Sent Email') { 
      total_emails_sent = d.value 
    }
  })

  // loop through the nodes and rename them and format them
  d3.selectAll('#{{ chartId }} svg .node text')
    .text( function(d) { 
            if(d.name == 'Sent Email') { 
              return d.name 
            } else { 
              return d.name + ': ' + d3.format('.0%')(d.value / total_emails_sent)
            } 
          })
    .style('font-size', '13')
    .style('font-weight', 'bold')

  // loop through the links and add the conversion percentage
  // we will use this to determine the percentages of each descendant node
  d3.selectAll('#{{ chartId }} svg .link title')
    .text( function(d) { 
            return d.source.name + ' \\u2192 ' + 
                    d.target.name + ': ' + d3.format('.0%')(d.value / d.source.value) })
  </script>
  ")
sankeyPlot

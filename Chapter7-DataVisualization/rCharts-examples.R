
### javascript charts section

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

dat <- read.csv('./data/Ch7_email_marketing_conversion_rates.csv', check.names = F)
promotion1 <- dat[dat$Promotion == '10% off', 2:4]
colnames(promotion1) <- c('source', 'target', 'value')
sankeyPlot <- rCharts$new()
sankeyPlot$setLib('http://timelyportfolio.github.io/rCharts_d3_sankey/libraries/widgets/d3_sankey')
sankeyPlot$set(
  data = promotion1,
  nodeWidth = 25,
  nodePadding = 50,
  layout = 800,
  width = 700,
  height = 500,
  labelFormat = ".2%"
)
sankeyPlot

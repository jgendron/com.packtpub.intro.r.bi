dat <- data.frame(target=c('Opened Email', 
                           'No Response',
                           'Clicked Email Link', 
                           'No Response', 
                           'Created Account', 
                           'No Response',
                           'Paid One Month',
                           'No Response'), 
                  source=c('Sent Email', 
                           'Sent Email',
                           'Opened Email', 
                           'Opened Email', 
                           'Clicked Email Link', 
                           'Clicked Email Link',
                           'Created Account',
                           'Created Account'),
                  value=   c(.1,  .9,   .5,   .5,   .2,   .8,   .3,   .7))

sankeyPlot <- rCharts$new()
sankeyPlot$setLib('http://timelyportfolio.github.io/rCharts_d3_sankey/libraries/widgets/d3_sankey')
sankeyPlot$set(
  data = dat,
  nodeWidth = 25,
  nodePadding = 50,
  layout = 800,
  width = 700,
  height = 500,
  labelFormat = ".0%",
  margin = list(right = 20, left = 20, bottom = 50, top = 20),
  title = "Sankey Diagram"
)
# http://stackoverflow.com/questions/25412223/adding-color-to-sankey-diagram-in-rcharts
sankeyPlot$setTemplate(
  afterScript = "
  <script>
  
  d3.selectAll('#{{ chartId }} svg text')
  .style('font-size', '15')
  
  var cscale = d3.scale.category10();
  
  d3.selectAll('#{{ chartId }} svg path.link')
  .style('stroke', function(d){
  return cscale(d.source.name);
  })
  .style('stroke-opacity', .3)
  
  d3.selectAll('#{{ chartId }} svg .node rect')
  .style('fill', function(d){
  return cscale(d.name)
  })
  .style('stroke', 'none')
  
  </script>
  ")
sankeyPlot

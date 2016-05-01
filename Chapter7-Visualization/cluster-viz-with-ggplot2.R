market <- read.csv("./data/market-data.csv")

kmeans_model <- kmeans(x=market[,c('age_scale', 'inc_scale')], 
                       centers=6)

market$cluster_id <- as.factor(kmeans_model$cluster)

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
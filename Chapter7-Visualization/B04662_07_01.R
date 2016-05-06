plot_dat <- read.csv("./data/Ch7_marketing.csv")

library(ggplot2);library(scales)

plot <- ggplot(data=plot_dat, aes(x = marketing_total, 
                              y = revenues, 
                              color = pop_density))

plot <- plot + geom_point(size = 5, shape = 18)

plot <- plot + scale_y_continuous(labels = dollar, 
                                  breaks = pretty_breaks(n=5)) + 
                 scale_x_continuous(labels = dollar, 
                                    breaks = pretty_breaks(n=5)) + 
                 scale_colour_discrete(guide = guide_legend(title = "Population Density"))

plot <- plot + xlab("Marketing Expenditures ($K)") + ylab("Revenues ($K)")

plot

# Copyright 2016 Packt Publishing

# Introduction to R for Business Intelligence
# Chapter 7, Part 3 Addendum - Email Campaign Raw Data Manipulation

library(reshape2)

# open the dataset
dat <- read.csv('./data/Ch7_email_marketing_raw_event_data.csv', check.names = F)

# inspect the dataset to see that each of the events for a person
# are coded as a separate column
# it would make more sense to convert the dataset into a format
# where each event is a column and the outcome is either "Y" or "N"

# the melt function is a function from the reshape2 package
# that will conver the dataset into this type of long format
dat2 <- melt(dat[,c('Promotion', 
                    'Opened Email', 'Clicked Email Link', 
                    'Created Account', 'Paid for Membership')], 
             id.vars='Promotion', 
             variable.name = "Event", 
             value.name = "Outcome")

# conver the "Y" or "N" variable to a number so that we can 
# aggregate much easier, by just using the sum function to count the "Y" events
dat2$Outcome <- ifelse(dat2$Outcome == 'Y', 1, 0)

# we can use the aggregate function from the stats package (part of base R)
# to determine the number of "Y" outcomes for each event and promotion
# so that we can plot out the differences by promotion
aggregate <- aggregate(Outcome ~ Promotion + Event, FUN=sum, data=dat2)

write.csv(aggregate, "./data/Ch7_email_marketing_outcomes.csv", row.names=FALSE)

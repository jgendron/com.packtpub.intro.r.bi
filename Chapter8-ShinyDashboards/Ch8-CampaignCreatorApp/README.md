#Campaign Creator Shiny App
*Chapter 8 Shiny Dashboards*

-------

A Shiny app designed for a custom cluster count and method, and access to a list of records based on cluster membership.

![app_image](https://github.com/jgendron/com.packtpub.intro.r.bi/blob/master/Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/www/campaign-creator-app-screenshot.png)


####Overview

This Shiny app was designed to give an example of how to extend the basics learned via the Expenditures to Revenue Shiny app in Chapter 8. Some advanced topics utilized by this app are:

 - using a `global.R` file
 - using a `www` web resources folder
 - using CSS to style the app
 - adding a progress wheel
 - interactive tables using the `DT` package

Our scenario for creating such an application is that the marketing team at Bike Sharing, LLC. would like more control and input over the numbers of customer clusters. In response our application allows the user to pick between 2 clustering methods (k-means and hierarchical clustering) and pick any number of clusters between 2 and 10 groupings. The results are shown visually and a summary of the indicators is provided in a table. In addition, the marketing team might want to contact certain individuals based on their cluster membership or individual characteristics. The Shiny app provides a table of raw data with cluster membership that users can download if desired.

####Installing Required Packages

This Shiny app requires 8 packages:

1. `install.packages(c('shiny', 'shinysky', 'DT', 'dplyr', 'ggplot2', 'scales', 'dendextend', 'RColorBrewer'))`

####Running the App Locally

There are 2 ways to run the app:

- Running directly from Github:
	
	`shiny::runGitHub(repo = 'com.packtpub.intro.r.bi',
	                 username = 'jgendron', 
	   				 subdir = 'Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/')`

- Cloning the repository to have a local copy:
	- In RStudio Select "New Project" from "Version Control"
	- Enter the Clone URL for this repository
	- `setwd('Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp')`
	- `shiny::runApp()`

####App Styling via CSS

This Shiny app uses CSS in order to style the page elements. This is no different from styling a traditional web page, so any resource teaching CSS will help, such as, the W3Schools CSS Tutorial available at: [http://www.w3schools.com/css/](http://www.w3schools.com/css/).

Also, Garrett Grolemund with Joe Cheng wrote an article *Style your apps with CSS*, which is a Shiny-specific guide and available at: [http://shiny.rstudio.com/articles/css.html](http://shiny.rstudio.com/articles/css.html)

####Other Resources

The `DT` package is feature-rich and has complete documentation available at:  [http://rstudio.github.io/DT/](http://rstudio.github.io/DT/)

First Name, Last Name, and Email Addresses displayed in the app were gathered at: [https://randomuser.me/](https://randomuser.me/)

####About the Author

Steven Mortimer is a statistician turned data scientist. He enjoys helping others  to be more efficient and effective through innovative data products. If interested in viewing more of Steven's work, please visit his Github account at: [https://github.com/ReportMort](https://github.com/ReportMort)

License
-------
Copyright 2016 Packt Publishing

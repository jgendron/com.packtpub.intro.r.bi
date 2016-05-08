#Expenditures to Revenue Shiny App
*Chapter 8 Shiny Dashboards*

-------

A simple Shiny App that predicts revenue from user inputted marketing expenditure via a linear regression model.

![app_image](https://github.com/jgendron/com.packtpub.intro.r.bi/blob/master/Chapter8-ShinyDashboards/expenditures-revenue-app-screenshot.png)

####Overview

Our scenario for creating such an application is that the marketing group could benefit from a web application to make revenue predictions based on the linear regression model. Some topics utilized by this app are:

 - creating a `ui.R` and `server.R` file
 - creating a `sliderInput` widget
 - rendering a plot within a Shiny app using `renderPlot({})`
 - using **reactivity** and **variable scoping**

####Installing Required Packages

This Shiny app requires 1 package:

1. `install.packages(c('shiny'))`

####Running the App Locally

There are 2 ways to run the app:

- Running directly from Github:
	
	`shiny::runGitHub(repo = 'com.packtpub.intro.r.bi', username = 'jgendron', subdir = 'Chapter8-ShinyDashboards/Ch8-BasicShinyApp/')
`

- Cloning the repository to have a local copy:
	- In RStudio Select "New Project" from "Version Control"
	- Enter the Clone URL for this repository
	- `setwd('Chapter8-ShinyDashboards/Ch8-BasicShinyApp')`
	- `shiny::runApp()`

####Other Resources

...

####About the Author

... (Your name, your background, links to your twitter, github, linkedin, blogs, etc.)

License
-------
Copyright 2016 Packt Publishing

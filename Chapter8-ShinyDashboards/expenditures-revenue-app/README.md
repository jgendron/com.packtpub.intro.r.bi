#Expenditures to Revenue Shiny App
*Chapter 8 Shiny Dashboards*

-------

A simple Shiny App that predicts revenue from user inputted marketing expenditure via a linear regression model.

# image here?

####Overview

This Shiny app was designed to give an example of how to extend the basics learned via the Expenditures to Revenue Shiny app. Some advanced topics utilized by this app are:

 - using a `global.R` file
 - using a `www` web resources folder
 - using CSS to style the app
 - adding a progress wheel
 - interactive table using the `DT` package

Our scenario for creating such an application is that the marketing team at Bike Sharing, LLC. would like more control and input over the numbers of customer clusters. In response our application allows the user to pick between 2 clustering methods (k-means and hierarchical clustering) and pick any number of clusters between 2 and 10 groupings. The results are shown visually and a summary of the indicators is provided in a table. In addition, the marketing team might want to contact certain individuals based on their cluster membership or individual characteristics. The Shiny app provides a table of raw data with cluster membership that users can download if desired.

####Installing Required Packages

This Shiny app requires 1 package:

1. `install.packages(c('shiny'))`

####Running the App Locally

There are 2 ways to run the app:

1. Running directly from Github:
	- ljsad
	- lasdj
	- asldkj
2. Cloning the repository to have a local copy:
	- Open up R and type the following commands:
	- library(devtools)
	- document('.')
	- test('.') # check() fails on the tests, but this works (?)
	- build('.')
	- Then copy the archive to the Google Drive folder [here](https://drive.google.com/open?id=0B07OqbhXBv-UfkJnbm1aTlFzMFVTVHZxbVVRdFNNX2tsQ18yOWdIX3NleWM1Z3ZCbVl1N28&authuser=0) so it's shared with other people for people to grab.

####App Styling via CSS

This Shiny app uses CSS in order to style the page elements. This is no different from styling a traditional web page, so any resource teaching CSS will help, such as, the W3Schools CSS Tutorial available at: [http://www.w3schools.com/css/](http://www.w3schools.com/css/).

Also, Garrett Grolemund with Joe Cheng wrote an article *Style your apps with CSS*, which is a Shiny-specific guide and available at: [http://shiny.rstudio.com/articles/css.html](http://shiny.rstudio.com/articles/css.html)

####Other Resources

The `DT` package is feature-rich and has complete documentation available at:  [http://rstudio.github.io/DT/](http://rstudio.github.io/DT/)

First Name, Last Name, and Email Addresses were gathered using [https://randomuser.me/](https://randomuser.me/)

####About the Author

Your name, your background, links to your twitter, github, linkedin, blogs, etc.

License
-------
Copyright 2016 Packt Publishing
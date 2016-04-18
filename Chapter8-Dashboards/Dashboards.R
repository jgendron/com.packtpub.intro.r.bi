# Copyright 2016 Packt Publishing

# Introduction to R for Business Intelligence
# Chapter 8 - Publishing Data Products as Dashboards

# Use Case
# - anticipating the questions
# - formalizing the story

# Skeleton Directory Structure - (including a www folder)

# Setting the header - tags$head()
# document, scripts, styles, meta information

# Setting the body fluidPage

# using a global.R - load packages

# Pro Tip: modularizing the UI - separate .R files for the UI and source them

# variables outside server session - in the top of server.R

# Pro Tip: Database connections, shared datasets in the top

# variables inside server session - inside the top of server.R

# deploy
 - shinyapps.io

# running from repository
shiny::runGitHub(repo = "com.packtpub.intro.r.bi", 
                 username = "ReportMort", 
                 subdir = "/Chapter8-Dashboards/campaign-creator-app")

Setting up a shinyapps.io account



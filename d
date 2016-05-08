warning: LF will be replaced by CRLF in Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/global.R.
The file will have its original line endings in your working directory.
[1mdiff --git a/Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/global.R b/Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/global.R[m
[1mindex 70690e2..19dc52a 100644[m
[1m--- a/Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/global.R[m
[1m+++ b/Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/global.R[m
[36m@@ -2,7 +2,7 @@[m
 [m
 # default strings to characters to [m
 # avoid potential factor-related issues[m
[31m-options(stringsAsFactors=FALSE)[m
[32m+[m[32moptions(stringsAsFactors = FALSE)[m
 [m
 # load all packages used by the shiny app here in a central location[m
 # suppressing warnings and messages are simply for convenience[m
[1mdiff --git a/Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/server.R b/Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/server.R[m
[1mindex b218a06..15eaef1 100644[m
[1m--- a/Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/server.R[m
[1m+++ b/Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/server.R[m
[36m@@ -22,8 +22,8 @@[m [mshinyServer(function(input, output, session) {[m
     # because this code is inside a "reactive" function[m
     # it will always re-execute whenever the user[m
     # changes input$cluster_count or input$cluster_method[m
[31m-    if (input$cluster_method == "K-means"){[m
[31m-      kmeans_model <- kmeans(x = market[,c("age_scale", "inc_scale")], [m
[32m+[m[32m    if (input$cluster_method == "K-means") {[m
[32m+[m[32m      kmeans_model <- kmeans(x = market[, c("age_scale", "inc_scale")],[m[41m [m
                              centers = input$cluster_count)[m
       result_dat$cluster_id <- as.factor(kmeans_model$cluster)[m
     } else {[m
[36m@@ -86,8 +86,7 @@[m [mshinyServer(function(input, output, session) {[m
     # add formats to the columns for ease of interpretation[m
     d <- d %>% [m
       formatRound("Median Age", digits = 0) %>%[m
[31m-      formatCurrency(c("Median Income", "Min. Income", "Max. Income"),[m
[31m-                     digits = 0) %>%[m
[32m+[m[32m      formatCurrency(c("Median Income", "Min. Income", "Max. Income")) %>%[m
       formatStyle("Median Income", fontWeight = "bold",[m
                   background = styleColorBar(data = c(0, 125000),[m
                                              color = "#d5fdd5"),[m
[36m@@ -122,19 +121,19 @@[m [mshinyServer(function(input, output, session) {[m
     [m
     # the plotting method will change[m
     # based upon the clustering method[m
[31m-    if(input$cluster_method == "Hierarchical"){[m
[32m+[m[32m    if (input$cluster_method == "Hierarchical") {[m
       [m
       # recompute the clusters[m
       # based on the user-specified[m
       # cluster count[m
       cent <- NULL[m
[31m-      for(k in 1:cluster_count){[m
[32m+[m[32m      for (k in 1:cluster_count) {[m
         cent <- rbind(cent, colMeans(clustered_dataset()[clustered_dataset()$cluster_id == k,[m
                                                          c("age_scale",[m
                                                            "inc_scale"),[m
                                                          drop = FALSE]))[m
       }[m
[31m-      cut_tree <- hclust(dist(cent)^2, method = "cen", [m
[32m+[m[32m      cut_tree <- hclust(dist(cent) ^ 2, method = "cen",[m[41m [m
                     members = table(clustered_dataset()$cluster_id))[m
       [m
       # convert the cut tree to a dendrogram to [m
[36m@@ -169,11 +168,11 @@[m [mshinyServer(function(input, output, session) {[m
                     select(xend,col), by = c("cluster_id" = "xend"))[m
       [m
       # create the plot of the dendrogram[m
[31m-      p <- ggplot(ggdend, labels=F) +[m
[32m+[m[32m      p <- ggplot(ggdend, labels = F) +[m
         # add the labels at each leaf[m
[31m-        geom_text(data=centers, [m
[32m+[m[32m        geom_text(data = centers,[m[41m [m
                   aes(label = label, x = as.numeric(cluster_id), y = -.1, [m
[31m-                      size = 4, lineheight = .8, color=col), hjust = 0) +[m
[32m+[m[32warning: LF will be replaced by CRLF in Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/server.R.
The file will have its original line endings in your working directory.
m                      size = 4, lineheight = .8, color = col), hjust = 0) +[m
         # flip the axes and scale to fit the text[m
         coord_flip() +  [m
         scale_y_reverse(limits = c(max(ggdend$segments$yend) + .15,[m
[36m@@ -184,14 +183,14 @@[m [mshinyServer(function(input, output, session) {[m
         # more consistent with the K-means created plot[m
         ggtitle(paste(cluster_count, "- Cluster Model")) +[m
         theme_bw() +[m
[31m-        theme(line=element_blank(), [m
[32m+[m[32m        theme(line = element_blank(),[m[41m [m
               axis.text.x = element_blank(),[m
               axis.text.y = element_blank(), [m
               axis.title.x = element_blank(),[m
               axis.title.y = element_blank(), [m
               axis.ticks = element_blank(),[m
               plot.title = element_text(face = "bold", size = 20,[m
[31m-                                        margin=margin(0, 0, 10, 0)))[m
[32m+[m[32m                                        margin = margin(0, 0, 10, 0)))[m
       [m
     } else {[m
       [m
[36m@@ -214,8 +213,8 @@[m [mshinyServer(function(input, output, session) {[m
         ylab("Income") +[m
         ggtitle(paste(cluster_count, "- Cluster Model")) + [m
         theme_bw() + [m
[31m-        theme(plot.title=element_text(face = "bold", size=20,[m
[31m-                                      margin=margin(0, 0, 10, 0)), [m
[32m+[m[32m        theme(plot.title = element_text(face = "bold", size = 20,[m
[32m+[m[32m                                      margin = margin(0, 0, 10, 0)),[m[41m [m
               axis.title.x = element_text(margin = margin(10, 0, 0, 0)),[m
               axis.title.y = element_text(margin = margin(0, 10, 0, 0)))[m
     }[m
[36m@@ -235,11 +234,21 @@[m [mshinyServer(function(input, output, session) {[m
              income = round(income,2)) %>%[m
       ungroup() %>%[m
       arrange(-income_ptile) %>%[m
[31m-      select("First Name", "Last Name", [m
[31m-             "Email", "Age" = age, "Income" = income, [m
[31m-             "Income %Tile within Cluster" = income_ptile, [m
[31m-             "Income %Tile Overall" = income_ptile_overall, [m
[31m-             "Cluster Id"=cluster_id)[m
[32m+[m[32m      select(`First Name`, `Last Name`,[m
[32m+[m[32m             `Email`, "Age" = age, "Income" = income,[m
[32m+[m[32m             "Income %Tile within Cluster" = income_ptile,[m
[32m+[m[32m             "Income %Tile Overall" = income_ptile_overall,[m
[32m+[m[32m             "Cluster Id" = cluster_id)[m
[32m+[m[41m    [m
[32m+[m[41m    [m
[32m+[m[32m    # select(`First Name`, `Last Name`,[m
[32m+[m[32m    #        `Email`, `Age`=age, `Income`=income,[m
[32m+[m[32m    #        `Income %Tile within Cluster`=income_ptile,[m
[32m+[m[32m    #        `Income %Tile Overall`=income_ptile_overall,[m
[32m+[m[32m    #        `Cluster Id`=cluster_id)[m
[32m+[m[41m    [m
[32m+[m[41m    [m
[32m+[m[41m    [m
     return(table_data)[m
   })[m
   [m
[36m@@ -265,7 +274,7 @@[m [mshinyServer(function(input, output, session) {[m
          escape = FALSE[m
          )[m
     [m
[31m-    d <- d %>% formatCurrency("Income", digits=0) %>%[m
[32m+[m[32m    d <- d %>% formatCurrency("Income") %>%[m
       formatPercentage(c("Income %Tile within Cluster", [m
                          "Income %Tile Overall"), digits = 1)[m
     [m
[36m@@ -279,7 +288,7 @@[m [mshinyServer(function(input, output, session) {[m
       paste0("CAMPAIGN_DATA_", format(Sys.Date(), "%Y-%m-%d"), ".csv")[m
     },[m
     content = function(file) {[m
[31m-      write.csv(table_data()[input$campaign_table_rows_all, ], file,                                          row.names = FALSE)[m
[32m+[m[32m      write.csv(table_data()[input$campaign_table_rows_all, ], file, row.names = FALSE)[m
     },[m
     contentType = "text/csv"[m
   )[m
[1mdiff --git a/Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/ui.R b/Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/ui.R[m
[1mindex 631fc2c..d0079ef 100644[m
[1m--- a/Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/ui.R[m
[1m+++ b/Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/ui.R[m
[36m@@ -64,15 +64,15 @@[m [mshinyUI([m
       # clusters to create[m
       column(3,[m
              sliderInput("cluster_count",[m
[31m-                         label="How Many Clusters?",[m
[31m-                         min=2, max=10, [m
[31m-                         value=6, step=1)[m
[32m+[m[32m                         label = "How Many Clusters?",[m
[32m+[m[32m                         min = 2, max = 10,[m[41m [m
[32m+[m[32m                         value = 6, step = 1)[m
       ),[m
       # allow the user to pick a clustering method[m
       # default to K-means[m
       column(6,[m
              radioButtons("cluster_method",[m
[31m-                          label="Clustering Method?",[m
[32m+[m[32m                          label = "Clustering Method?",[m
                           choices = c("K-means", "Hierarchical"), [m
                           selected = "K-means", [m
                           inline = FALSE)[m
warning: LF will be replaced by CRLF in Chapter8-ShinyDashboards/Ch8-CampaignCreatorApp/ui.R.
The file will have its original line endings in your working directory.

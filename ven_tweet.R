#' ---
#' title: "Venezuela Tweet Clean Up & Analysis"
#' author: "Brian and Ash"
#' date: "March 22nd, 2018"
#' ---


#' Ensure that the following packages are installed and loaded:"twitteR", "rtweet", "dplyr", "tidyr"
#+ include = FALSE
install.packages(c("twitteR", "rtweet", "dplyr", "tidyr"))
library(twitteR)
library(rtweet)
library(dplyr)
library(tidyr)

#+ include = TRUE
#' Information needed to pull data from twitter: CONSUMER_KEY, CONSUMER SECRET,ACCESS_TOKEN, ACCESS_SECRET. 
#' This willl vary based on your own twitter account. 
#+ include=FALSE
consumer_key <- ""
consumer_secret <- ""
access_token <- ""
access_secret <- ""


#+ include=TRUE
#' Creates the authetication to the twitter API, without a valid authentication the twitter pulls will fail.
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

#' Set Up Path. Ensure to change the variable myPath with your own path accordingly.
#+ include = FALSE
myPath <- "C:/Users/brian.perez/DataScience/rtweetvenba/"

#+ include = TRUE
#' Read the data that has been saved previously, to ensure that we can append new data. 
test <- read.csv(paste(myPath,"tweets.df.all.csv", sep=""), header = TRUE,stringsAsFactors = FALSE)

#' Pulls Data from Twitter based on specified keywords or hashtags, specifying how many tweets to pull, in both english and spanish, and saves each pull into a variable.
#' Things to note: Twitter limits the amount of pulls one can do within 15 minutes. 
tweets3000_daily <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 3000, lang = c("es","en"), retryOnRateLimit = 120 )

#' Convert the pulled tweets, which are class type list, from the previous step into a Data Frame in order to analyze the data.
tweets.df3000 <- twListToDF(tweets3000_daily)

#' We need to add a column to each data frame that adds the date the tweet was pulled. We store this in a new variable so we won't edit the source.
tweets.df3000.ec <- mutate(tweets.df3000,source_data=date())

#' Once the new sets of tweets have been pulled and the old tweets from the file are loaded, then we want
#' to append the new pull to the old data, and save it to the existing file.
write.csv(rbind(select(test,-1),tweets.df3000.ec), file = (paste(myPath,"tweets.df.all.csv", sep="")))

#' Read the new csv file into a DF. This ensures that we are working with the latest tweets.
test_upd <- read.csv(paste(myPath,"tweets.df.all.csv", sep=""), header = TRUE,stringsAsFactors = FALSE)

str(test_upd)

#' Remove duplicates based on text, created, screenName, statusSource. 
test_rmv_dups <- distinct(test_upd, text, created, screenName,statusSource,.keep_all = TRUE)
str(test_rmv_dups)

#' Looking at the StatusSource variable, it has the following format:
head(select(test_rmv_dups,statusSource),5)

#' Seperate statusSource based on the sep > in order to see the platform of the Tweet (Android, Iphone, Ipad)
test_rmv_dups_sep <- separate(test_rmv_dups,statusSource, c("URL","Platform"),sep=">")
head(select(test_rmv_dups_sep,URL, Platform),5)

#' We need to continue the clean up of the Platform column by removing the additional characters at the end.
test_rmv_dups_sep1 <- separate(test_rmv_dups_sep,Platform, c("Platform","Remove"),sep="<")
head(select(test_rmv_dups_sep1,Platform, Remove),5)

#' Remove the unnecasarry columns that resulted from separating statusSource.
test_rmv_dups_sep2 <- select(test_rmv_dups_sep1,-URL,-Remove)
str(test_rmv_dups_sep2)

#' Create a DF with only the Platform used
commonPlatform <- select(test_rmv_dups_sep2,Platform)

#' Create a variable that holds the frequency of the common platforms used
#' Source: https://stackoverflow.com/questions/24576515/relative-frequencies-proportions-with-dplyr/24576703
commonPlatform_freq <- summarize(group_by(commonPlatform,Platform),freq=n())

#' Arrange the common platform in descending order, to see which type of device/platform was most used.
commonPlatform_freq_desc <- arrange(commonPlatform_freq, desc(freq))

#' Add the proportion to the common platfrom to show the most used platform
commonPlatform_prop <- mutate(commonPlatform_freq_desc,prop=freq*100/sum(freq))
commonPlatform_prop

#' Create a DF with only the screenNames
commonUsers <- select(test_rmv_dups_sep2,screenName)

#' Create a variable that holds the frequency of the users (i.e. Show's the amount of tweets each user has in the data set).
commonUsers_freq <- summarize(group_by(commonUsers,screenName),freq=n())

#' Arrange the commonUsers_freq by descending order, to see the screename with most tweets.
commonUsers_freq_desc <- arrange(commonUsers_freq,desc(freq))

#' Add the proportion to the common screenNames / users to show the percentages.
commonUsers_prop <- mutate(commonUsers_freq_desc,prop=freq*100/sum(freq))
commonUsers_prop

#' We want to find out the location of the tweets based on the latitude and longtiude variables/columns. 
#' We removed the NAs using the drop_na tidyr function. 
#' Source: https://stackoverflow.com/questions/4862178/remove-rows-with-nas-missing-values-in-data-frame <br>
#' Another way to accomplish this task is to use the following dplyr filter function: 
#' test_lat_long <- filter(test_lat_long_1, !is.na(latitude), !is.na(longitude))
test_lat_long1 <- drop_na(test_rmv_dups_sep2, latitude, longitude)
str(test_lat_long1)

#' Save test_lat_long df as a CSV file to upload into ArcGIS online and created 2 maps. 
write.csv(test_lat_long1,file = paste(myPath,"test_lat_long.csv",sep=""), row.names = FALSE)

#' Created maps using ArcGIS with tweets from 3/20/18:<br>
#' <a href="https://github.com/perezba/rtweetvenba/blob/master/HeatMap_Ventweets.PNG?raw=true"> Venezuelan Tweets Heat Map</a><br>
#' <a href="https://github.com/perezba/rtweetvenba/blob/master/Map_Ventweets.PNG"> Venezuelan Tweets Platform</a><br>

#' HTML file was knitted directly from the R script using rmarkdown render function: <br>
#' rmarkdown::render(paste(myPath,"ven_tweet.R",sep="")) <br>
#' Source: http://brooksandrew.github.io/simpleblog/articles/render-reports-directly-from-R-scripts/

install.packages(c("twitteR", "rtweet", "dplyr", "tidyr"))
library(twitteR)
library(rtweet)
library(dplyr)
library(tidyr)

# Information needed to pull data from twitter. This willl vary based on your own twitter account. 
consumer_key <- "55GaUjeUYNQQzcRCJijKZFVed"
consumer_secret <- "3wTTZNyMZRB0tREbsHPWotMKrGLMQAG8BouBm103rzSJ4SMicn"
access_token <- "477084726-8559mi6USkMPNHdFrtvw39ApfEvOBE7uDTLFxq3S"
access_secret <- "CJJSpYn6Za8dpCZQIzXiBtUaXtj5tjHw6rQfu9gqH7Jm8"

# Creates the authetication to the twitter API, without a valid authentication the twitter pulls will fail
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)


# Pulls Data from Twitter based on specified keywords or hashtags, specifying how many tweets to pull, in both english and spanish, and saves each pull into a variable.
# Things to note: Twitter limits the amount of pulls one can do within 15 minutes. 

#Add dates of pull for data.
tweets500 <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 500, lang = c("es","en"), retryOnRateLimit = 120 )
tweets750 <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 750, lang = c("es","en"), retryOnRateLimit = 120 )
tweets900 <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 900, lang = c("es","en"), retryOnRateLimit = 120 )
tweets1500 <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 1500, lang = c("es","en"), retryOnRateLimit = 120 )
tweets3000 <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 3000, lang = c("es","en"), retryOnRateLimit = 120 )
tweets3000_3_12 <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 3000, lang = c("es","en"), retryOnRateLimit = 120 )
tweets3000_3_13 <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 3000, lang = c("es","en"), retryOnRateLimit = 120 )
tweets3000_3_14 <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 3000, lang = c("es","en"), retryOnRateLimit = 120 )
tweets3000_3_15 <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 3000, lang = c("es","en"), retryOnRateLimit = 120 )
tweets3000_3_16 <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 3000, lang = c("es","en"), retryOnRateLimit = 120 )
tweets3000_3_18 <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 3000, lang = c("es","en"), retryOnRateLimit = 120 )
tweets3000_3_19 <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 3000, lang = c("es","en"), retryOnRateLimit = 120 )
tweets3000_3_20 <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 3000, lang = c("es","en"), retryOnRateLimit = 120 )
tweets3000_3_21 <- searchTwitter("Venezuela OR #Venezuela OR Maduro OR #Maduro", n = 3000, lang = c("es","en"), retryOnRateLimit = 120 )


# Convert the pulled tweets, which are class type list, from the previous step into a Data Frame in order to analyze the data.

tweets.df500 <- twListToDF(tweets500)
tweets.df750 <- twListToDF(tweets750)
tweets.df900 <- twListToDF(tweets900)
tweets.df1500 <- twListToDF(tweets1500)
tweets.df3000 <- twListToDF(tweets3000)
tweets.df3000_3_12 <- twListToDF(tweets3000_3_12)
tweets.df3000_3_13 <- twListToDF(tweets3000_3_13)
tweets.df3000_3_14 <- twListToDF(tweets3000_3_14)
tweets.df3000_3_15 <- twListToDF(tweets3000_3_15)
tweets.df3000_3_16 <- twListToDF(tweets3000_3_16)
tweets.df3000_3_18 <- twListToDF(tweets3000_3_18)
tweets.df3000_3_19 <- twListToDF(tweets3000_3_19)
tweets.df3000_3_20 <- twListToDF(tweets3000_3_20)
tweets.df3000_3_21 <- twListToDF(tweets3000_3_21)

# We need to add a column to each data frame that adds the source of the tweet. We store this in a new variable so we won't edit the source.
tweets.df500.ec <- mutate(tweets.df500,source_data="tweets.df500")
tweets.df750.ec <- mutate(tweets.df750,source_data="tweets.df750")
tweets.df900.ec <- mutate(tweets.df900,source_data="tweets.df900")
tweets.df1500.ec <- mutate(tweets.df1500,source_data="tweets.df1500")
tweets.df3000.ec <- mutate(tweets.df3000,source_data="tweets.df3000")
tweets.df3000_3_12.ec <- mutate(tweets.df3000_3_12,source_data="tweets.df3000_3_12")
tweets.df3000_3_13.ec <- mutate(tweets.df3000_3_13,source_data="tweets.df3000_3_13")
tweets.df3000_3_14.ec <- mutate(tweets.df3000_3_14,source_data="tweets.df3000_3_14")
tweets.df3000_3_15.ec <- mutate(tweets.df3000_3_15,source_data="tweets.df3000_3_15")
tweets.df3000_3_16.ec <- mutate(tweets.df3000_3_16,source_data="tweets.df3000_3_16")
tweets.df3000_3_18.ec <- mutate(tweets.df3000_3_18,source_data="tweets.df3000_3_18")
tweets.df3000_3_19.ec <- mutate(tweets.df3000_3_19,source_data="tweets.df3000_3_19")
tweets.df3000_3_20.ec <- mutate(tweets.df3000_3_20,source_data="tweets.df3000_3_20")
tweets.df3000_3_21.ec <- mutate(tweets.df3000_3_21,source_data="tweets.df3000_3_21")

# In order to ensure that all the pulled tweets are stored, we combine all the pulled tweets regardless of the day they were pulled into a single Data Frame using rbind.
#tweets.df.all <- rbind(tweets.df500.ec,tweets.df750.ec,tweets.df900.ec,tweets.df1500.ec,tweets.df3000.ec,tweets.df3000_3_12.ec,tweets.df3000_3_13.ec,tweets.df3000_3_14.ec,tweets.df3000_3_15.ec)
#Save the initial pull of data to a csv file, this adds one column of row counts.
#write.csv(tweets.df.all,file = "C:/Users/brian.perez/DataScience/rtweetvenba/tweets.df.all.csv")

#Read the data that has been saved previously, to ensure that we can append new data. 
test <- read.csv("C:/Users/brian.perez/DataScience/rtweetvenba/tweets.df.all.csv", header = TRUE,stringsAsFactors = FALSE)

#Once the new sets of tweets have been pulled and the old tweets from the file are loaded, then we want
#to append the new pull to the old data, and save it to the existing file.
write.csv(rbind(select(test,-1),tweets.df3000_3_21.ec), file = "C:/Users/brian.perez/DataScience/rtweetvenba/tweets.df.all.csv")

# Read the new csv file into a DF. This ensures that we are working with the latest tweets.
test_upd <- read.csv("C:/Users/Ash/DataSci101/rtweetvenba/tweets.df.all.csv", header = TRUE,stringsAsFactors = FALSE)

# Remove duplicates based on text, created, screenName, statusSource. 
test_rmv_dups <- distinct(test_upd, text, created, screenName,statusSource,.keep_all = TRUE)

# Seperate statusSource based on the sep > in order to see where the source of the Tweet (Android, Iphone, Ipad)
# Example of StatusSource: <a href="http://twitter.com/download/iphone" rel="nofollow">Twitter for iPhone</a>
test_rmv_dups_sep <- separate(test_rmv_dups,statusSource, c("URL","Platform"),sep=">")
test_rmv_dups_sep1 <- separate(test_rmv_dups_sep,Platform, c("Platform","Remove"),sep="<")

# Remove the unnecasarry columns that resulted from separating statusSource.
test_rmv_dups_sep2 <- select(test_rmv_dups_sep1,-URL,-Remove)

# Create a DF with only the Platform used
commonPlatform <- select(test_rmv_dups_sep2,Platform)

# Create a variable that holds the frequency of the common platforms used
# Source: https://stackoverflow.com/questions/24576515/relative-frequencies-proportions-with-dplyr/24576703
commonPlatform_freq <- summarize(group_by(commonPlatform,Platform),freq=n())

# Arrange the common platform in descending order, to see which type of device/platform was most used.
commonPlatform_freq_desc <- arrange(commonPlatform_freq, desc(freq))

# Add the proportion to the common platfrom
commonPlatform_prop <- mutate(commonPlatform_freq_desc,prop=freq*100/sum(freq))

# Create a DF with only the screenNames
commonUsers <- select(test_rmv_dups_sep2,screenName)

# Create a variable that holds the frequency of the users. i.e. Show's the amount of tweets each user has in the data set has sent
commonUsers_freq <- summarize(group_by(commonUsers,screenName),freq=n())

# Arrange the commonUsers_freq by descending order, to see the screename with most tweets.
commonUsers_freq_desc <- arrange(commonUsers_freq,desc(freq))

# Add the proportion to the common users
commonUsers_prop <- mutate(commonUsers_freq_desc,prop=freq*100/sum(freq))

# We want to find out the location of the tweets based on the latitude and longtiude variables/columns. 
# We removed the NAs using the drop_na tidyr function. 
# Source: https://stackoverflow.com/questions/4862178/remove-rows-with-nas-missing-values-in-data-frame
# Another way to accomplish this task is to use the following dplyr filter function: 
# test_lat_long <- filter(test_lat_long_1, !is.na(latitude), !is.na(longitude))
test_lat_long1 <- drop_na(test_rmv_dups_sep2, latitude, longitude)

#Save test_lat_long df as a CSV file to upload into ArcGIS online and create map.
write.csv(test_lat_long1,file = "C:/Users/Ash/DataSci101/rtweetvenba/test_lat_long.csv", row.names = FALSE)
#TO DO: 1) CREATE R MARKDOWN FILE FROM HERE 2) EMBED MAPS IN FILE
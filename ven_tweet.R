library(twitteR)
library(rtweet)
# Information needed to pull data from twitter. This will vary based on your own twitter account. 
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
#Before we join all this data we want to make sure that they are indeed similar (they should given that they were pulled in the same way)
# We need to figure out that all the pulls have the same headers and are of the same type.

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
# In order to ensure that all the pulled tweets are stored, we combine all the pulled tweets regardless of the day they were pulled into a single Data Frame using rbind.
# This works given that each pull consists of the same variables.
#rbind(<list all the data frames from the section above)
tweets.df.all <- rbind(tweets.df500.ec,tweets.df750.ec,tweets.df900.ec,tweets.df1500.ec,tweets.df3000.ec,tweets.df3000_3_12.ec,tweets.df3000_3_13.ec,tweets.df3000_3_14.ec,tweets.df3000_3_15.ec)
tweets.df.all1 <- rbind(tweets.df.all1,tweets.df3000_3_18.ec)
#Save the entire tweets into a csv file for further analysis
write.csv(tweets.df.all1, file = "tweets.df.all.csv")
write.csv(rbind(tweets.df.all,tweets.df3000_3_16.ec), file = "tweets.df.all1.csv")


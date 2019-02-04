#load library
library(twitteR)
library(tm)
library(syuzhet)
library(SnowballC)


#load credentials
consumer_key <- ""
consumer_secret<- ""
access_token <- ""
access_secret <- ""
#set up to authenticate
setup_twitter_oauth(consumer_key ,consumer_secret,access_token ,access_secret)

tweets <- searchTwitter("#souq", n=10000, lang = "en")
tweets <- strip_retweets(tweets)
#tweets <- userTimeline("narendramodi", n=1000)
tweets.df <- twListToDF(tweets) 

#tweets.df2 <- gsub("http.*","",tweets.df$text)
#tweets.df2 <- gsub("https.*","",tweets.df2)
#tweets.df2 <- gsub("#.*","",tweets.df2)
#tweets.df2 <- gsub("@.*","",tweets.df2)


word.df <- as.vector(tweets.df2)

emotion.df <- get_nrc_sentiment(word.df)

emotion.df2 <- cbind(tweets.df2, emotion.df) 

sent.value <- get_sentiment(word.df)

most.positive <- word.df[sent.value == max(sent.value)]

most.negative <- word.df[sent.value <= min(sent.value)] 
most.negative

category_senti <- ifelse(sent.value < 0, "Negative", ifelse(sent.value > 0, "Positive", "Neutral"))
table(category_senti)

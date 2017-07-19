# Twitter Sentiment Analysis
#
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

# #Set Working directory
# setwd("D:/Qlikview/RestApi/")
#rm(list=ls())

# printdata <- function(ddata){
#   ddata <- data.frame(ddata)
#   print(ddata)
#   print(class(ddata))
#   plot(ddata)
# }


# binddata <- function(id,text,created){
#
#   return(data.frame(id,text,created))
#
#   print(df_tweets)
#
# }

#df_tweets <- binddata(id,text,created)

#tweet_senti(df_tweets)

# tweet_senti <- function (df_tweets) {
#   test <- null
#   ddataa <- cbind(df_tweets,test)
#   print(ddataa)
# }
#


tweet_senti <- function (df_tweets) {

  # loading packages
  library(twitteR)
  library(ROAuth)
  library(tidyverse)
  library(text2vec)
  library(caret)
  library(glmnet)
  library(ggrepel)
  library(plyr)
  library(dplyr)
  library(ggplot2)
  #library(purrrlyr, lib.loc = "library/")
  #library(purrrlyr)

  # id <- as.integer(df_tweets$id)
  # text <- as.character(df_tweets$text)
  # created <- as.character(df_tweets$created)

  df_tweets <- data.frame(df_tweets)

  df_tweets$id <- as.integer(df_tweets$id)
  df_tweets$text <- as.character(df_tweets$text)
  df_tweets$created <- as.character(df_tweets$created)

  ##### Vectorization #####
# define preprocessing function and tokenization function
  prep_fun <- tolower
  tok_fun <- word_tokenizer

# Load Pretrained Model

 #load("vocab.RData")
  vectorizer <- vocab_vectorizer(vocab)

# define tf-idf model

  tfidf <- TfIdf$new()

  #load("data/df_tweet.RData")

# preprocessing and tokenization
it_tweets <- itoken(df_tweets$text,
                    preprocessor = prep_fun,
                    tokenizer = tok_fun,
                    ids = df_tweets$id,
                    progressbar = TRUE)

# creating vocabulary and document-term matrix
dtm_tweets <- create_dtm(it_tweets, vectorizer)

# fit the model to the train data and transform it with the fitted model
dtm_train_tfidf <- fit_transform(dtm_tweets, tfidf)


# transforming data with tf-idf
dtm_tweets_tfidf <- fit_transform(dtm_tweets, tfidf)

# loading classification model
#glmnet_classifier <- readRDS('data/glmnet_classifier.RDS')
#save(glmnet_classifier,file="glmnet_classifier.RData")

# predict probabilities of positiveness
preds_tweets <- predict(glmnet_classifier, dtm_tweets_tfidf, type = 'response')[ ,1]

# adding rates to initial dataset
df_tweets$sentiment <- preds_tweets

#total score calculation: positive / negative / neutral
df_tweets$created <- as.Date(df_tweets$created , format = "%m/%d/%Y")
df_tweets <- mutate(df_tweets, score=ifelse(df_tweets$sentiment > 0.65, 'positive', ifelse(df_tweets$sentiment < 0.35, 'negative', 'neutral')))
by.tweet <- group_by(df_tweets, score, created)
by.tweet <- summarise(by.tweet, number=n())

#chart
ggplot(by.tweet, aes(created, number)) + geom_line(aes(group=score, color=score), size=2) +
  geom_point(aes(group=score, color=score), size=4) +
  theme(text = element_text(size=18), axis.text.x = element_text(angle=90, vjust=1)) +
 #stat_summary(fun.y = 'sum', fun.ymin='sum', fun.ymax='sum', colour = 'yellow', size=2, geom = 'line') +
  ggtitle('Humira')


# #return(df_tweets)
#
# #write.csv(df_tweets,"tweet_sentiment.csv",row.names = FALSE)
#
# # color palette
#  cols <- c("#ce472e", "#f05336", "#ffd73e", "#eec73a", "#4ab04a")
#
#  set.seed(932)
#  samp_ind <- sample(c(1:nrow(df_tweets)), nrow(df_tweets) * 0.1) # 10% for labeling
# #
# # # plotting
# #plt <-
#   ggplot(df_tweets, aes(x = created, y = sentiment, color = sentiment)) +
#    theme_minimal() +
#    scale_color_gradientn(colors = cols, limits = c(0, 1),
#                          breaks = seq(0, 1, by = 1/4),
#                          labels = c("0", round(1/4*1, 1), round(1/4*2, 1), round(1/4*3, 1), round(1/4*4, 1)),
#                          guide = guide_colourbar(ticks = T, nbin = 50, barheight = .5, label = T, barwidth = 10)) +
#    geom_point(aes(color = sentiment), alpha = 0.8) +
#    geom_hline(yintercept = 0.65, color = "#4ab04a", size = 1.5, alpha = 0.6, linetype = "longdash") +
#    geom_hline(yintercept = 0.35, color = "#f05336", size = 1.5, alpha = 0.6, linetype = "longdash") +
#    geom_smooth(size = 1.2, alpha = 0.2) +
#    geom_label_repel(data = df_tweets[samp_ind, ],
#                     aes(label = round(sentiment, 2)),
#                     fontface = 'bold',
#                     size = 2.5,
#                     max.iter = 100) +
#    theme(legend.position = 'bottom',
#          legend.direction = "horizontal",
#          panel.grid.major = element_blank(),
#          panel.grid.minor = element_blank(),
#          plot.title = element_text(size = 20, face = "bold", vjust = 2, color = 'black', lineheight = 0.8),
#          axis.title.x = element_text(size = 16),
#          axis.title.y = element_text(size = 16),
#          axis.text.y = element_text(size = 8, face = "bold", color = 'black'),
#          axis.text.x = element_text(size = 8, face = "bold", color = 'black')) +
#    ggtitle("Tweets Sentiment rate (probability of positiveness)")

# #return(plt)

}





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
 id <- as.integer(df_tweets$id)
  text <- as.character(df_tweets$text)
  created <- as.character(df_tweets$created)
  df_tweets <- data.frame(id,text,created)
df_tweets$id <- as.integer(df_tweets$id)
 df_tweets$text <- as.character(df_tweets$text)
  df_tweets$created <- as.character(df_tweets$created)
  print(str(df_tweets))

}

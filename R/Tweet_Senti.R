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
# rm(list=ls())

tweet_senti <- function (df_tweets) {

  # loading packages
  library(twitteR)
  library(ROAuth)
  library(tidyverse)
  library(text2vec)
  library(caret)
  library(glmnet)
  library(ggrepel)
  #library(purrrlyr, lib.loc = "library/")
  #library(purrrlyr)

  ##### Vectorization #####
  # define preprocessing function and tokenization function
  prep_fun <- tolower
  tok_fun <- word_tokenizer

  # Load Pretrained Model

load("data/df_tweet.RData")
  vectorizer <- vocab_vectorizer(vocab)

  # define tf-idf model

  tfidf <- TfIdf$new()


return(df_tweets)


}

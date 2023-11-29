library(dplyr)
library(polite)
library(xml2)
library(magrittr)
library(rvest)
library(httr)

polite::use_manners(save_as = "polite_scrape.R")

url <- 'https://www.imdb.com/chart/toptv/?ref_=nv_tvv_250'
session <- bow(url,
               user_agent = "Educational")
session

title <- character(0)
rank <- character(0)
rating <- character(0)
numPeopleVoted <- character(0)
numEpisodes <- character(0)
numYear <- character(0)
numSplit <- c()

title <- scrape(session) %>%
  html_nodes('h3.ipc-title__text') %>%
  html_text
title[1:51]

##rank <- scrape(session) %>%
  html_nodes('')

rating <- scrape(session) %>%
  html_nodes('span.ratingGroup--imdb-rating')%>%
  html_text

numPeopleVoted <- scrape(session) %>%
  html_nodes('span.ipc-rating-star--voteCount') %>%
  html_text

 numSplit <- scrape(session) %>%
    html_nodes('span.sc-479faa3c-8') %>%
    html_text
 numSplit
 View(numSplit)
mode(numSplit)
splitDF <- strsplit(as.character(numSplit)," ", fixed = TRUE)

numSplit 
numSplit <- as.vector(numSplit)

retrievedEpisode <- character()


retrievedEpisoderetrievedEpisode <- character()

for(i in seq(2, length(numSplit), by = 3) ){
  currentEpisode <- numSplit[i]
  retrievedEpisode <- c(retrievedEpisode, currentEpisode)
}


retrievedEpisode

numSplit[746]

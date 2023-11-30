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
rank <- 1:50
rating <- character(0)
numVoteCount <- character(0)
numEpisodes <- character(0)
numYear <- character(0)
numSplit <- c()

#Scraping the Title.
title <- scrape(session) %>%
  html_nodes('h3.ipc-title__text') %>%
  html_text
title <- title[2:51]

#Scraping the rating.
rating <- scrape(session) %>%
  html_nodes('span.ratingGroup--imdb-rating')%>%
  html_text
rating <- rating[1:50]

#Scraping the Vote Count.
numVoteCount <- scrape(session) %>%
  html_nodes('span.ipc-rating-star--voteCount') %>%
  html_text
numVoteCount <- numVoteCount[1:50]

#Scraping the span: Year, Number of Episodes, and Year Released.
numSplit <- scrape(session) %>%
  html_nodes('span.sc-479faa3c-8') %>%
  html_text
numSplit

#Get the number of Episodes
retrievedEpisode <- character()

for(i in seq(2, length(numSplit), by = 3) ){
  currentEpisode <- numSplit[i]
  retrievedEpisode <- c(retrievedEpisode, currentEpisode)
}

numEpisodes <- retrievedEpisode[1:50]
numEpisodes


#Get the year it was released
retrievedYear <- character()
for(i in seq(1, length(numSplit), by = 3) ){
  currentYear <- numSplit[i]
  retrievedYear <- c(retrievedYear, currentYear)
}

numYear <- retrievedYear[1:50]
numYear

updateYear <- sub("^(\\d{4}).*", "\\1", numYear)
updateRating <- sub("^(\\d+\\.\\d+).*", "\\1", rating)

updateVoteCount <- sub(".*?\\s*\\((\\S+)\\).*", "\\1", numVoteCount)

splitTitle <- gsub("\\d+\\.\\s", "", title)
splitTitle

wholeDF <- data.frame(rank, splitTitle, updateRating,updateVoteCount , numEpisodes, updateYear)
colnames(wholeDF) <- c("Rank", "Title", "Rating", "Vote Count", "Number of Episodes", "Year Released")
View(wholeDF)



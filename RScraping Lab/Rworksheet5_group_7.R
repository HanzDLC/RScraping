

library(dplyr)
library(polite)
library(xml2)
library(magrittr)
library(rvest)
library(httr)
library(ggplot2)










#Movie Guide
#m1 - Breaking Bad
#m2 - Game of Thrones
#m3 - Arcane
#m4 - Death Note
#m5 - Better Call Saul

polite::use_manners(save_as = "polite_scrape.R")


url <- 'https://www.imdb.com/chart/toptv/?ref=nv_tvv_250'
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
  html_nodes('span.sc-43986a27-8') %>%
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

updateYear <- sub("^(\d{4}).", "\1", numYear)
updateRating <- sub("^(\d+\.\d+).", "\1", rating)

updateVoteCount <- sub(".?\s\((\S+)\).*", "\1", numVoteCount)

splitTitle <- gsub("\d+\.\s", "", title)
splitTitle

wholeDF <- data.frame(rank, splitTitle, updateRating,updateVoteCount , numEpisodes, updateYear)
colnames(wholeDF) <- c("Rank", "Title", "Rating", "Vote Count", "Number of Episodes", "Year Released")
View(wholeDF)

url_m1 <- 'https://www.imdb.com/title/tt0903747/reviews?spoiler=hide&sort=curated&dir=desc&ratingFilter=0'
url_m2 <- 'https://www.imdb.com/title/tt0944947/reviews?spoiler=hide&sort=curated&dir=desc&ratingFilter=0'
url_m3 <- 'https://www.imdb.com/title/tt11126994/reviews?spoiler=hide&sort=curated&dir=desc&ratingFilter=0'
url_m4 <- 'https://www.imdb.com/title/tt0877057/reviews?spoiler=hide&sort=curated&dir=desc&ratingFilter=0'
url_m5 <- 'https://www.imdb.com/title/tt3032476/reviews?spoiler=hide&sort=curated&dir=desc&ratingFilter=0'
tvShowDateURL <- 'https://www.imdb.com/chart/toptv/?ref_=nv_tvv_250'



session_m1 <- bow(url_m1,
                  user_agent = "Educational")
session_m2 <- bow(url_m2,
                  user_agent = "Educational")
session_m3 <- bow(url_m3,
                  user_agent = "Educational")
session_m4 <- bow(url_m4,
                  user_agent = "Educational")
session_m5 <- bow(url_m5,
                  user_agent = "Educational")
session_m6 <- bow(tvShowDateURL,
                  user_agent = "Educational")

session_m1
session_m2
session_m3
session_m4
session_m5
session_m6

reviewerName_m1 <- character(0)
dateReviewed_m1 <- character(0)
userRating_m1 <- character(0)
titleReview_m1 <- character(0)
textReview_m1 <- character(0)

reviewerName_m2 <- character(0)
dateReviewed_m2 <- character(0)
userRating_m2 <- character(0)
titleReview_m2 <- character(0)
textReview_m2 <- character(0)

reviewerName_m3 <- character(0)
dateReviewed_m3 <- character(0)
userRating_m3 <- character(0)
titleReview_m3 <- character(0)
textReview_m3 <- character(0)

reviewerName_m4 <- character(0)
dateReviewed_m4 <- character(0)
userRating_m4 <- character(0)
titleReview_m4 <- character(0)
textReview_m4 <- character(0)

reviewerName_m5 <- character(0)
dateReviewed_m5 <- character(0)
userRating_m5 <- character(0)
titleReview_m5 <- character(0)
textReview_m5 <- character(0)

tvShowTitle <- character(0)
tvShowDates <- character(0)


#Breaking Bad
tv_m1 <- scrape(session_m1) %>% 
  html_elements('div.lister-item')

reviewerName_m1 <- tv_m1 %>%
  html_nodes('span.display-name-link') %>%
  html_text()

dateReviewed_m1 <- tv_m1 %>%
  html_nodes('span.review-date') %>%
  html_text()

userRating_m1 <- tv_m1 %>% 
  html_node(".rating-other-user-rating") %>% 
  html_text()

titleReview_m1 <- tv_m1 %>%
  html_nodes('a.title') %>%
  html_text()

textReview_m1 <- tv_m1 %>%
  html_nodes('div.text.show-more__control') %>%
  html_text()

DF_m1 <- data.frame(userRating_m1, dateReviewed_m1, reviewerName_m1, titleReview_m1, textReview_m1)
colnames(DF_m1) <- c("User Rating", "Date Reviewed", "Reviewer Name", "Title Review", "Text Review")

View(DF_m1)


#Game of Thrones

tv_m2 <- scrape(session_m2) %>% 
  html_elements('div.lister-item')

reviewerName_m2 <- tv_m2 %>%
  html_nodes('span.display-name-link') %>%
  html_text()

dateReviewed_m2 <- tv_m2 %>%
  html_nodes('span.review-date') %>%
  html_text()

userRating_m2 <- tv_m2 %>% 
  html_node(".rating-other-user-rating") %>% 
  html_text()

titleReview_m2 <- tv_m2 %>%
  html_nodes('a.title') %>%
  html_text()

textReview_m2 <- tv_m2 %>%
  html_nodes('div.text.show-more__control') %>%
  html_text()


DF_m2 <- data.frame(userRating_m2, dateReviewed_m2, reviewerName_m2, titleReview_m2, textReview_m2)
colnames(DF_m2) <- c("User Rating", "Date Reviewed", "Reviewer Name", "Title Review", "Text Review")
View(DF_m2)


#Arcane 
tv_m3 <- scrape(session_m3) %>% 
  html_elements('div.lister-item')

reviewerName_m3 <- tv_m3 %>%
  html_nodes('span.display-name-link') %>%
  html_text()

dateReviewed_m3 <- tv_m3 %>%
  html_nodes('span.review-date') %>%
  html_text()

userRating_m3 <- tv_m3 %>% 
  html_node(".rating-other-user-rating") %>% 
  html_text()

titleReview_m3 <- tv_m3 %>%
  html_nodes('a.title') %>%
  html_text()

textReview_m3 <- tv_m3 %>%
  html_nodes('div.text.show-more__control') %>%
  html_text()

DF_m3 <- data.frame(userRating_m3, dateReviewed_m3, reviewerName_m3, titleReview_m3, textReview_m3)
colnames(DF_m3) <- c("User Rating", "Date Reviewed", "Reviewer Name", "Title Review", "Text Review")

View(DF_m3)


#Death Note

tv_m4 <- scrape(session_m4) %>% 
  html_elements('div.lister-item')

reviewerName_m4 <- tv_m4 %>%
  html_nodes('span.display-name-link') %>%
  html_text()

dateReviewed_m4 <- tv_m4 %>%
  html_nodes('span.review-date') %>%
  html_text()

userRating_m4 <- tv_m4 %>% 
  html_node(".rating-other-user-rating") %>% 
  html_text()

titleReview_m4 <- tv_m4 %>%
  html_nodes('a.title') %>%
  html_text()

textReview_m4 <- tv_m4 %>%
  html_nodes('div.text.show-more__control') %>%
  html_text()

DF_m4 <- data.frame(userRating_m4, dateReviewed_m4, reviewerName_m4, titleReview_m4, textReview_m4)
colnames(DF_m4) <- c("User Rating", "Date Reviewed", "Reviewer Name", "Title Review", "Text Review")

View(DF_m4)


#Better Call Saul

tv_m5 <- scrape(session_m5) %>% 
  html_elements('div.lister-item')

reviewerName_m5 <- tv_m5 %>%
  html_nodes('span.display-name-link') %>%
  html_text()

dateReviewed_m5 <- tv_m5 %>%
  html_nodes('span.review-date') %>%
  html_text()

userRating_m5 <- tv_m5 %>% 
  html_node(".rating-other-user-rating") %>% 
  html_text()

titleReview_m5 <- tv_m5 %>%
  html_nodes('a.title') %>%
  html_text()

textReview_m5 <- tv_m5 %>%
  html_nodes('div.text.show-more__control') %>%
  html_text()

DF_m5 <- data.frame(userRating_m5, dateReviewed_m5, reviewerName_m5, titleReview_m5, textReview_m5)
colnames(DF_m5) <- c("User Rating", "Date Reviewed", "Reviewer Name", "Title Review", "Text Review")

View(DF_m5)

#TV Shows Time Series Graph

tvShows <- scrape(session_m6) %>% 
  html_elements('ul.ipc-metadata-list')


tvShowTitle <- tvShows %>%
  html_nodes('h3.ipc-title__text') %>%
  html_text()

tvShowDates <- tvShows %>%
  html_nodes('div.sc-43986a27-7') %>%
  html_text()

tvShowDates <- substr(tvShowDates, 1, 4)
tvShowDates

tvShowDF <- data.frame(tvShowTitle,tvShowDates)
colnames(tvShowDF) <- c("TV Show Title","Year_Released")


tvShowDF <- head(tvShowDF,50)
View(tvShowDF)
tvShowDF$Year_Released <- substr(tvShowDF$Year_Released, 1, 4)

tvShowDF$Year_Released <- as.numeric(tvShowDF$Year_Released)
ggplot(tvShowDF, aes(x = Year_Released)) +
  geom_bar(stat = "count", fill = "blue") +
  labs(title = "Number of TV Shows Released Each Year",
       x = "Year Released",
       y = "Number of TV Shows")
        scale_x_continuous(breaks = unique(tvShowDF$Year_Released), expand = c(0, 0))

cat("The year(s) that have the most number of TV shows released are year 2011 and year 2014")



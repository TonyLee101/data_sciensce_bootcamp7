# static website

library(rvest)
library(tidyverse)
library(stringr)

url <- "https://www.imdb.com/search/title/?groups=top_100&sort=user_rating,desc"
url2 <- "https://www.imdb.com/search/title/?groups=top_100&sort=user_rating,desc&start=51&ref_=adv_nxt" 

movie_name1 <- url %>%
  read_html() %>%
  html_elements("h3.lister-item-header") %>%
  html_text2()
movie_name1_clean <- str_remove(movie_name1, "^[0-9]+\\. ")

movie_name2 <- url2 %>%
  read_html() %>%
  html_elements("h3.lister-item-header") %>%
  html_text2()
movie_name2_clean <- str_remove(movie_name2, "^[0-9]+\\.\\s+") ##Note "\\s+" == " "

ratings1 <- url %>%
  read_html() %>%
  html_elements("div.ratings-imdb-rating") %>%
  html_text2() %>%
  as.numeric()

ratings2 <- url2 %>%
  read_html()  %>%
  html_elements("div.inline-block.ratings-imdb-rating") %>%
  html_text2() %>%
  as.numeric()

votes1 <- url %>%
  read_html() %>%
  html_elements("p.sort-num_votes-visible span:nth-child(2)") %>%
  html_text2() %>%
  str_remove_all(",") %>%
  as.numeric()

votes2 <- url2 %>%
  read_html() %>%
  html_nodes("p.sort-num_votes-visible span:nth-child(2)") %>%
  html_text()%>%
  str_remove_all(",") %>%
  as.numeric()

movies_name <- data.frame(movie_name = c(movie_name1_clean, movie_name2_clean))
ratings <- data.frame(ratings = c(ratings1, ratings2))
votes <- data.frame(votes = c(votes1, votes2))

df <- tibble(movies_name, ratings, votes)
View(df)

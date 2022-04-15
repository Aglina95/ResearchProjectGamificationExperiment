library(readxl)
library(tidyverse)
library(writexl)
#load the data
perceivedcompetencedf <- read_excel("PerceivedCompetence.xlsx")

#calculate reverse
#demographicsdf$Likert14Rev <- 8 - demographicsdf$Likert14

#calculate the average of specific columns
perceivedcompetencedf$mean <- rowMeans(subset(perceivedcompetencedf, select = c ("Likert4", "Likert7", "Likert12", "Likert16",
                                                                   "Likert22")), na.rm = TRUE)
perceivedcompetencedf



write.csv(perceivedcompetencedf,"C:\\Users\\serenity\\Desktop\\Rtutorials\\PerceivedCompetenceQuan.csv", row.names = FALSE)
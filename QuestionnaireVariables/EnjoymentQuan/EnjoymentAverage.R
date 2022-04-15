library(readxl)
library(tidyverse)
library(writexl)
#load the data
enjoymentdf <- read_excel("Enjoyment.xlsx")

#calculate the average of specific columns
enjoymentdf$mean <- rowMeans(subset(enjoymentdf, select = c ("Likert1", "Likert5", "Likert8", "Likert10",
                 "Likert14", "Likert17", "Likert20")), na.rm = TRUE)
#calculate reverse
#enjoymentdf$Likert14Rev <- 8 - demographicsdf$Likert14
enjoymentdf



writexl::write_xlsx(enjoymentdf,"C:\\Users\\serenity\\Desktop\\Rtutorials\\EnjoymentQuan.xlsx")

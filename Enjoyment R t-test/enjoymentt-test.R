library("readxl")
if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/ggpubr")
install.packages("ggpubr")

1

enjoymentdf <- read_excel("EnjoymentRT-test.xlsx")

#use both results (two sided and greater) IMI t-test calculation.
#variable = Enjoyment
#Probably game condition participants didn't attempt more times because of enjoyment.
#or maybe the number of the attempts is affected by other factors. 
t.test(enjoymentdf$Game, enjoymentdf$Task,
       alternative = "two.sided",
       paired = FALSE,
       var.equal = FALSE)
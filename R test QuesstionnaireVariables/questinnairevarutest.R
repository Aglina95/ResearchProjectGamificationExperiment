library("readxl")
if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/ggpubr")
install.packages("ggpubr")

1
#run test for enjoyment
enjoymentdf <- read_excel("Enjoyment Scores.xlsx")

shapiro.test(enjoymentdf$Game)
shapiro.test(enjoymentdf$Task)

wilcox.test(enjoymentdf$Game, enjoymentdf$Task, paired = FALSE)

#run test for perceived competence
perceivedcompdf <- read_excel("Perceived Competence Scores.xlsx")

shapiro.test(perceivedcompdf$Game)
shapiro.test(perceivedcompdf$Task)

#T-Test. first find if variance is equal 
var.test(perceivedcompdf$Game, perceivedcompdf$Task)

t.test(perceivedcompdf$Game, perceivedcompdf$Task,
alternative = "two.sided",
paired = FALSE,
var.equal = TRUE)

#Perceived Choice
perceivedchoicepdf <- read_excel("Perceived Choice Scores.xlsx")

#find if data is normally distributed
shapiro.test(perceivedchoicepdf$Game)
shapiro.test(perceivedchoicepdf$Task)

#T-Test. first find if variance is equal 
var.test(perceivedchoicepdf$Game, perceivedchoicepdf$Task)

t.test(perceivedchoicepdf$Game, perceivedchoicepdf$Task,
       alternative = "two.sided",
       paired = FALSE,
       var.equal = TRUE)

#Pressure/Tension
pressuretensionpdf <- read_excel("PressureTension Scores.xlsx")

#find if data is normally distributed
shapiro.test(pressuretensionpdf$Game)
shapiro.test(pressuretensionpdf$Task)

var.test(pressuretensionpdf$Game, pressuretensionpdf$Task)

t.test(pressuretensionpdf$Game, pressuretensionpdf$Task,
       alternative = "two.sided",
       paired = FALSE,
       var.equal = TRUE)

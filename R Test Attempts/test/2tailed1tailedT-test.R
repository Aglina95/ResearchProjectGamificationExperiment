library("readxl")
if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/ggpubr")
install.packages("ggpubr")

1

attemptsdf <- read_excel("R t-test Attempts.xlsx")

shapiro.test(attemptsdf$Game)
shapiro.test(attemptsdf$Task)

#U-test
wilcox.test(attemptsdf$Game, attemptsdf$Task, paired = FALSE)



#W = 65, p-value = 0.08834
#The p-value is greater than 0.05 and that means that we don’t reject 
#the null hypothesis. Therefore, there’s no difference between the medians 
#of the two groups. We failed to reject the null hypothesis and that means 
#that there’s no statistical difference between Game and Task condition. 

#T-Test
#var.test(attemptsdf$Game, attemptsdf$Task)
#use both results. greater is significant whereas two.sided is not
#greater shows that game elements help to have more attempts while performing the task.
#greater (one tailed) is statistical significant.
#two sided shows id there is a statistical significance between the attempts of both groups.
#but it doesn't indicate any statistical difference
#t.test(attemptsdf$Game, attemptsdf$Task,
       #alternative = "greater",
       #paired = FALSE,
       #var.equal = FALSE)

#t.test(attemptsdf$Game, attemptsdf$Task,
       #alternative = "two.sided",
       #paired = FALSE,
       #var.equal = FALSE)




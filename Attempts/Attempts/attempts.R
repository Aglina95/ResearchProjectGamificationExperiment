

create_dataframe <- function(filename){
#load libraries
  library(readxl)
  library(tidyverse)
  #load the data
  dataframeexcel <- read_excel(filename)
  
  
  #delete columns(headers). you can modify the strings and delete the existing ones and add the columns you want to delete
  dfcolumnsremoved <- within(dataframeexcel, rm("Event Index", "UTC Timestamp", "UTC Date", 
                      "Local Timestamp", "Local Timezone",
                      "Local Date", "Experiment ID", 
                      "Experiment Version",
                      "Tree Node Key", "Repeat Key", 
                      "Schedule ID", 
                      "Participant Private ID",
                      "Participant Starting Group", 
                      "Participant Status",
                      "Participant Completion Code",
                      "Participant External Session ID", 
                      "Participant Device Type",
                      "Participant Device", "Participant OS", 
                      "Participant Browser",
                      "Participant Monitor Size", 
                      "Participant Viewport Size", 
                      "Checkpoint", "Task Version",
                      "Randomise questionnaire elements?", "Task Name",
                      "Spreadsheet","Next", "Spreadsheet Name",
                      "Spreadsheet Row", "Trial Number", "Screen Number",
                      "Screen Name", "Zone Name", "Zone Type", "Reaction Time",	
                      "Reaction Onset",	"Response Type",	"Response",
                      "Attempt",	"Correct",	"Incorrect",	"Dishonest",	
                      "X Coordinate",	"Y Coordinate",	"Timed Out",	"randomise_blocks",
                      "randomise_trials",	"display",	"ANSWER",	"Primers",
                      "WordList",	"correct",	"incorrect",	"Pc",	"total", "correctScore",
                      "incorrectScore", "ScorePC", "totalScore"))
  
  #take the value that you need from row and create new individual dataframes to bind them afterwards
  participantsid <- dfcolumnsremoved[1, "Participant Public ID"]
  condition <- dfcolumnsremoved[1, "randomiser-msds"]
  
  #dropNAs
  dfnasremoved <- dfcolumnsremoved %>% 
    drop_na()
  
  
  #take the maximum value of a column
  attempts <- max(dfnasremoved$AttemptsTotal)
  
  #create new dataframe to bind 3 different dataframes
  participantattempts <- data.frame(participantsid,
                    condition, 
                    attempts)
  
  
  #binfdataframe by column another example
  #df_merge <- merge(df1,df2 ="col1")
  return(participantattempts)
}


#use this to create your dataframe. You can modify the variables and the values according
#based on your data
participantsidattempts <- create_dataframe(filename = "1.xlsx")#filename=the name of your excel file


filenames <- c("2.xlsx", "3.xlsx", "4.xlsx", "5.xlsx",
               "6.xlsx", "7.xlsx", "8.xlsx", "9.xlsx", "10.xlsx",
               "11.xlsx", "12.xlsx", "13.xlsx", "14.xlsx", "15.xlsx",
               "16.xlsx", "17.xlsx", "18.xlsx", "19.xlsx", "20.xlsx")

#for each file 
#for(filename in filenames) = define a variable so you take a single file everytime you run the for loop
#rbind is a function that you can use in R in order to bind different dataframes
for (filename in filenames) {
  participantsidattempts <- rbind(participantsidattempts, create_dataframe(filename))
}

participantsidattempts




write.csv(participantsidattempts,"C:\\Users\\serenity\\Desktop\\Rtutorials\\Attempts.csv", row.names = FALSE)






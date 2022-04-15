
create_dataframe <- function(filename){


  #load libraries
  library(readxl)
  library(tidyverse)
  #load the data
  X1 <- read_excel(filename)
  
  #REMOVE ROWS
  X1 <- X1[-c(1, 56, 57), ]
  
  #delete columns(headers). you can modify the strings and delete the existing ones and add the columns you want to delete
  df <- within(X1, rm("Event Index", "UTC Timestamp", "UTC Date", 
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
                       "Randomise questionnaire elements?", "Task Name"))
  
  #column to row. "Response" is the name of the column I wanted to convert to Row
  responseColumn <- df$`Response`
  responseRow <- t(responseColumn)
  
  #matrix to dataframe. responseRow was saved as a matrix at first, so I converted it to dataframe
  dataframe_data=as.data.frame(responseRow)
  
  
  
  new_names <- c('response-1',
                'response-1-quantised', 'Impressions',
                'Describing the experience', 'Challenges',
                'Improvements', 'Quite/Noisy', 'Quite/Noisy-quantised',
                'Other Distractions',
                 'Other Distractions-quantised',
                 'Likert1','Likert1-quantised','Likert2',
                 'Likert2-quantised','Likert3','Likert3-quantised',
                 'Likert4', 'Likert4-quantised','Likert5','Likert5-quantised',
                 'Likert6','Likert6-quantised','Likert7', 'Likert7-quantised',
                 'Likert8','Likert8-quantised','Likert9','Likert9-quantised',
                 'Likert10','Likert10-quantised', 'Likert11','Likert11-quantised',
                 'Likert12','Likert12-quantised','Likert13','Likert13-quantised',
                 'Likert14','Likert14-quantised','Likert15','Likert15-quantised',
                 'Likert16','Likert16-quantised','Likert17','Likert17-quantised',
                 'Likert18','Likert18-quantised','Likert19','Likert19-quantised',
                 'Likert20','Likert20-quantised','Likert21','Likert21-quantised',
                 'Likert22', 'Likert22-quantised')
  names(dataframe_data) <- new_names
  

  
  #The participant ID is in the first column of my dataset and thus I had to find a way to 
  #bind it to the rest of the columns. What I am doing here is I am telling the dataframe to take
  #the element-value from the first column and the first row of the dataframe
  dataframe_data[1, "Participant Public ID"] <- df[1, "Participant Public ID"]
  dataframe_data[2, "randomiser-msds"] <- df[2, "randomiser-msds"]
  

  
  return(dataframe_data)}


#use this to create your dataframe. You can modify the variables and the values according
#based on your data
questionnaire <- create_dataframe(filename = "1.xlsx")#filename=the name of your excel file


filenames <- c("2.xlsx", "3.xlsx", "4.xlsx", "5.xlsx",
               "6.xlsx", "7.xlsx", "8.xlsx", "9.xlsx", "10.xlsx",
               "11.xlsx", "12.xlsx", "13.xlsx", "14.xlsx", "15.xlsx",
               "16.xlsx", "17.xlsx", "18.xlsx", "19.xlsx", "20.xlsx")

#for each file 
#for(filename in filenames) = define a variable so you take a single file everytime you run the for loop
#rbind is a function that you can use in R in order to bind different dataframes
for (filename in filenames) {
  questionnaire <- rbind(questionnaire, create_dataframe(filename))
}

questionnaire




write.csv(questionnaire,"C:\\Users\\serenity\\Desktop\\Rtutorials\\Questionnaire12.csv", row.names = FALSE)
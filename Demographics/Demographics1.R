
#This is a function you can use in order to clean and modify your data
#I use this function to delete and rename columns. 
#I also use it in order to convert columns into rows.
#I use for loop in order to bind data from multiple excel sheets.(rows from other excel sheets)
create_dataframe <- function(filename){
  
  
  #load libraries
  library(readxl)
  library(tidyverse)
  #load the data
  X1 <- read_excel(filename)
  
  #delete columns(headers). you can modify the strings and delete the existing ones and add the columns you want to delete
  df <- within(X1, rm("UTC Timestamp", "UTC Date", 
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
                      "randomiser-msds", "Randomise questionnaire elements?", "Task Name"))
  
  #column to row. "Response" is the name of the column I wanted to convert to Row
  responseColumn <- df$`Response`
  responseRow <- t(responseColumn)
  
  #matrix to dataframe. responseRow was saved as a matrix at first, so I converted it to dataframe
  dataframe_data=as.data.frame(responseRow)
  
  
  #rename column headers. The last names are random and they are the result of a very stupid hack I had in mind.
  #I had extra column with no name and thus I couldn't delete them. So, I named them 
  #and you will see in the code below that I deleted them as well.
  #There is also code online which can help you to delete column with noname but it didn't work for me
  new_names <- c('Participant ID', 'Gender', 'Age', 'Country', 
                 'English Proficiency', 'Handedness', 'Random', 'Nope', 'Like', 'Ten', 'BB')
  names(dataframe_data) <- new_names
  
  
  #delete entire columns and their elements
  dataframe2 = subset(dataframe_data, select = -c(Age, Random, Ten, Like, BB) )
  
  #rename column headers. I did that in order to change the order of the column names
  #so that they can match the participants data because they weren't matching before
  new_names2 <- c('Participant Public ID', 'Gender', 'Age', 'Country', 
                  'English Proficiency', 'Handedness')
  names(dataframe2) <- new_names2
  
  
  #remove dataframes
  #rm("joined_df", "X1", "datademographics", "demographics")
  
  #The participant ID is in the first column of my dataset and thus I had to find a way to 
  #bind it to the rest of the columns. What I am doing here is I am telling the dataframe to take
  #the element-value from the first column and the first row of the excel file
  dataframe2[1, "Participant Public ID"] <- df[1, "Participant Public ID"]
  return(dataframe2)
}

#use this to create your dataframe. You can modify the variables and the values according
#based on your data
demographics <- create_dataframe(filename = "1.xlsx")#filename=the name of your excel file

#rm("example", "example1", "dataframe_data", "dataframe2")(this is just for me but in general rm function is for removing elements)

#assign your excel files to a variable
filenames <- c("2.xlsx", "3.xlsx", "4.xlsx", "5.xlsx",
               "6.xlsx", "7.xlsx", "8.xlsx", "9.xlsx", "10.xlsx",
               "11.xlsx", "12.xlsx", "13.xlsx", "14.xlsx", "15.xlsx",
               "16.xlsx", "17.xlsx", "18.xlsx", "19.xlsx", "20.xlsx")

#for each file 
#for(filename in filenames) = define a variable so you take a single file everytime you run the for loop
#rbind is a function that you can use in R in order to bind different dataframes
for (filename in filenames) {
  demographics <- rbind(demographics, create_dataframe(filename))
}

demographics

write.csv(demographics,"C:\\Users\\serenity\\Desktop\\Rtutorials\\Demographics.csv", row.names = FALSE)
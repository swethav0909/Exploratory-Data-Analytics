#Topics Covered in the week 2 Code file are as follows:
#Importing, Saving and MAnaging Data
#Workspace Management Functions
#Working directory
#Workspace
#Work with .RData Files
#Work with .txt Files



#This code is used for listing out the total number of objects exists in the current workspace.
ls()	
# This code is used to remove specific objects from the worksoace
rm(ozone)
# This code is used for excluding or removing all obejcts from the workspace.
rm(list = ls())	
#This Code is used for returning or see the current wworking directory (path)
getwd()	
# This code is used for changing the location for a working directory to a specified location
setwd("C:\Users\Swetha.Venkatapuram\Desktop\Practice Files")
#This code is used to get all the file names exists in the workind directory
list.files()
# This code writes the object x to other text file and defines how the columns 
#can be separated depending on the file type we need.
write.table(income, file = "mydata.txt",sep)	
# This code saves the specific objects to another location
save(ozone, file = "myimage.RData")	
# This code is to save all the objects from the workspace to the selected file
save.image(file = "myimage.RData")
# This code is used to load all the objects in the file selected.
load(file = "myimage.RData")
# This code reads a text file and defines how columns can be separated
read.table(file = "mydata.txt", header=TRUE)
# Below codes are used to create sample or test objects on our own that can be saved.
study1.df <- data.frame(id = 1:5, 
                        sex = c("m", "m", "f", "f", "m"), 
                        score = c(51, 20, 67, 52, 42))

score.by.sex <- aggregate(score ~ sex, 
                          FUN = mean, 
                          data = study1.df)

study1.htest <- t.test(score ~ sex, 
                       data = study1.df)
# This code is used to save the created objects in a specified file
save(study1.df, score.by.sex, study1.htest,
file = "Data/studytest.rdata")
save.image(file = "data/projectimage.RData")
# This code loads the objects saved to the destination file
load(file = "data/studytest.rdata")
load(file = "data/projectimage.RData")
# This code is used to save a specific object to a .txt file
write.table(x = study1.df,
            file = "studies.txt",  # Save the file as studies.txt
            sep = "\t")            # Make the columns tab-delimited
#This code is used to rea 'txt file into R
mydata <- read.table(file = 'Data/mydata.txt',   
                     sep = '\t',                 
                     header = TRUE,               # the first row of the data is a header row
                     stringsAsFactors = FALSE)    
#To print
mydata
# This code is used to read a text file from the web url
fromweb <- read.table(file = 'http://goo.gl/jTNf6P',
                      sep = '\t',
                      header = TRUE)
#To see the results
fromweb



	
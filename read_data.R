read_data <- function(){
      #Download and/or Unzip data if necessary
      if(!file.exists("activity.csv")){
            if(file.exists("activity.zip")){
                  unzip("activity.zip")
            }else{
                  temp <- tempfile()
                  download.file("https://d396qusza40orc.cloudfront.net/
                                repdata%2Fdata%2Factivity.zip", destfile = temp)
                  unzip(temp)
                  unlink(temp)
            }
      }
      
      # Read in the Data
      data <- read.csv("activity.csv")
      
      # Add a new variable by converting the date variable to Date class
      data$asDate <- as.Date(data$date, format = "%Y-%m-%d")
      
      # Return the data
      data
}
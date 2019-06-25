mean_per_day <- function(){
      # Install dplyr package if it is not already installed
      if(!require(dplyr)){
            install.packages("dplyr")
      }
      
      # Load dplyr package
      library(dplyr)
      
      # Source the read_data.R script. Script must be in working directory.
      source('./read_data.R')
      
      # Load in the preprocessed data using the read_data.R script.
      data <- read_data()
      
      # Create a new data frame that filters out the entries with missing values from the original data
      data2 <- filter(data, !is.na(data$steps))
      
      # Group the data by date
      grouped_data <- group_by(data2, date)
      
      # Create a data frame containing the total number of steps for each day. Missing values are ignored.
      sums <- summarize(grouped_data, steps = sum(steps))
      
      # Generate a histogram of the total number of steps each day
      with(sums, hist(steps, xlab = "Daily Total Steps", ylab = "Frequency", main = "Daily Total Steps For October and November 2012",
                      xlim = c(0, 25000), ylim = c(0, 20), col = "red", breaks = 10))
      
      # Calculate and return the mean and median of the daily total number of steps
      data.frame(mean = mean(sums$steps), median = median(sums$steps))
}
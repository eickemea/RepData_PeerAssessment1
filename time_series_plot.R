time_series_plot <- function(){
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
      
      # Group the data by interval
      grouped_data <- group_by(data, interval)
      
      # Create a data frame containing the average number of steps for each 5 minute interval,
      # averaged across all days. Missing values are ignored.
      averages <- summarize(grouped_data, steps = mean(steps, na.rm = TRUE))
      
      # Generate a time series plot of the average number of steps for each 5 minute interval.
      with(averages, plot(interval, steps, xlab = "5 Minute Interval", 
                          ylab = "Average Number of Steps", main = "Average Number of Steps In Five Minute Time Intervals",
                          type = "l"))
      
      # Find and return the 5 minute interval that contains the maximum number of steps on average across all days
      averages$interval[which.max(averages$steps)]
}
average_weekdays <- function(){
      # Source the impute_data.R script. Script must be in working directory.
      source('./impute_data.R')
      
      # Load in the imputed data using the impute_data.R script.
      data <- impute_data(hist = FALSE, summary = FALSE)
      
      # Add a new factor variable, day, to the data indicating whether each entry was taken on a weekday or weekend
      data <- mutate(data, day = factor(weekdays(asDate) %in% c("Saturday", "Sunday"), labels = c("Weekday", "Weekend")))
      
      # Create a data frame containing the average number of steps for each 5 minute interval,
      # averaged across weekdays and weekends.
      averages <- ddply(data, day~interval, summarize, steps = mean(steps))
      
      # Create a logical vector indicating which observations occurred on weekdays
      weekday <- averages$day == "Weekday"
      
      # Set mfrow parameter to (2, 1) so that two plots may be generated in a 2 x 1 arrangement
      par(mfrow = c(2,1))
      
      # Generate two time series plots of the average number of steps taken in each five minute interval with the first being
      # averaged over weekdays and the second being averaged over weekends
      with(averages[weekday,], plot(interval, steps, xlab = "5 Minute Interval", 
                          ylab = "Average Number of Steps", main = "Average Number of Steps In Five Minute Time Intervals (Weekdays)",
                          type = "l"))
      
      with(averages[!weekday,], plot(interval, steps, xlab = "5 Minute Interval", 
                          ylab = "Average Number of Steps", main = "Average Number of Steps In Five Minute Time Intervals (Weekends)",
                          type = "l"))
}
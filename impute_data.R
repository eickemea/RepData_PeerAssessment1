impute_data <- function(hist = TRUE, summary = TRUE){
      
      # Unload dplyr package if already loaded
      if("dplyr" %in% (.packages())){
            detach("package:dplyr", unload=TRUE) 
      }
      
      # Install plyr package if it is not already installed
      if(!require(plyr)){
            install.packages("plyr")
      }
      
      # Load plyr package
      library(plyr)
      
      # Source the read_data.R script. Script must be in working directory.
      source('./read_data.R')
      
      # Load in the preprocessed data using the read_data.R script.
      data <- read_data()
      
      # Create a new data frame that imputes for each missing value in the original data the mean for the number of
      # steps taken during the time interval that the missing value belongs to, taken across all days (ignoring missing values)
      # Credit to Carl Lee McKinney post on forums for idea for this approach
      imputed_data <- ddply(data, ~interval, transform, steps = replace(steps, is.na(steps), mean(steps, na.rm = TRUE)))
      
      # Create a data frame containing the total number of steps for each day from the imputed data
      sums <- ddply(imputed_data, ~date, summarize, steps = sum(steps))
      
      # Generate a histogram of the total number of steps each day from the imputed data if hist = TRUE
      if(hist == TRUE){
            with(sums, hist(steps, xlab = "Daily Total Steps", ylab = "Frequency", 
                            main = "Daily Total Steps For October and November 2012 (Imputed)",
                            xlim = c(0, 25000), ylim = c(0, 20), col = "red", breaks = 10))
      }
      
      
      # Calculate and return the mean and median of the daily total number of steps from the imputed data if
      # summary = TRUE
      if(summary == TRUE){
            print(data.frame(mean = mean(sums$steps), median = median(sums$steps), missing = sum(is.na(data))))
      }
      
      # Return the data frame with the imputed data
      imputed_data
}
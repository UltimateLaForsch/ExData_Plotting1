library(tidyverse)
library(sqldf)
library(chron)

# Part 1 will be only used once to reduce loading time during development
# (comment out Part 1 after first use)

# Part 1===============================================================
# Load and filter data and format DateTime
raw_data <- read.csv.sql(file = "ExData_Plotting1/data/household_power_consumption.txt",
                         sql = "select * from file where Date='1/2/2007' or Date='2/2/2007'",
                         sep = ";")
raw_data$DateTime <- strptime(paste(raw_data$Date, raw_data$Time), format = '%d/%m/%Y %H:%M:%S')
# Save only data of interest
write.csv(raw_data, "ExData_Plotting1/data/power_consum.csv", row.names = FALSE)
# End of Part 1========================================================


# Part 2===============================================================
# From here, work only with filtered and cleaned data
power_consum <- read.csv('ExData_Plotting1/data/power_consum.csv')
png("ExData_Plotting1/plot1.png", width = 480, height = 480)
hist(power_consum$Global_active_power, main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)', col = 'red')
dev.off()

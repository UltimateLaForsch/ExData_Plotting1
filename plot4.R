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
# Further DateTime conversion necessary, so it will be correctly plotted
power_consum$DateTime  <- as.POSIXct(power_consum$DateTime)
png("ExData_Plotting1/plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
# Plot 1
plot(x = power_consum$DateTime,
     y = power_consum$Global_active_power,
     type = 'l',
     xlab = '',
     ylab = 'Global Active Power (kilowatts)', col = 'black')
# Plot 2
plot(x = power_consum$DateTime,
     y = power_consum$Voltage,
     type = 'l',
     xlab = '',
     ylab = 'Voltage', col = 'black')
# Plot 3
plot(x = power_consum$DateTime,
     y = power_consum$Sub_metering_1,
     type = 'l',
     xlab = '',
     ylab = 'Energy sub metering', col = 'black')
lines(x = power_consum$DateTime,
     y = power_consum$Sub_metering_2,
     type = 'l', col = "red"
     )
lines(x = power_consum$DateTime,
     y = power_consum$Sub_metering_3,
     type = 'l', col = "blue"
     )
legend('topright', lty=1, col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Plot 4
plot(x = power_consum$DateTime,
     y = power_consum$Global_reactive_power,
     type = 'l',
     xlab = '',
     ylab = 'Global_reactive_power',
     col = 'black')
dev.off()


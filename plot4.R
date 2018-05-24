# Please set your working directory and load these libraries
getwd()
library(dplyr)
library(lubridate)


# Reading the dataset with 2,075,259 obs. and 9 variables
# Missing values are coded as "?"
data <- read.table("household_power_consumption.txt", 
                   header = TRUE,
                   sep = ";",
                   stringsAsFactors = FALSE,
                   na.strings = "?",
                   colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))


# We will only be using data from 2007-02-01 and 2007-02-02
# This contains 2880 obs.
data <- data %>%
  mutate(Date_Time = paste(Date, Time)) %>%
  mutate(Date_Time = dmy_hms(Date_Time)) %>%
  mutate(Date = dmy(Date)) %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02")


# Construct plot3 and save it to a PNG file with a width of 480 pixels and a height of 480 pixels
# (Due to language settings, my x-axis shows the values "do, vr, za" instead of "Thu, Fri, Sat")
png(filename = "plot4.png")
par(mfrow = c(2,2))
plot(data$Date_Time, data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power")
plot(data$Date_Time, data$Voltage, 
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")
plot(data$Date_Time, data$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(data$Date_Time, data$Sub_metering_2,
      col = "red")
lines(data$Date_Time, data$Sub_metering_3,
      col = "blue")
legend(legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       "topright",
       lty = 1,
       col = c("black", "red", "blue"))
plot(data$Date_Time, data$Global_reactive_power, 
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")
dev.off()


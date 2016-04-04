### File: plot1.R
### Author:R Phelps.
### Date:  Apr 3rd 2016
### Plot data: Electric power consumption from
### https://d396qusza40orc.cloudfront.net/
###         exdata%2Fdata%2Fhousehold_power_consumption.zip

###  Libraries: base plotting library

power =  read.csv("data/household_power_consumption.txt", sep =';',
                   na.strings = "?")

###  save col names to reference as needed
colnames = names(power)

### Remove NA rows
power_noNA <- subset(power, !(is.na(Global_active_power) |
                              is.na(Global_reactive_power) |
                              is.na(Voltage) |
                              is.na(Sub_metering_1) |
                              is.na(Sub_metering_2) |
                              is.na(Sub_metering_3)
                              ))

### Subset 1st and 2nd days of Feb in 2007
Feb1st2nd = subset(power, Date == '1/2/2007' | Date == '2/2/2007', na.rm = TRUE)

hist(Feb1st2nd$Global_active_power,
     col  = 'red',
     xlab = 'Global Active Power',
     main = 'Global Active Power (kilowatts)')

dev.copy(png, 'plot1.png')
dev.off()

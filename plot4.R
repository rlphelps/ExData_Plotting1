### File: plot4.R
### Author:R Phelps.
### Date:  Apr 3rd 2016
### Plot data: Electric power consumption from
### https://d396qusza40orc.cloudfront.net/
###         exdata%2Fdata%2Fhousehold_power_consumption.zip

###  Libraries: base plotting library


# convert date info in format 'mm/dd/yyyy'

power =  read.csv("data/household_power_consumption.txt", sep =';',
                  na.strings = "?", stringsAsFactors = FALSE)

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

### create string to next generate datetime col
Day <-paste(Feb1st2nd$Date,Feb1st2nd$Time)
### generate datetime col
Day <-as.POSIXct(Day, format = '%d/%m/%Y %H:%M:%S')
### add vector to dataframe
Feb1st2nd <-cbind(Day, Feb1st2nd)

### plot 2 by 2
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(Feb1st2nd, {
        plot(Day, Global_active_power, type ='l',
                  ylab = "Global Active Power (kilowatts)",
                  xlab = "Day of Week")
        plot(Day, Voltage, type = 'l', xlab = 'Datetime')

        with(Feb1st2nd, plot(Day, Sub_metering_1, type = 'l',
                             ylab = 'Energy Sub Metering'))
        with(Feb1st2nd, points(Day, Sub_metering_2, type ='l', col ='red'))
        with(Feb1st2nd, points(Day, Sub_metering_3, type ='l', col ='blue'))
        legend('topright', pch = '-', col = c('black','red','blue'),
               legend  = c('Sub Metering 1','Sub Metering 2','Sub Metering 3'),
               bty='n')

        plot(Day, Global_reactive_power, type = 'l', xlab = 'Datetime')
})


dev.copy(png, 'plot4.png')
dev.off()
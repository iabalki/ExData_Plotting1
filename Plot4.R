
## Step 1: Load the data, subsetting for the desired period and format for plotting

## note: change the location if your source file is stored in a diff location
setwd ("D:/Users/Milla/Documents/Data Science Classes/Course 4 Project 1")
## read the full dataset
data <- read.table ("household_power_consumption.txt", header = TRUE, sep =";", dec =".", na.strings = "?", stringsAsFactors = FALSE)
## convert the dates so that we can lookup which rows are within the desired period
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
## subset the desired period
mydata <- subset (data, Date == as.Date("2007-02-01") |
                    Date == as.Date("2007-02-02"))

## Merge Date and Time so that you can plot all elements in the right sequence
mydata$DateTime <- strptime (paste(as.character(mydata$Date), mydata$Time), "%Y-%m-%d %H:%M:%S")

## Step 2: Plot onto files

### plot 4
png(file="plot4.png")
par (mfrow = c(2,2))
with (mydata, {
  ## plot 2
  plot (mydata$DateTime, mydata$Global_active_power, xlab = "", ylab = "Global Active Power (Kilowatts)", type = "l")
  ## voltage vs time
  plot (mydata$DateTime, mydata$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
  ## plot 3
  plot (range(mydata$DateTime), c(0,40), xlab = "", ylab = "Energy Sub-metering", type = "n")
  lines (mydata$DateTime, mydata$Sub_metering_1, type = "l", col = "black")
  lines (mydata$DateTime, mydata$Sub_metering_2, type = "l", col = "red")
  lines (mydata$DateTime, mydata$Sub_metering_3, type = "l", col = "blue")
  legend ("topright", col = c ("black", "red", "blue"), lwd= 2, legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  ## reactive power vs. time
  plot (mydata$DateTime, mydata$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
}) 
dev.off
## reset your plot
par (mfrow = c(1,1))

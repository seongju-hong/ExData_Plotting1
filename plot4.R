fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl")
unzip("household_power_consumption.zip")

headset <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", comment.char = "#", nrows = 100) 
classes <- sapply(headset, class)

dataset <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header = TRUE, sep = ";", na.strings = "?", comment.char = "#", colClasses = classes) 
colnames(dataset) <-names(headset)
dataset$DateTime <- strptime(paste(dataset$Date, dataset$Time), "%d/%m/%Y %H:%M:%S")

quartz()
par(mfrow = c(2, 2))
with(dataset, {
    plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
    plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
    with(dataset, {
        plot(dataset$DateTime, dataset$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
        lines(dataset$DateTime, dataset$Sub_metering_2, col = "red")
        lines(dataset$DateTime, dataset$Sub_metering_3, col = "blue")
        legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
    })
    plot(DateTime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
}
)

dev.copy(png, file = "plot4.png")
dev.off()
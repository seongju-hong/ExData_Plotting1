fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl")
unzip("household_power_consumption.zip")

headset <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", comment.char = "#", nrows = 100) 
classes <- sapply(headset, class)

dataset <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header = TRUE, sep = ";", na.strings = "?", comment.char = "#", colClasses = classes) 
colnames(dataset) <-names(headset)
dataset$DateTime <- strptime(paste(dataset$Date, dataset$Time), "%d/%m/%Y %H:%M:%S")

quartz()
hist(dataset$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.copy(png, file = "plot1.png")
dev.off()

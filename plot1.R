plot1 <- function() {
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
    data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE, stringsAsFactors=FALSE)
    unlink(temp)
    data$Date <- gsub("\\/", "-", data$Date)
    data$Date <- as.Date(as.character(data$Date), "%d-%m-%Y")
    data <- subset(data, Date %in% as.Date(c("2007-02-02", "2007-02-01")))
    plot1 <- hist(as.numeric(data$Global_active_power), freq=TRUE, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
    dev.copy(png,"plot1.png")
    dev.off()
}
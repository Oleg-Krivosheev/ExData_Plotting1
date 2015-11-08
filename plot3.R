library(data.table)

# reading data
hpc.dt <- fread("household_power_consumption.txt", sep=";", na.strings="?", header=TRUE,
                 colClasses = c("character", "character",
                                "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# gluing date and time, date as Date
hpc.dt[, Time := as.character(paste(Date, Time))]
hpc.dt[, Date := as.Date(Date, "%d/%m/%Y")]

# select date range and a subset of a data
sel.dates <- as.Date(c("01/02/2007", "02/02/2007"), "%d/%m/%Y")
sel.dt    <- subset(hpc.dt, Date %in% sel.dates)

t <- as.POSIXlt(sel.dt$Time, tz="EST", format="%d/%m/%Y %H:%M:%S")

# plotting
png("plot3.png", width=480, height=480)

plot(t, sel.dt$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(t, sel.dt$Sub_metering_2, col="red")
lines(t, sel.dt$Sub_metering_3, col="blue")

legend("topright", col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1)

dev.off()

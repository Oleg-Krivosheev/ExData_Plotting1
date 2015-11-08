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
png("plot4.png", width=480, height=480)

# ok, set 2x2 plot matrix
par(mfrow=c(2,2))

# plot 1
plot(t, sel.dt$Global_active_power,
        type="l",
        xlab="",
        ylab="Global Active Power", lwd=1)

# plot 2
plot(t, sel.dt$Voltage,
        type="l",
        xlab="datetime",
        ylab="Voltage", lwd=1)

# plot 3
plot(t, sel.dt$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(t, sel.dt$Sub_metering_2, col="red")
lines(t, sel.dt$Sub_metering_3, col="blue")

legend("topright", col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, box.lwd=0) # no border for legend!

# plot 4
plot(t, sel.dt$Global_reactive_power,
     type="l",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()

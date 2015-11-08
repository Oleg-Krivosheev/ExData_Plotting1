library(data.table)

# reading data
hpc.dt <- fread("household_power_consumption.txt", sep=";", na.strings="?", header=TRUE,
                 colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

hpc.dt[,  Date := as.Date(Date, "%d/%m/%Y")]

# select date range and a subset of a data
sel.dates <- as.Date(c("01/02/2007", "02/02/2007"), "%d/%m/%Y")
sel.dt    <- subset(hpc.dt, Date %in% sel.dates)

# plot the thing
png("plot1.png", width=480, height=480)

hist(sel.dt$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power")

dev.off()

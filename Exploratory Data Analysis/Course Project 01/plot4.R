myDtFormat = "%d/%m/%Y"
f <- "household_power_consumption.txt"

df = read.table(file="household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
                colClasses = c(rep("character",2),rep("numeric",7)))

df$Date <- as.Date(df$Date, format = myDtFormat)

df <- df[df$Date >= "2007/02/01" & df$Date <= "2007/02/02",]

png(file = "plot4.png")
par(mfrow = c(2,2))
with(df, plot(Global_active_power,
              xlab = "",
              ylab = "Global Active Power",
              type = "n"))
with(df, lines(Global_active_power))

with(df, plot(Voltage,
              xlab = "datetime",
              ylab = "Voltage",
              type = "n"))
with(df, lines(Voltage))

with(df, plot(Sub_metering_1,
              xlab = "",
              ylab = "Energy sub metering",
              type = "n"))
with(df, lines(Sub_metering_1))
with(df, lines(Sub_metering_2,
               col = "red"))
with(df, lines(Sub_metering_3,
               col = "blue"))
legend("topright", legend = c("Sub_metering_1",
                              "Sub_metering_2",
                              "Sub_metering_3"), 
       col = c("black","red","blue"),
       lty = 1,
       bty = "n")

with(df, plot(Global_reactive_power,
              xlab = "datetime",
              type = "n"))
with(df, lines(Global_reactive_power))
dev.off()
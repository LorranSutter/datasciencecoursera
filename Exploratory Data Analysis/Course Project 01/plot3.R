myDtFormat = "%d/%m/%Y"
f <- "household_power_consumption.txt"

df = read.table(file="household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
                colClasses = c(rep("character",2),rep("numeric",7)))

df$Date <- as.Date(df$Date, format = myDtFormat)

df <- df[df$Date >= "2007/02/01" & df$Date <= "2007/02/02",]

png(file = "plot3.png")
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
       lty = 1)
dev.off()
myDtFormat = "%d/%m/%Y"
f <- "household_power_consumption.txt"

df = read.table(file="household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
                colClasses = c(rep("character",2),rep("numeric",7)))

df$Date <- as.Date(df$Date, format = myDtFormat)

df <- df[df$Date >= "2007/02/01" & df$Date <= "2007/02/02",]

png(file = "plot1.png")
with(df, hist(Global_active_power,
              main = "Global Active Power",
              xlab = "Global Active Power (kiliwatts)",
              col = "red"))
dev.off()
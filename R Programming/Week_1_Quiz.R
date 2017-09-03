# ----- Week 1 Quiz -----

# File for questions 11 to 20
f <- read.csv("hw1_data.csv")

# Question 11
names(f)

# Question 12
head(f)

# Question 13
nrows(f)

# Question 14
tail(f)

# Question 15
f[47,"Ozone"]

# Question 16
sum(is.na(f["Ozone"]))

# Question 17
mean(f[[1]], na.rm = TRUE)

# Question 18
mean((f[f["Ozone"] > 31 & f["Temp"] > 90,])[["Solar.R"]],na.rm = TRUE)

# Question 19
mean((f[f["Month"] == 6,])[["Temp"]])

# Question 20
Fgood <- f[complete.cases(f["Ozone"]),] # Not NA
#Fgood[Fgood["Month"]==5,]               # May month
max(Fgood[Fgood["Month"]==5,]["Ozone"])

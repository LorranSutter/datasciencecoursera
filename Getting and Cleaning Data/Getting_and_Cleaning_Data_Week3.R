# ----- Subsetting and Sorting -----
set.seed(13435)
X <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15))
X <- X[sample(1:5),]
X$var2[c(1,3)] = NA

X[which(X$var2 > 8),] # Ignore missing values

sort(X$var1)                    # Sorting
sort(X$var1, decreasing = TRUE) # Decreasing sorting
sort(X$var2, na.last = TRUE)    # Sort and put NA values at the end

X[order(X$var1),]          # Order data frame following var1 column
X[order(X$var1,X$var3),]   # Order following var1 column than var3 column

library(plyr)
arrange(X, var1)           # Same as order above
arrange(X, desc(var1))     # Same as order, but descending

X$var4 <- rnorm(5)     # Adding new column
Y <- cbind(X,rnorm(5)) # Another way to add column


# ----- Summarizing Data -----
# Data about restaurants in Blatimore
# https://data.baltimorecity.gov/resource/abuv-d2r2.csv

if(!file.exists("./restaurants.csv")){
  fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?acessType=DOWNLOAD"
  download.file(fileUrl,destfile = "restaurants.csv", method="curl")
}
restData <- read.csv("./restaurants.csv")

summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm = TRUE)             # Ordinary quantile distribution
quantile(restData$councilDistrict, probs = c(0.5,0.75,0.9))  # Different quantile distribution
table(restData$zipCode, useNA = "ifany")                     # Make a table
table(restData$councilDistrict, restData$zipCode)            # Two dimensional table 

sum(is.na(restData$councilDistrict))   # Check how many values are missed
any(is.na(restData$councilDistrict))   # Check if there is ANY value missed
all(restData$zipCode > 0)              # Check if ALL values are greater than 0

colSums(is.na(restData))  # Sum column values

table(restData$zipCode %in% c("21212"))              # Create table with values that respect the condition
table(restData$zipCode %in% c("21212","21213"))      # Create table with values that respect the condition
restData[restData$zipCode %in% c("21212","21213"),]  # Subset restData respecting condition

data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data = DF)  # Cross tabs, stablish frequence relation between Gender and Admition

data("warpbreaks")                             # Cross tabs in large tables usually are difficult to see
warpbreaks$replicate <- rep(1:9, len = 54)
xt <- xtabs(breaks ~., data = warpbreaks)      # Relation of breaks to all other variables
ftable(xt)                                     # Create flat table to better visualization

fakeData = rnorm(1e5)
object.size(fakeData)                       # Size of data set
print(object.size(fakeData), units = "Mb")


# ----- Creating New Variables -----
if(!file.exists("./restaurants.csv")){
  fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?acessType=DOWNLOAD"
  download.file(fileUrl,destfile = "restaurants.csv", method="curl")
}
restData <- read.csv("./restaurants.csv")

s1 <- seq(1,10,by=2)                  # 1 to 10, step 2
s2 <- seq(1,10,length=3)              # 3 values 1 to 10
x <- c(1,3,8,25,100); seq(along = x)  # Sequence same length as x

restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")  # New boolean column

restData$zipWrong <- ifelse(restData$zipCode < 0, TRUE, FALSE)    # New boolean column respecting condition
table(restData$zipWrong, restData$zipCode < 0)                    # Two dimensional table with wrong zip codes

restData$zipGroups <- cut(restData$zipCode, breaks = quantile(restData$zipCode))  # Subset zipCode respecting quantiles
table(restData$zipGroups, restData$zipCode)

install.packages("Hmisc") # Easier cutting
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode, g = 4)  # Break zipCode in 4 different groups
table(restData$zipGroups)

restData$zcf <- factor(restData$zipCode)  # Create new factor variable based in zipCode

yesno <- sample(c("yes","no"),size = 10, replace = TRUE)  # Sample of yeses and nos
yesnofac <- factor(yesno, levels = c("yes","no"))         # Factor
relevel(yesnofac, ref = "yes")                            # Relevel sorting by yes factor
as.numeric(yesnofac)                                      # Convert factor into a numeric variable

library(Hmisc)
library(plyr)
restData2 <- mutate(restData, zipGroups = cut2(zipCode, g = 4)) # New df is the old df plus new column
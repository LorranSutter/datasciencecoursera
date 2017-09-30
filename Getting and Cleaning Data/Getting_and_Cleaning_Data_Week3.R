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



# ----- Reshaping Data -----
library(reshape2)

data("mtcars")
head(mtcars)
mtcars$carnames <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carnames","gear",'cyl'), measure.vars = c("mpg","hp"))  # Say what are id and measure variables
cylData <- dcast(carMelt, cyl ~ variable)                                             # Reorganize data
cylData <- dcast(carMelt, cyl ~ variable, mean)                                       # Reorganize date using a function

data("InsectSprays")
head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray,sum)       # Apply count along spray with function sum
# OR
spIns <- split(InsectSprays$count, InsectSprays$spray)  # Split count along spray
sprCount <- lapply(spIns,sum)                           # Apply sum along spray 
unlist(sprCount)                                        # Produce a vector
# OR
sapply(spIns,sum)                                       # Automatically produce better structure (vector in this case)
# OR
library(plyr)
ddply(InsectSprays, .(spray), summarize, sum=sum(count))

spraySums <- ddply(InsectSprays, .(spray), summarize, sum=ave(count,FUN=sum)) # Did not understand the utility



# ----- Managing Data Frames with dplyr -----
# Specific package to deal with data frames
# Simple grammar and very fast

install.packages("dplyr")
library(dplyr)

if(!file.exists("./data")) { dir.create("./data") }
fileURL <- "https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/dplyr/chicago.rds?raw=true"
download.file(fileURL, destfile = "./data/chicago.rds", method = "curl", extra='-L')
chicago <- readRDS("./data/chicago.rds")

# Select
head(select(chicago, city:dptp))     # Select from city to dptp
head(select(chicago, -(city:dptp)))  # Select all columns minus (from city to dptp)
# EQUIVALENT
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])

# Filter
chic.f <- filter(chicago, pm25tmean2 > 30) # Filter for rows that has more than 30 pm24tmean2
head(select(chic.f, 1:3, pm25tmean2), 10)  # Select from 1st to 3rd column plus pm25tmean2 column

chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80) # Filter for rows that has more than 30 pm24tmean2 and 80 tmpd
head(select(chic.f, 1:3, pm25tmean2, tmpd), 10)        # Select from 1st to 3rd column plus pm25tmean2 column and tmpd

# arrange
chicago <- arrange(chicago, date)          # Arrange df by data
head(select(chicago, date, pm25tmean2), 3)

chicago <- arrange(chicago, desc(date))    # Arrange df by data in descending order
head(select(chicago, date, pm25tmean2), 3)

# rename
chicago <- rename(chicago, dewpoint = dptp,
                  pm25 = pm25tmean2)        # Self explanatory
head(chicago[, 1:5], 3)

# mutate (to transform or create variables)
chicago <- mutate(chicago,
                  pm25detrend=pm25-mean(pm25, na.rm=TRUE))  # Create a new variable
head(select(chicago, pm25, pm25detrend))

# group_by
chicago <- mutate(chicago,
                  tempcat = factor(1 * (tmpd > 80),
                                   labels = c("cold", "hot"))) # Create column tempcat (cold, hot)
hotcold <- group_by(chicago, tempcat)                          # Group chicago by tempcat (cold, hot)
summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE),
          o3 = max(o3tmean2),
          no2 = median(no2tmean2)) 

chicago <- mutate(chicago,
                  year = as.POSIXlt(date)$year + 1900)   # Create column year
years <- group_by(chicago, year)                         # Group chicago by year
summarize(years, pm25 = mean(pm25, na.rm = TRUE),
          o3 = max(o3tmean2, na.rm = TRUE),
          no2 = median(no2tmean2, na.rm = TRUE))

# Alternatively by pipeline (same as command above)
chicago %>% 
  mutate(month = as.POSIXlt(date)$mon + 1) %>% 
  group_by(month) %>% 
  summarize(pm25 = mean(pm25, na.rm = TRUE),
            o3 = max(o3tmean2, na.rm = TRUE),
            no2 = median(no2tmean2, na.rm = TRUE))



# ----- Merging Data -----
if(!file.exists("./data")) { dir.create("./data") }
fileURL1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"   # Not found
fileURL2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv" # Not found
download.file(fileURL1, destfile = "./data/reviews.csv", method = "curl")
download.file(fileURL2, destfile = "./data/solutions.csv", method = "curl")
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")

mergedData <- merge(reviews, solutions, by.x="solution_id", by.y="id", all = TRUE)

intersect(names(solutions),names(reviews))  # Get common names from tables
# Merge by default all columns what have common names
mergedData2 <- merge(reviews, solutions, all = TRUE)

# Joing, plyr package, faster, but less featured
df1 <- data.frame(id=sample(1:10),x=rnorm(10))
df2 <- data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id)

# Multiple data frames
df1 <- data.frame(id=sample(1:10),x=rnorm(10))
df2 <- data.frame(id=sample(1:10),y=rnorm(10))
df3 <- data.frame(id=sample(1:10),z=rnorm(10))
dfList <- list(df1,df2,df3)
join_all(dfList)                                # Join a list of data frames
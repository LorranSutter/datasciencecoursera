# Question 01
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "housing.csv")
housing <- read.csv("housing.csv")
sum(housing$VAL[housing$VAL == 24], na.rm = TRUE)/24 # 53

# Question 03
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "gas_aquisition.xlsx")
gas_aquisition <- read.csv("gas_aquisition.csv") # 36534720

# Question 04
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile = "Baltimore_resteurants.xml")
library(XML)
doc <- xmlTreeParse("Baltimore_resteurants.xml", useInternal = TRUE)
rootNode <- xmlRoot(doc)
zipcode <- xpathSApply(rootNode,"//zipcode",xmlValue)
length(zipcode[zipcode == "21231"]) # 127

# Question 05
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "housing2.csv")
DT <- fread("housing2.csv")
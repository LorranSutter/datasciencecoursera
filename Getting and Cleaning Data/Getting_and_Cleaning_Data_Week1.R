# ----- Downloading files -----
# Get/set work directory
getwd()
setwd()
# Relative
setwd("./data")
setwd("../")
# Absolute
setwd("/home/lorran/datasciencecoursera")
setwd("C:\\Users\\Lorran\\Documents") # Detail in Windows \\

# Checking for creatind directories
if(!file.exists("./data")){
  dir.create("./data")
}


# ----- Getting data from internet -----
fileUrl <- "https://data.baltimorecity.gov/resource/dz54-2aru.json"
download.file(fileUrl, destfile = "./data/cameras.json")
list.files("./data")
dateDownloaded <- date()
dateDownloaded

# Example: Baltimore camera data (.csv)
cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE)


# ----- Excel files -----
install.packages("xlsx") # try again
# DEPENDENCY sudo apt-get install openjdk-7-jdk
# DEPENDENCY sudo R CMD javareconf
# DEPENDENCY sudo apt-get install r-cran-rjava
# DEPENDENCY install.packages("rJava") # try again
#library(xlsx)
#cameraData <- read.xlsx("./data/cameras.xlsx", sheedIndex = 1, header = TRUE)
#colIndex <- 2:3
#rowIndex <- 1:4
#cameraData <- read.xlsx("./data/cameras.xlsx", sheedIndex = 1, colIndex = colIndex, rowIndex = rowIndex)
#write.xlsx()
#install.packages("XLConnect") # try again


# ----- XML files -----
#install.packages("XML")
# DEPENDENCY sudo apt-get install libcurl4-openssl-dev libxml2-dev
library(XML)
fileUrl <- "https://www.w3schools.com/xml/simple.xml"
download.file(fileUrl, destfile = "./data/simple.xml")
doc <- xmlTreeParse("./data/simple.xml", useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
rootNode[[1]][[1]]
xmlSApply(rootNode, xmlValue)

# XPath
# /node -> Top level node
# //node -> Node at any level
# node[@att-name] -> Node with an attribute name
# node[@attr-name='bob'] -> Node with attribute name attr-name='bob'
xpathSApply(rootNode,"//name",xmlValue)
xpathSApply(rootNode,"//price",xmlValue)

# Example
fileUrl <- "http://www.espn.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal = TRUE)
scores <- xpathSApply(doc, "//li[@class='score']",xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']",xmlValue)


# ----- JSON -----
install.packages("curl") # DEPENDENCY
install.packages("jsonlite")
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login

myjson <- toJSON(iris, pretty = TRUE) # turn iris dataset into json, pretty -> indent
cat(myjson)


# ----- data.table -----
#inherets from data.frame
#written in C (faster)
install.packages("data.table")
library(data.table)

DF <- data.frame(x = rnorm(9), y = rep(c("a","b","c"), each = 3), z = rnorm(9))
head(DF,3)

DT <- data.table(x = rnorm(9), y = rep(c("a","b","c"), each = 3), z = rnorm(9))
head(DT,3)

tables() # see tables in memory

# subsetting rows
DT[2,]
DT[DT$y == "a",]
DT[c(2,3),]

# subsetting columns
DT[,2]
DT[,c(2,3)]

# expressions
DT[,list(mean(x),sum(z))]
DT[,table(y)]

# adding new columns
DT[,w := z^2]
# be careful
DT2 <- DT
DT[,w := z^2] # alters DT2 too

# multiple operations
DT[,m := {tmp <- (x+z); log2(tmp+5)}]

# plyr like operations
DT[,a := x>0]                # create like a flag column
DT[,b := mean(x+w), by = a]  # execute mean when a is TRUE, group by

# special variables
set.seed(123)
DT <- data.table(x = sample(letters[1:3], 1E5, TRUE))
DT[, .N, by=x]   # .N for counting

# keys
DT <- data.table(x = rep(c("a","b","c"), each = 100), y = rnorm(300))
setkey(DT,x)  # beahve as a dictionary
DT['a']       # acess as a key

# joins
DT1 <- data.table(x = c('a','a','b','dt1'), y = 1:4)
DT2 <- data.table(x = c('a','b','dt2'), y = 5:7)
setkey(DT1,x)
setkey(DT2,x)
merge(DT1,DT2)

# fast reading
big_df <- data.frame(x = rnorm(1E6), y = rnorm(1E6))
file <- tempfile()
write.table(big_df, file = file, row.names = FALSE, col.names = TRUE, sep = "\t", quote = FALSE)
system.time(fread(file))
system.time(read.table(file, header = TRUE, sep = "\t"))  # comparisson, way slower
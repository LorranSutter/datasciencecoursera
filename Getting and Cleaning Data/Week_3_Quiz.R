# Question 01
housing <- read.csv("housing.csv")
housing$ACR == 3  # Greater than 10 acres size
housing$AGS == 6  # Sold more than 10000 worth of agriculture products
agricultureLogical <- housing$ACR == 3 & housing$AGS == 6
which(agricultureLogical)  # 125, 238,262

# Question 02
if(!file.exists("./jeff.jpg")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
  download.file(fileUrl,destfile = "jeff.jpg", mode = "wb")
}
library(jpeg)
pictureJeff <- readJPEG(source = "jeff.jpg", native = TRUE)
quantile(pictureJeff, probs = c(0.3,0.8)) # Linux answer: -15258512 -10575416 
                                          # Course answer: -15259150 -10575416

# Question 03
# http://www.worldbank.org/
if(!file.exists("./data/GDP_Ranking.csv")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  download.file(fileUrl,destfile = "./data/GDP_Ranking.csv", method = "curl")
}
if(!file.exists("./data/Educational_Statistics.csv")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  download.file(fileUrl,destfile = "./data/Educational_Statistics.csv", method = "curl")
}

GDP <- read.csv("./data/GDP_Ranking_Edited.csv", header = TRUE) # After cleaning file
eduStatistics <- read.csv("./data/Educational_Statistics.csv", header = TRUE)

sum(GDP$X %in% eduStatistics$CountryCode)        # 189 matches
GDP[order(GDP$Ranking, decreasing = TRUE),][13,] # 13th country is St. Kitts and Nevis


# Question 04
OECD    <- eduStatistics[eduStatistics$Income.Group == "High income: OECD",]["CountryCode"]
nonOECD <- eduStatistics[eduStatistics$Income.Group == "High income: nonOECD",]["CountryCode"]

GDP_OECD    <- GDP[GDP$X %in% OECD$CountryCode,]
GDP_nonOECD <- GDP[GDP$X %in% nonOECD$CountryCode,]

mean(GDP_OECD$Ranking)    # 32.96667
mean(GDP_nonOECD$Ranking) # 91.91304


# Question 05
library(Hmisc)
GDP$quantils <- cut2(GDP$Ranking, g = 5)
teste_merge <- merge(eduStatistics,GDP, by.x = "CountryCode", by.y = "X", all = TRUE)
table(teste_merge$quantils, teste_merge$Income.Group)   # 5
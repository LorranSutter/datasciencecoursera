# ----- Reading from MySQL ----
# DEPENDENCY sudo apt-get install libmariadb-client-lgpl-dev
install.packages("RMySQL")
library(RMySQL)

# Web site example full of genome data
# http://genome.ucsc.edu/goldenpath/help/mysql.html
ucscDb <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu") # Connect to database
result <- dbGetQuery(ucscDb, "show databases;")                               # Get all databases names
dbDisconnect(ucscDb)                                                          # Disconnect from database

hg19 <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu") # Connect to hg19 database
allTables <- dbListTables(hg19)                                                        # List all tables
dbListFields(hg19, "affyU133Plus2")                                                    # List columns' table
dbGetQuery(hg19, "select count(*) from affyU133Plus2")                                 # Execute query in db
affyData <- dbReadTable(hg19, "affyU133Plus2")                                         # Read entire table

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3") # Make a query (MySQLResult class)
affyMis <- fetch(query)                                                                    # Turn MySQLResult into a data.frame
quantile(affyMis$misMatches)
affyMis <- fetch(query, n = 10)                            # Get only 10 first rows from MySQLResult and turn into a data.frame
dbClearResult(query)                                       # Clear query result


# ----- Reading from HDF5 -----
# https://www.hdfgroup.org/
# Heirarchical data format
# To store large data sets
# HDF5 interface for R Manual:
#    http://bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf
source("http://bioconductor.org/biocLite.R")  # Install source dependency
biocLite("rhdf5")                             # Install R HDF5 package
library(rhdf5)

created = h5createFile("example.h5")                # Create HDF5 file
created = h5createGroup("example.h5", "foo")        # Create group in HDF5 file
created = h5createGroup("example.h5", "baa")        # Create group in HDF5 file
created = h5createGroup("example.h5", "foo/foobaa") # Create subgroup in HDF5 file
h5ls("example.h5")                                  # List info from HDF5 file

A = matrix(1:10, nr = 5, nc = 2)
h5write(A, "example.h5", "foo/A")                   # Write matrix A in foo group
B = array(seq(0.1,2.0, by = 0.1), dim = c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")            # Write array b in foo/foobaa subgroup
h5ls("example.h5")

df = data.frame(1L:5L, seq(0,1,length = 5), c("ab","cde","fghi","a","s"), stringsAsFactors = FALSE)
h5write(df, "example.h5", "df")                    # Write data.frame df in df group
h5ls("example.h5")

readA = h5read("example.h5","foo/A")               # Read matrix A from foo group
readB = h5read("example.h5","foo/foobaa/B")        # Read array B from foo subgroup
readdf = h5read("example.h5","df")                 # Read data frame df from df group

h5write(c(12,13,14), "example.h5", "foo/A", index=list(1:3,1))   # Write a chunk in matrix A in foo group
h5read("example.h5","foo/A")
h5read("example.h5","foo/A", index=list(1:3,1))                  # Read only index list


# ----- Readind from The Web -----
# https://en.wikipedia.org/wiki/Web_scraping

con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)

# Esse aqui nao ta rolando
library(XML)
url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes = T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

# Esse aqui nao ta rolando tbm
# Reading from httr packages
# DEPENDENCY sudo apt-get install libssl-dev
install.packages("httr")
library(httr)
html2 = GET(url)
content2 <- content(html2, as = "text")
parseHtml <- htmlParse(content2, asText = TRUE)
xpathSApply(parseHtml, "//title", xmlValue)

# Acessing websites with password
pg1 = GET("http://httpbin.org/basic-auth/user/passwd") # Auth needed
pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user", "passwd"))

# Using handles
google <- handle("http://google.com")        # Store host
pg1 <- GET(handle = google, path = "/")      # Acess url using handled host
pg2 <- GET(handle = google, path = "search") # Acess url using handled host


# ----- Reading from APIs -----
# In this case, an authentication is needed
myapp <- oauth_app("twitter",
                   key="yourCustomerKeyHere", secret="yourCustomerSecretHere")
sig = sign_oauth1.0(myapp,
                    token = "yourTokenHere",
                    token_secret = "yourTokerSecretHere")
homeTL <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
json1 <- content(homeTL)
json2 <- jsonlite::fromJSON(toJSON(json1))


# ----- Reading from Other Sources -----
# Foreign packages, functions to read
# Weka, Sata, Minitab, Octave, SPSS, SAS
# Help page: https://cran.r-project.org/web/packages/foreign/foreign.pdf

# RPostgreSQL
# Help page: https://cran.r-project.org/web/packages/RPostgreSQL/RPostgreSQL.pdf
# RODBC (interface for multiple database like PostgreSQL, MySQL, SQLite, MS Acess)
# Help page: https://cran.r-project.org/web/packages/RODBC/RODBC.pdf
# MongoDB
# Help page: https://cran.r-project.org/web/packages/RMongo/RMongo.pdf

# Reading images
# jpeg: https://cran.r-project.org/web/packages/jpeg/
# readbitmap: https://cran.r-project.org/web/packages/readbitmap/
# png: https://cran.r-project.org/web/packages/png/

# Reading GIS data
# rgdal: https://cran.r-project.org/web/packages/rgdal/
# rgeos: https://cran.r-project.org/web/packages/rgeos/
# raster: https://cran.r-project.org/web/packages/raster/

# Reading music data
# tuneR: https://cran.r-project.org/web/packages/tuneR/
# seewave: http://rug.mnhn.fr/seewave
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
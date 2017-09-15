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

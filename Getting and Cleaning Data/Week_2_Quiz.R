# Question 01
# Register: https://github.com/settings/applications
# Url I want: https://api.github.com/users/jtleek/repos
# Tutorial API: https://github.com/hadley/httr/blob/master/demo/oauth2-github.r

# Question 02
install.packages("sqldf")
library(sqldf)
sqldf("select pwgtp1 from acs where AGEP < 50")

# Question 03
sqldf("select distinct AGEP from acs")

# Question 04 -> 45 31 7 25
conn <- url("http://biostat.jhsph.edu/~jleek/contact.html")
lines <- readLines(conn)
close(conn)
nchar(c(lines[10],lines[20],lines[30],lines[100])) 

# Question 05 -> 32426.7
x <- read.fwf(file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"),
              skip=4,
              widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
sum(x$V4) # I got 37546.3, but the correct answer in the course is 32426.7
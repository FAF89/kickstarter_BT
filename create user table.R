##################################################################
#saved as user.csv (includes only first projects, based on decisions made in file 3)
##################################################################


path <- "C:\\Users\\Ofir\\Desktop\\Thesis\\Kickstarter\\sandboxCleaned.csv"
temp <- read.csv(path, header = T)
temp$X <- NULL
user <- temp[,c(1,12,14,16,23,25,33,48)]#add personal web

rm(path,temp)

path <- "C:\\Users\\Ofir\\Desktop\\Thesis\\Kickstarter\\web.csv"
web <- read.csv(path, header = T)
web <- web[,c("url","personal")]

rm(path)

user <- sqldf("select *
from user left join web on web.url=user.url")

user$url <- NULL
user$url <- NULL

user[is.na(user$personal),"personal"] <- 0 #fill in the nulls for users with no site at all.

#change the values to be such that created is the number created up until the last project and the numSuccess is up until the last project (not including current)
user$created <- user$created-1

#there are 4 campagins that were successful but canceled we will remove them as there is problem with thier data.
user <- user[-c(761,1315,2887,3141),]

rm(web)

#remove success to the end of table
temp <- user$success
user$success <- NULL
user$success <- temp

rm(temp)

#screen only users with first project
user <- user[user$created==0,]
user$created <- NULL

path <- "C:\\Users\\Ofir\\Desktop\\Thesis\\Kickstarter\\user.csv"
write.csv(user, path)

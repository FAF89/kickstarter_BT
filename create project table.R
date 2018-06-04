path <- "C:\\Users\\Ofir\\Desktop\\Thesis\\Kickstarter\\sandboxCleaned.csv"
temp <- read.csv(path, header = T)
temp$X <- NULL

#select wanted features
project <- temp[,c(1,6,10,25,33,38,39,40,41,42,47,53)]

#add website features
path <- "C:\\Users\\Ofir\\Desktop\\Thesis\\Kickstarter\\web.csv"
web <- read.csv(path, header = T)
web$X <- NULL

project <- sqldf("select *
                 from project left join web on web.url=project.url")

#remove access columms
project$url <- NULL
project$url <- NULL

#remove success to the end of table
temp <- project$success
project$success <- NULL
project$success <- temp

#fill in the nulls for users with no site at all.
project[is.na(project$social),"social"] <- 0 
project[is.na(project$business),"business"] <- 0
project[is.na(project$visual),"visual"] <- 0
project[is.na(project$music),"music"] <- 0
project[is.na(project$retail),"retail"] <- 0
project[is.na(project$personal),"personal"] <- 0


path <- "C:\\Users\\Ofir\\Desktop\\Thesis\\Kickstarter\\project.csv"
write.csv(project, path)

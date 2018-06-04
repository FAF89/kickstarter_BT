path <- "C:\\Users\\Ofir\\Desktop\\Thesis\\Kickstarter\\sandbox.csv"
sandbox <- read.csv(path, header = T)
sandbox$X <- NULL

#we can not see past project in the holand DB
ans <- sqldf("select creator, created, numSuccessfulCampaigns 
from sandbox
where creator like 'Tethered by Letters'") 

#see which users do have more than 1 project in DB
ans <- sqldf("select creator, count(*) as count
from sandbox
group by creator")

ans <- sqldf("
select creator, count
from ans
where count>1
")

#all duplicated rows were cancelled or suspended projects (for some reason), not all canceled entries are duplicated.
sum(duplicated(sandbox))
duplicated <- sandbox[duplicated(sandbox),] #see all duplicated

ans <- sandbox[sandbox$canceled==TRUE,] #see all calceled

sandbox <- sandbox[!duplicated(sandbox),] #remove duplicated

#found another duplicate, should be by the url to search for duplicates.
sum(duplicated(sandbox$url))
sandbox[duplicated(sandbox$url),3]

sandbox <- sandbox[!duplicated(sandbox$url),]

path <- "C:\\Users\\Ofir\\Desktop\\Thesis\\Kickstarter\\sandboxCleaned.csv"
write.csv(sandbox, path)

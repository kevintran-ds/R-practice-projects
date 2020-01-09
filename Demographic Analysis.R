stats <- read.csv(file.choose())
stats
nrow(stats)
ncol(stats)
head(stats)
str(stats)
summary(stats)

#basic operations
stats[1:10,]
stats[c(4,100),]
#filtering data frames
filter <- stats$Internet.users < 2
stats[filter,]
stats[stats$Birth.rate > 40,]
stats[stats$Birth.rate > 40 & stats$Internet.users < 2,]
stats[stats$Country.Name == "Malta",]

#Using qplot
library(ggplot2)
qplot(data=stats, x=Internet.users)
qplot(data=stats, x=Income.Group, y=Birth.rate)
qplot(data=stats, x=Income.Group, y=Birth.rate, size=3)

#Creating dataframes
mydf <- data.frame(Countries_2012_Dataset, Codes_2012_Dataset, 
                   Regions_2012_Dataset)
head(mydf)
colnames(mydf) <- c("Country", "Code", "Region")
head(mydf)

#merging dataframes
merged <- merge(stats,mydf,by.x="Country.Code",by.y="Code")
#took out a replica column with a different name
merged$Country <- NULL

#visualizing with merged data
qplot(data=merged,x=Internet.users,y=Birth.rate)
qplot(data=merged,x=Internet.users,y=Birth.rate,colour=Region,
      size=I(4),shape=I(18),alpha=I(0.5),main="Birth rate vs Internet users")

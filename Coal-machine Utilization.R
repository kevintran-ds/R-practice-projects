util <- read.csv(file.choose())
head(util,12)
str(util)
summary(util)
#deriving utilization column
util$Utilization = 1 - util$Percent.Idle
head(util,12)
#handling date - times in R
util$PosixTime <- as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M")
head(util,12)
#how to rearrange columns in a dataframe:
util$Timestamp <- NULL
head(util,12)
util <- util[,c(4,1,2,3)]
#what is a list
summary(util)
RL1 <- util[util$Machine=="RL1",]
summary(RL1)
RL1$Machine <- factor(RL1$Machine)
summary(RL1)
#Construct list:
#character: machine name
#vector: (min,mean,max) Utilization for the month 
#Logical: has utilization ever fallen below 90%? TRUE/FALSE
util_stats_rl1 <- c(min(RL1$Utilization, na.rm=T),
                    mean(RL1$Utilization, na.rm=T),
                    max(RL1$Utilization, na.rm=T))
util_stats_rl1
length(which(RL1$Utilization < 0.90)) > 0
util_under_90_flag <-length(which(RL1$Utilization < 0.90)) > 0
util_under_90_flag
list_rl1 <- list("RL1",util_stats_rl1, util_under_90_flag)
list_rl1
#Naming components of a list
names(list_rl1) <- c("Machine","stats", "LowThreshold")
list_rl1
#Extracting components of a list
#[] wil always return a list
#[[]] will return the actual object
#$ same as [[]] but simpler

list_rl1[1]
list_rl1[[1]]
#Adding and deleting list components
list_rl1[4] <- "New Information"
list_rl1
list_rl1[4] <- NULL
#Vector: all hours where utilization is unknown (NA)
list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization), "PosixTime"]
list_rl1
#Dataframe for this machine
list_rl1$Data <- RL1
list_rl1
summary(list_rl1)
list_rl1$UnkownHours = NULL
summary(list_rl1)
#Subsetting a list
list_rl1[1:3]
sublist_rl1 <- list_rl1[c("Machine","Stats")]
sublist_rl1[[2]][2]
#building a timeseries plot
install.packages("ggplot2")
library(ggplot2)
p <- ggplot(data=util)
p + geom_line(aes(x=PosixTime, y=Utilization, colour=Machine), size=1.2)+
  facet_grid(Machine~.) + geom_hline(yintercept = 0.90, colour = "Gray",size=1.2,
                                     linetype=3)
myplot <- p + geom_line(aes(x=PosixTime, y=Utilization, colour=Machine), size=1.2)+
  facet_grid(Machine~.) + geom_hline(yintercept = 0.90, colour = "Gray",size=1.2,
                                     linetype=3)
myplot
list_rl1$Plot <- myplot

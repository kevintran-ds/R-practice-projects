#getting the data and analyzing what we have whilst changing column names
movies <- read.csv(file.choose())
head(movies)
colnames(movies) <- c("Film","Genre", "CriticRating", "AudienceRating", "BudgetMillions", "Year")                   
head(movies)
str(movies)
factor(movies$Year)
movies$Year <- factor(movies$Year)
summary(movies)


#aesthetics
library(ggplot2)
ggplot(data=movies,aes(x=CriticRating,y=AudienceRating))+ geom_point()
#adding colour
ggplot(data=movies,aes(x=CriticRating,y=AudienceRating, colour=Genre))+ geom_point()
#adding size
ggplot(data=movies,aes(x=CriticRating,y=AudienceRating, colour=Genre,size=BudgetMillions))+ geom_point()
p <- ggplot(data=movies,aes(x=CriticRating,y=AudienceRating, colour=Genre,size=BudgetMillions))+ geom_point()
#point
p + geom_point()
#lines
p + geom_line()
#multiple layers
p + geom_point() + geom_line()
#reducing line size
p + geom_line(size=1) + geom_point()

#histograms and density
s <- ggplot(data=movies, aes(x=BudgetMillions))
s + geom_histogram(binwidth=5)
#adding colours
s + geom_histogram(binwidth=5,aes(fill=Genre))
#adding border
s + geom_histogram(binwidth=5,aes(fill=Genre),colour="Black")
#density
s + geom_density(aes(fill=Genre),position="stack")
#statistical transformations
u<- ggplot(data=movies, aes(x=CriticRating,y=AudienceRating, colour=Genre))
#using a smoother
u + geom_point() + geom_smooth(fill=NA)
#boxplots
u <- ggplot(date=movies,aes(x=Genre, y=AudienceRating,colour=Genre))
u + geom_boxplot()
u + geom_boxplot(size=1)
u + geom_boxplot(size=1) + geom_jitter()
#adding themes
o <- ggplot(data=movies,aes(x=BudgetMillions))
h <- o + geom_histogram(binwidth = 10,aes(fill=Genre), colour="Black")
h
#adding axes labels
h + xlab("Money Axis") + ylab("Number of Movies")
+ theme(axis.title.x=element_text(colour="DarkGreen",size=20),
        axis.title.y=element_text(colour="Red",size=20))

#####
#Code for "Introduction to R"
#J Davis
#23 October 2015
#
#For this talk I am going to assume no knowledge of R. I will, however, assume you have some 
#reasons of your own to be interested in R.

#####
#Some useful tidbits. Here are some things I find useful in R/Rstudio.
#I try to include a slide with them in every R talk.
#Use the question mark for help
? sin
#rm() will clear a variable
p <- 17
rm(p)

#####
#Installing packages

#Generic command to install from CRAN
install.packages("coin")

#To make the above available in your R session
library(coin)

#The syntax to install non-CRAN packages can vary greatly
#For biocLite
source("http://bioconductor.org/biocLite.R")
biocLite

#To install from a zip file on Hadley Wickam's github repository
install.packages("devtools")
library(devtools)
install_url("https://github.com/hadley/stringr/archive/master.zip")

#####
#Creating some Data.
#Specifically we'll create an play with a set of morphometric measurements of eight birds.

#The left arrow can be used for assignment. So we might start assigning variable one-by-one

a <- 59
b <- 55
c <- 53.5

#We could have used the equal sign, but I prefer the arrow for assignment.

a = 59

#At this point R knows that a has the value 59 and if we evaluate the logical
#operation a == 59 we get TRUE
a
a == 59

#Now a, b, and c are pretty arbitrary names. We might try to make some better names.
Wing1 <- 59
Wing2 <- 55
Wing3 <- 53.5
Wing4 <- 55
Wing5 <- 52.5

#We can do some arithmetic operations
sqrt(Wing1)
Wing2 + Wing3
(Wing1 + Wing2 + Wing3 + Wing4 + Wing5)/5

#Or store the results of these in other variables
SQ.Wing1 <- sqrt(Wing1)
Sum.23 <- Wing2 + Wing3
Mean.Wing < -(Wing1 + Wing2 + Wing3 + Wing4 + Wing5)/5

#Check the value of SQ.Wing1. We are relieved to see it is 7.68
SQ.Wing1

#Example of c() to combine values into a longer vector
Wingcrd <- c(59, 55, 53.5, 55, 52.5, 57.5, 53, 55)

#Access values in the vector by accessing with []
Wingcrd[1]
Wingcrd[3]
Wingcrd[1:3]
Wingcrd[-2]
sum(Wingcrd)

#Let's finish off the other columns of the dataset
Tarsus <- c(22.3, 19.7, 20.8, 20.3, 20.8, 21.5, 20.6, 21.5)
Head <- c(31.2, 30.4, 30.6, 30.3, 30.3, 30.8, 32.5, NA)
Wt <- c(9.5, 13.8, 14.8, 15.2, 15.5, 15.6, 15.6, 15.7)

#Since Head has a missing value this means some calculations return missing values
sum(Head)

#To ignore missing values 
sum(Head, na.rm = TRUE)

#Comibine the vectors with cbind() to make an 8x4 matrix
BirdData <- cbind(Wingcrd, Tarsus, Head, Wt)
BirdData

#Can specify elements by row and column
BirdData[1,2]
BirdData[1,2:4]
BirdData[, 3] #Note the missing value
BirdData[1, c(2, 3)]

#Let's save BirdData in a csv file
#First check the present working directory
getwd()

#We can change this value with setwd() if we want.

write.table(BirdData, "BirdData.csv", sep=",")

data <- read.csv("BirdData.csv", header = TRUE)

#Be aware that while BirdData was a matrix, data is a dataframe.
#Most R functions are written with dataframes in mind.

#Accessing data is similiar in a dataframe

BirdDF[1,2]
BirdDF[1,2:4]
BirdDF[3, ]
BirdDF[1, c(2, 3)]

#However, matrix operations won't work
BirdDF %*% t(BirdDF)

#But now the column names actually do something
BirdDF$Wingcrd

#You can convert between the two datatypes easily
as.matrix(BirdDF)
as.data.frame(BirdData)

#####
#Plotting
#We will use the cars dataset to explore plotting. Let's take a look at it in a dataframe
#of car speeds and stopping times from the 1920s.
#(Ezekiel, M. (1930) Methods of Correlation Analysis. Wiley. )
#Take a look at the first six data entries.
head(cars)

#By default we get a scatterplot
plot(cars)

#We can change the parameter defaults
plot(cars$speed, cars$dist, main="A Title",
          xlab = "The Speeds", ylab = "The Distances", 
	       col="steel blue")

#Combining plots naïvely can produce junky plots.
#The lowess() function is a local polynomial smoother.
plot(cars)
par(new=TRUE)
plot(lowess(cars), type = "l", col = "red")

     
#Standard R graphics have special functions to add lines and such
plot(cars)
line(lowess(cars),
          col="red")

#To make plots in subplots use par() to divide the plot area
par(mfrow=c(2,2))
plot(cars,type="p")
plot(cars,type="l")
plot(cars,type="h")
plot(cars,type="s")

#Default plot type for a dataframe is a scatterplot
plot(BirdDF)

#Scatterplots can get kind of crazy
plot(mtcars)

#But you can always write it to a file
png(filename = "mess.png")
plot(mtcars)
dev.off()

###
#Statistical methods
#How about a t-test on whether the mean speed in the cars dataset is 12
t.test(cars$speed, mu = 12) 

#Or maybe a t-test with different parameters?
#Test when the mean is 12 vs the alternative that it's lower.
t.test(cars$speed, mu = 12, alternative = "less", conf.level = .99) 

#Linear regression
#Let's do a simple regression on the cars dataset.
#We regress stopping distance on speed.
lm(dist ~ speed, cars)

#Store in a variable. The class of car.fit is lm (for linear model.)
car.fit <- lm(dist ~ speed, cars) 

#summary is a generic function that provides a lot of output
summary(car.fit)

#For individual details we can look at the fields of car.fit
car.fit$coefficients
car.fit$residuals[1:3]
car.fit$fitted.values[1:3]
t(BirdDF)

#Scatterplots can get kind of crazy
plot(mtcars)

#But you can always write it to a file
png(filename = "mess.png")
plot(mtcars)
dev.off()

###
#Statistical methods
#How about a t-test on whether the mean speed in the cars dataset is 12
t.test(cars$speed, mu = 12) 

#Or maybe a t-test with different parameters?
#Test when the mean is 12 vs the alternative that it's lower.
t.test(cars$speed, mu = 12, alternative = "less", conf.level = .99) 

#Linear regression
#Let's do a simple regression on the cars dataset.
#We regress stopping distance on speed.
lm(dist ~ speed, cars)

#Store in a variable. The class of car.fit is lm (for linear model.)
car.fit <- lm(dist ~ speed, cars) 

#summary is a generic function that provides a lot of output
summary(car.fit)

#For individual details we can look at the fields of car.fit
car.fit$coefficients
car.fit$residuals[1:3]
car.fit$fitted.values[1:3]

#Let's take a look at the fit. Looks pretty good.
plot(cars$speed, cars$dist, xlab = "distance", ylab = "speed")
abline(car.fit, col="red")

#Also, lm objects have their own default plots.
plot(car.fit)

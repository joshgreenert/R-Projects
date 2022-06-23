# Assignment: American Community Survey Exercise
# Name: Greenert, Joshua
# Date: 6/22/2022

library(ggplot2)
setwd("C:/Users/Josh/Documents/GitHub/R-Projects/Statistics For Data Science")
american_community <- read.csv("data/acs-14-1yr-s0201.csv")

## 1.What are the elements in your data (including the categories and data types)?
str(american_community)

## 2.Please provide the output from the following functions: str(); nrow(); ncol()
str(american_community)  ## large output
nrow(american_community) ## 136
ncol(american_community) ## 8

## 3.Create a Histogram of the HSDegree variable using the ggplot2 package
ggplot(american_community, aes(x = HSDegree)) + geom_histogram(bins = 10) + ggtitle("High School Completion %") + xlab("HS Complete %") + ylab("Population")

## 4.Answer the following questions based on the Histogram produced:

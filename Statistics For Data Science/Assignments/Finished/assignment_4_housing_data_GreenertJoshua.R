# Assignment: ASSIGNMENT 4 Housing Data
# Name: Greenert, Joshua
# Date: 7/1/2022

'''
We interact with a few datasets in this course, one you are already familiar with, the 2014 American Community Survey and 
the second is a Housing dataset, that provides real estate transactions recorded from 1964 to 2016.  For this exercise, you 
need to start practicing some data transformation steps – which will carry into next week, as you learn some additional 
methods.  For this week, using either dataset (or one of your own – although I will let you know ahead of time that the 
Housing dataset is used for a later assignment, so not a bad idea for you to get more comfortable with now!), perform the 
following data transformations:
'''
setwd("C:/Users/Josh/Documents/GitHub/R-Projects/Statistics For Data Science")
housingDF <- read_excel("data/week-6-housing.xlsx")
str(housingDF)

# 1.Use the apply function on a variable in your dataset
# Used sales price from the dataset.
salePrice = housingDF['Sale Price']
apply(salePrice, 2,  sum )

# 2.Use the aggregate function on a variable in your dataset
# Aggregating the sale price with the sitetype for the mean price.
aggregate(`Sale Price` ~ sitetype, housingDF, mean)

# 3.Use the plyr function on a variable in your dataset – more specifically, I want to see you split some data, 
#   perform a modification to the data, and then bring it back together
# PLYR isn't a function, it's a package that contains other functions.  Using ddply()
obp <- function(data)
{
  data.frame(bedPerSquareFeet=with(data, square_feet_total_living / bedrooms))
}

plyrChange = ddply(housingDF, "bedrooms", .fun=obp)

# 4.Check distributions of the data
ggplot(plyrChange, aes(bedPerSquareFeet) ) + geom_histogram()

# 5.Identify if there are any outliers
From the histogram shown, it appears that there are some locations that have more square feet than others than the
majority.  There are houses where the bedPerSquareFeet is greater than 2000 ft.

# 6.Create at least 2 new variables
numberOfBPSF <- nrow(subset(plyrChange, bedPerSquareFeet > 2000))
# result = 33
This variable shows the number of houses with a greater square feet per bedroom over 2000.

numberOfBedroomsOutlier <- nrow(subset(plyrChange, bedrooms > 10))
# result = 1
This variable shows us another outlier where the bedroom numbers are greater than 10

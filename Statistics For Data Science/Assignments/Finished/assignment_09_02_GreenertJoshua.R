# Assignment: ASSIGNMENT 9 Exercise 2
# Name: Greenert, Joshua
# Date: 8/4/2022
library(mlogit)
library(car)


# Set the working directory.
setwd("C:/Users/Josh/Documents/GitHub/R-Projects/Statistics For Data Science")
classifierDF <- read.csv("data/binary-classifier-data.csv")

# The dataset (found in binary-classifier-data.csv) contains three variables; label, x, and y. The label variable is 
#  either 0 or 1 and is the output we want to predict using the x and y variables.
# What is the accuracy of the logistic regression classifier?
binaryClassifierModel <- glm(label ~ x + y, data = classifierDF, family = binomial())
summary(binaryClassifierModel)
'''
From the summary, we can see that the estimates substantially low regarding x and y.
X = 0.0025
Y = 0.0079
'''

# Set the prediction with the model and the dataframe.
predictions <- predict(binaryClassifierModel, classifierDF)

# The label variable is set to either 0 or 1.  Set predictions to match format.
classifierDF$predictions <- ifelse(predictions >= 0.5, 0, 1)
accuracyCheck <- mean(classifierDF$predictions == classifierDF$label)
accuracyCheck
'''
The accuracy check of the predictors returns a value of 48.80%
'''


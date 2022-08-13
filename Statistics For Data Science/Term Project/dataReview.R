# Assignment: Term Project Spelunking
# Name: Greenert, Joshua
# Date: 7/30/2022
library(mlogit)
library(car)

## Set the working directory to the root of your DSC 520 directory
setwd("C:/Users/Josh/Documents/GitHub/R-Projects/Statistics For Data Science/Term Project")

homePriceIndexDF <- read.csv("HPI_master2.csv")
minimumWageDF <- read.csv("Minimum Wage Data.csv")
dollarHistoryDF <- read.csv("US Dollar Index Historical Data.csv")
unemploymentHistoryDF <- read.csv("Unemployment.csv")

# Minimum wage by state
ggplot(minimumWageDF, aes(x = Year, y = Effective.Minimum.Wage, col = State)) + geom_point() + geom_smooth()

# Home Price Index by period.
ggplot(homePriceIndexDF, aes(x = yr, y = index_sa, col = period)) + geom_point() +
  geom_smooth() + ggtitle("Home Price Index") + xlab("Year") + ylab("NSA")

# Dollar history.
ggplot(dollarHistoryDF, aes(Price)) + geom_histogram(bins = 100) + ggtitle("US Dollar Index") + xlab("Date") + ylab("Price")

# FL unemployment history (all states not shown here)
flUnemployment <- subset(unemploymentHistoryDF, State == "FL")
ggplot(flUnemployment, aes(x = Year, y = Unemployment_rate)) + geom_point() +
  geom_smooth() + ggtitle("FL Unemployment Rate") + xlab("Year") + ylab("Rate Data")

# Predictions.
unemploymentModel <- glm(Unemployment_rate ~ Year + State, data = unemploymentHistoryDF, family = gaussian())
summary(unemploymentModel)

# Set the prediction with the model and the dataframe.
predictions <- predict(unemploymentModel, unemploymentHistoryDF)

unemploymentHistoryDF$predictions <- ifelse(predictions >= 0.5, 0, 1)
accuracyCheck <- mean(unemploymentHistoryDF$predictions == unemploymentHistoryDF$Unemployment_rate)
accuracyCheck

# Predictions.
wageModel <- glm(Year ~ Effective.Minimum.Wage + State + State.Minimum.Wage, data = minimumWageDF, family = gaussian())
summary(wageModel)

# Set the prediction with the model and the dataframe.
predictions <- predict(wageModel, minimumWageDF)

minimumWageDF$predictions <- ifelse(predictions >= 0.5, 0, 1)
accuracyCheck <- mean(minimumWageDF$predictions == minimumWageDF$Unemployment_rate)
accuracyCheck


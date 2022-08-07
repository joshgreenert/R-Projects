# Assignment: Term Project Spelunking
# Name: Greenert, Joshua
# Date: 7/30/2022

## Set the working directory to the root of your DSC 520 directory
setwd("C:/Users/Josh/Documents/GitHub/R-Projects/Statistics For Data Science/Term Project")

homePriceIndexDF <- read.csv("HPI_master.csv")
minimumWageDF <- read.csv("Minimum Wage Data.csv")
dollarHistoryDF <- read.csv("US Dollar Index Historical Data.csv")

#ggplot(minimumWageDF, aes(x = Year, y = Effective.Minimum.Wage, col = State)) + geom_point() + geom_smooth()


#ggplot(homePriceIndexDF, aes(x = yr, y = index_sa, col = period)) + geom_point() +
#  geom_smooth() + ggtitle("Home Price Index") + xlab("Year") + ylab("NSA")


ggplot(dollarHistoryDF, aes(x = yr, y = index_sa, col = period)) + geom_point() +
  geom_smooth() + ggtitle("Home Price Index") + xlab("Year") + ylab("NSA")

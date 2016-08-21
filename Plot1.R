#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Load required package
require(dplyr)

#Calculate the total kilotonnage of PM2.5 by year
TotalPMbyYear <- NEI %>%
  group_by(year) %>%
  summarize(TotalPM25 = sum(Emissions)/1000000)

#Plot the barchart 
NatsBarplot <- barplot(TotalPMbyYear$TotalPM25, main = "Total Emission of PM25", names.arg = TotalPMbyYear$year, xlab = "Year", ylab = "PM25 Total Emission (kiloton)")
lines(x = NatsBarplot, y = TotalPMbyYear$TotalPM25, col = "red", lwd = 2)

#save as png file
dev.copy(png, file = "plot1.png")
dev.off()
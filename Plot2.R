#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Load required package
require(dplyr)

#Subset to limit the location to Baltimore, MD
BalMD <- subset(NEI, fips == "24510")

#Calculate the total kilotonnage of PM2.5 by year
BalPMbyYear <- BalMD %>%
  group_by(year) %>%
  summarize(TotalPM25 = sum(Emissions)/1000)

#Plot the barchart 
BalMDBarplot <- barplot(BalPMbyYear$TotalPM25, main = "Total Emission of PM25 of Baltimore, MD", names.arg = BalPMbyYear$year, xlab = "Year", ylab = "PM25 Total Emission (Kiloton)")
lines(x = BalMDBarplot, y = BalPMbyYear$TotalPM25, col = "red", lwd = 2)

#save as png file
dev.copy(png, file = "plot2.png")
dev.off()
#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Load required package
require(dplyr)
require(ggplot2)

#Subset to limit the location to Baltimore, MD
BalMD <- subset(NEI, fips == "24510")

#Calculate the total kilotonnage of PM2.5 by year by type
BalPMbyYearType <- BalMD %>%
    group_by(year, type) %>%
    summarize(TotalPM25 = sum(Emissions)/1000)


#Make the 
g <- ggplot(BalPMbyYearType, aes(year, TotalPM25, col = type, label = round(TotalPM25, digits = 2)))
g <- g + geom_line()  + geom_text(aes(label=round(TotalPM25, digits = 2)),hjust=0.5, vjust=1.5) + labs(x = "Year") + labs(y = "PM25 Total Emission (Kiloton) ") + ggtitle("Emission of PM25 of Baltimore by Type, 1998~2008")
print(g)

#save as png file
dev.copy(png, file = "plot3.png")
dev.off()

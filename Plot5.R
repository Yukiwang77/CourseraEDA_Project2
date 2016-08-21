#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Load required package
require(dplyr)
require(ggplot2)

#Subset to limit the location to Baltimore, MD and on-road
BalMD_OnRoad <- subset(NEI, fips == "24510" & type == "ON-ROAD")
OnRoad <- BalMD_OnRoad %>%
  group_by(year) %>%
  summarize(OnRoadPM25 = sum(Emissions)/1000)

#plot the trendline of PM25 in kiloton
g <- ggplot(OnRoad, aes(year, OnRoadPM25, label = round(OnRoadPM25, digits = 2)))
g <- g + geom_line() + geom_point() + geom_text(aes(label=round(OnRoadPM25, digits = 2)),hjust=0.5, vjust=1.5) + labs(x = "Year") + labs(y = "Total PM25 Emission (kiloton)") + ggtitle("Motor Vehicle PM25 Emission of Baltimore 1998~2008")
print(g)

#save as png file
dev.copy(png, file = "plot5.png")
dev.off()
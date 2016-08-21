#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Load required package
require(dplyr)
require(ggplot2)

#set up the dataset and calculate the total
CoalSource <- which(grepl("Coal", SCC$Short.Name, ignore.case = TRUE))
Coal.SCC <- SCC[CoalSource, ]
Coalset <- merge(NEI, Coal.SCC, by ="SCC")
NatsCoal <- Coalset %>%
  group_by(year) %>%
  summarize(CoalPM25 = sum(Emissions)/1000)

#plot the trendline of PM25 in kiloton
g <- ggplot(NatsCoal, aes(year, CoalPM25,label = round(CoalPM25, digits = 2)))
g <- g + geom_line() + geom_point() + geom_text(aes(label=round(CoalPM25, digits = 2)),hjust=0.5, vjust=1.5) + labs(x = "Year") + labs(y = "Total PM25 Emission (kiloton)") + ggtitle("Coal Combustion Related PM25 Emission 1998~2008")
print(g)

#save as png file
dev.copy(png, file = "plot4.png")
dev.off()

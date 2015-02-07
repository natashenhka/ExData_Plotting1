library(data.table)
header<- read.table('household_power_consumption.txt',  nrow=1, sep=";", header=FALSE, colClasses="character")
header<-unlist(header, use.names=FALSE)
tipo<-c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
row<-read.table('household_power_consumption.txt', skip=1, sep=";", na.strings="?", colClasses=c(tipo))
colnames(row)<-c(header)
row<-row[which (grepl("^1/2/2007", row$Date) | grepl("^2/2/2007", row$Date)),]
#2880
datetime<-paste(row$Date, row$Time)
x<-strptime(datetime, "%d/%m/%Y %H:%M:%S")
row$DateTime<-x
png(filename = "plot1.png", width = 480, height = 480,  units = "px", bg = "transparent")
par(bg="white")
hist(row$Global_active_power, freq=TRUE, col='red',  main = paste("Global Active Power"), xlab=paste("Global Active Power(kilowatts)"))
dev.off()

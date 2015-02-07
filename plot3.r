library(data.table)
header<- read.table('household_power_consumption.txt',  nrow=1, sep=";", header=FALSE, colClasses="character")
header<-unlist(header, use.names=FALSE)
tipo<-c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
row<-read.table('household_power_consumption.txt', skip=1, sep=";", na.strings="?", colClasses=c(tipo))
colnames(row)<-c(header)
row<-row[which (grepl("^1/2/2007", row$Date) | grepl("^2/2/2007", row$Date)),]
#2880
datetime<-paste(row$Date, row$Time)
x<-strptime(datetime, "%d/%m/%Y %H:%M:%S", tz="UTC")
row$DateTime<-x
png(filename = "plot3.png", width = 480, height = 480,  units = "px", bg = "transparent")
Sys.setlocale("LC_TIME", "English")
plot(row$DateTime, row$Sub_metering_1, col="black", type="l",  xlab= '', ylab=paste("Energy sub metering") )
lines(row$DateTime, row$Sub_metering_2, col="red", type="l" )
lines(row$DateTime, row$Sub_metering_3, col="blue", type="l" )
legend("topright", lty=1, c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ), col=c("black", "red", "blue"))
dev.off()


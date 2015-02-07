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
png(filename = "plot4.png", width = 480, height = 480,  units = "px", bg = "transparent")
Sys.setlocale("LC_TIME", "English")
par(mfrow=c(2,2), mar=c(4,4,2,2))
a1=plot(row$DateTime, row$Global_active_power, type="l",  xlab= '', ylab=paste("Global Active Power"))
a2=plot(row$DateTime, row$Voltage, type="l",  xlab= 'datetime', ylab=paste("Voltage"))
a=plot(row$DateTime, row$Sub_metering_1, col="black", type="l",  xlab= '', ylab=paste("Energy sub metering") )
b=with(a, lines(row$DateTime, row$Sub_metering_2, col="red", type="l" ))
c=with(b, lines(row$DateTime, row$Sub_metering_3, col="blue", type="l" ))
d=with(c, legend("topright", lty=1, c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ), col=c("black", "red", "blue")))
a4=plot(row$DateTime, row$Global_reactive_power, col="black", type="l",  xlab= 'datetime', ylab=paste("Global_reactive_power") )
dev.off()


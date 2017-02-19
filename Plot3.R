



library(lubridate)


#Import the data to a dataframe

##############################################################################
#
# PART I: import data, filter and subset
#
##############################################################################

# 1. Setting directory and files


#1.a Check if working directory exists and create one
if (!file.exists("Course_Project_1")) {
    dir.create("Course_Project_1")
}


setwd("./Course_Project_1")

#1.b download and unzip files 


file_url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(file_url,destfile = "dataset.zip")


unzip("dataset.zip")
unlink("dataset.zip")
#remove unnecessary variables
rm(file_url)

dir()

file_txt<-"household_power_consumption.txt"
temp_class<-read.table(file_txt,
                       sep=";", 
                       header = TRUE, 
                       nrows = 5)

classes<-sapply(temp_class,class)

#now we can specify the class of every column, making it easier for
#the read.table function
data_raw <- read.table(file_txt, 
                       sep=";",
                       header = TRUE,
                       colClasses = classes, 
                       na.strings = "?")

#remove unnecessary variables

rm(temp_class, file_txt, classes)
head(data_raw)

#format factor variables to date:
data_raw$datetime<-dmy_hms(
    paste(as.character(data_raw$Date),as.character(data_raw$Time)))

data_raw$Date<-dmy(data_raw$Date)
data_raw$Time<-hms(data_raw$Time)


#create  filtered table

epc<-subset(data_raw, Date=="2007/02/01" | Date=="2007/02/02")

rm(data_raw)
########################################################################




##############################################################################
#
# PART II: PLOTS
#
##############################################################################




#Plot 3


with(epc, plot(datetime, Sub_metering_1, 
               type="n",
               xlab="",
               ylab= "Energy sub metering"
               
))
with(epc, lines(datetime,Sub_metering_1))
with(epc, lines(datetime,Sub_metering_2, col="red"))
with(epc, lines(datetime,Sub_metering_3, col="blue"))

legend_names<-c("Sub_metering_1", 
                "Sub_metering_2", 
                "Sub_metering_3")

legend("topright", 
       legend=legend_names,
       col=c("black","red","blue"),
       lty=1,
       text.width = strwidth(legend_names[1])
       
)
dev.copy(png, "Plot3.png", height = 480, width = 480)
dev.off()


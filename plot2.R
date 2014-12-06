## plot2.R code for the plotting of data from the "household_power_consumption.txt" dataset
## This plot is to produce a Line Graph of Global Active Power (kilowatts)

##############################################
## First Part: File Selection and Data Sort ##
##############################################

## The first part of this function is repeatable through the different graphs required 

## Read the "household_power_consumption.txt" dataset and assign it to a variable calles dataplot
## The instructions in the README.md file state that any NA values are indicated with a "?"
## these are recongnised using the na.strings="?" function
## Reference Manual https://stat.ethz.ch/R-manual/R-devel/library/utils/html/read.table.html

dataplot <- read.csv ("household_power_consumption.txt", na.strings="?", comment.char="",quote='\"', header = TRUE, sep = ";", stringsAsFactors=FALSE , check.names=FALSE)

## This returns a table of 2075259 observations of 9 vairables

## Using omit.na to remove the NA Values
## Reference Manual Notes https://stat.ethz.ch/R-manual/R-devel/library/stats/html/na.fail.html

dataplotna<-na.omit(dataplot)

## This returns a table of 2049280 observations of 9 vairables with the "?" (NA's) removed/omitted from the data

## The plot will only be using data from the dates 2007-02-01 and 2007-02-02 as per the instructions in the README.md file
## Reference Manual Notes https://stat.ethz.ch/R-manual/R-devel/library/base/html/subset.html

finaldataplot<-subset(dataplotna,Date=="1/2/2007"|Date=="2/2/2007")

## This returns a table of 2880 obervations of 9 variables

## The next step is to convert the date from a character to "Date" format of dd/mm/yyyy
## You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
## Reference Manual Notes https://stat.ethz.ch/R-manual/R-devel/library/base/html/as.Date.html
## Reference Manual Notes http://stat.ethz.ch/R-manual/R-patched/library/base/html/strptime.html
## Reference Manual Notes https://stat.ethz.ch/R-manual/R-devel/library/base/html/as.POSIXlt.html

## Create a variable called "finaldataplotDT" that combines both the "finaldataplot$Date" and "finaldataplot$Time" columns

finaldataplotDT <- paste(as.Date(finaldataplot$Date), finaldataplot$Time)

## Use the as.POSIX* and strptime() functions to format the date and then split into the "finaldataplot$Date" and "finaldataplot$Time" colums

finaldataplot$DateTime <- as.POSIXct(strptime(paste(finaldataplot$Date, finaldataplot$Time),"%d/%m/%Y %H:%M:%S"))

## Format the date field as a date format

finaldataplot$Date<-as.Date(finaldataplot$Date,format="%d/%m/%Y")


######################################
## Second Part: Plot Required Graph ##
######################################

## The second part of this function is not repeatable and will change depending upon the plots required 

## Using the Plot funtion create the Line Graph
## Reference Manual Notes https://stat.ethz.ch/R-manual/R-devel/library/graphics/html/plot.html


## Select the Global_active_power column in the finaldataplot variable

plot(finaldataplot$DateTime,finaldataplot$Global_active_power,
        
     ## Change the type of graph to type "l" for Line Plot
     
     type="l",
     
     ## Label the x axis of the graph blank
     
     xlab="",
     
     ## Label the y axis of the graph "Global Active Power (kilowatts)"
     
     ylab="Global Active Power (kilowatts)")
   

###############################
## Third Part: Save the Plot ##
###############################

## The third part of this function is repeatable through the different graphs required although the name of the
## plot to be saved will need to be changed

## Save the output of the plot/histogram to a file called "plot2.png"
## This file will be saved in to the working directory
## Reference Manual https://stat.ethz.ch/R-manual/R-devel/library/grDevices/html/dev2.html

dev.copy(png,file="plot2.png")

## Terminate the dev function to stop any further writes to the file

dev.off()

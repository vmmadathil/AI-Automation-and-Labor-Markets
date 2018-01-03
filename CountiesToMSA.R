# A simple script to match counties from IPUMS to 2015 OMB MSA classifications
# Author: Visakh Madathil


library(haven)
library(readxl)
library(foreign)
library(dplyr)

#importing initial list of counties from IPUMS 
county_match <- read_dta("C:/Visakh/Research/Hamilton/Data/county_match.dta")

#importing OMB MSA classifications 
MSA_Delination_2015 <- read_excel("C:/Visakh/Research/Hamilton/Data/MSA Delination 2015.xls")

#making variable names uniform
names(MSA_Delination_2015)[names(MSA_Delination_2015) == 'FIPS County Code'] <- 'COUNTYFIPS'
names(MSA_Delination_2015)[names(MSA_Delination_2015) == 'FIPS State Code'] <- 'STATE'


#cleaning up unwanted variables
MSASet <- merge(county_match, MSA_Delination_2015, by=c("COUNTYFIPS", "STATE"))
MSASet$`CBSA Code` <- NULL
MSASet$`Metropolitan Division Code` <- NULL
MSASet$`CSA Code` <- NULL

MSASet <- rename(MSASet, MetArea = `CBSA Title`)

#Writing the data to an .dta file
write.dta(MSASet, "C:/Visakh/Research/Hamilton/Data/MSAtoCounties.dta")

# This script will condense individual IPUMS data to a MSA level
# Author: Visakh Madathil

library(foreign)
library(plyr)

indData <- read_dta("usa_00002_2015.dta")

#multiply data with person weight
indData[, c(4:1530)] <- 
  lapply(indData[, c(4:1530)],
         function(x, y) x * y,
         y = indData$perwt)

indData$i <- 1

#summing all the MSAs
msaData <- ddply(indData, "metid", numcolwise(sum))

write.dta(msaData, "msadata2015.dta")
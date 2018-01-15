# This script will condense individual IPUMS data to a MSA level
# Author: Visakh Madathil

library(haven)
library(foreign)
library(plyr)

indData <- read_dta(FILE_PATH)

#multiply data with person weight
indData[, c(4:1530)] <- 
  lapply(indData[, c(4:1530)],
         function(x, y) x * y,
         y = indData$perwt)


indData <- ddply(indData, "metid", numcolwise(sum))
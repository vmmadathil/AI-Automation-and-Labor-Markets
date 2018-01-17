/*
A .do file to keep track of all regressions ran insofar

Author: Visakh Madathil
*/

//Basic Regression for the 2015 Data set on unemployment
use "C:\Visakh\Research\Hamilton\Data\MSARobots2015.dta", clear
gen byte constant = 1
reghdfe empstat3 Totalindustrialrobots2015, absorb(constant)

//Little data clean up needed for 2010 data set
use "C:\Visakh\Research\Hamilton\Data\MSARobots2010.dta", clear
gen Totalindustrialrobots2010_n = real(Totalindustrialrobots2010)
drop if Totalindustrialrobots2010_n == .
drop Totalindustrialrobots2010
rename Totalindustrialrobots2010_n Totalindustrialrobots2010
order Totalindustrialrobots2010
save "C:\Visakh\Research\Hamilton\Data\MSARobots2010.dta", replace

//Basic Regression for the 2010 Data set on unemployment
gen byte constant = 1
reghdfe empstat3 Totalindustrialrobots2010, absorb(constant)

//Basic Regression for the 2015 Data set on income
use "C:\Visakh\Research\Hamilton\Data\MSARobots2015.dta", clear
gen byte constant = 1
reghdfe inctot Totalindustrialrobots2015, absorb(constant)

//Basic Regression for the 2010 Data set on income
use "C:\Visakh\Research\Hamilton\Data\MSARobots2010.dta", clear
reghdfe inctot Totalindustrialrobots2010, absorb(constant)

/*
This .DO file cleans MSA data and appends Brookings Robotics Data for each MSA 
Author: Visakh Madathil
*/

//importing robot data
import excel "C:\Visakh\Research\Hamilton\Data\RobotsPerMetros.xlsx", sheet("All metros") firstrow
rename Metroarea MetArea
sort MetArea
save "C:\Visakh\Research\Hamilton\Data\RobotsAndMSAs.dta", replace


//import MSA data
use "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta" 
sort metid
save "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta", replace



//merge 2005
use "C:\Visakh\Research\Hamilton\Data\msadata2005.dta"
drop pumasupr
drop appal 
drop appld
//finding the percentages of variables
gen pop = i * i
ds metid, not
foreach x of var `r(varlist)' {
  replace `x' = (`x' / i)
  }
 replace pop = sqrt(pop)
//adding MSA names
sort metid
merge metid using "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta"
sort MetArea
//finding duplicated and elminating them
sort metid
quietly by metid: gen dup = cond(_N==1,0,_n)
drop if dup>0
order Totalindustrialrobots2010
save "C:\Visakh\Research\Hamilton\Data\MSARobots2005.dta", replace





//merge 2010
use "C:\Visakh\Research\Hamilton\Data\msadata2010.dta"
drop pumasupr
drop appal 
drop appld
//finding the percentages of variables after creating population variable
gen pop = i * i
ds metid, not
foreach x of var `r(varlist)' {
  replace `x' = (`x' / i)
  }
replace pop = sqrt(pop)  
//adding MSA names
sort metid
merge metid using "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta"
sort MetArea
drop _merge
merge MetArea using "C:\Visakh\Research\Hamilton\Data\RobotsAndMSAs.dta"
//finding duplicated and elminating them
sort metid
quietly by metid: gen dup = cond(_N==1,0,_n)
drop if dup>0
drop Totalindustrialrobots2015 
drop AnnualizedpercentchangeCAGR 
drop Robotsperthousandworkers201 
drop _merge 
drop dup
drop if Totalindustrialrobots2010 == .
drop if perwt == .
order Totalindustrialrobots2010
save "C:\Visakh\Research\Hamilton\Data\MSARobots2010.dta", replace





//merge 2015
use "C:\Visakh\Research\Hamilton\Data\msadata2015.dta"
drop pumasupr
drop appal 
drop appld
//finding the percentages of variables
gen pop = i * i
ds metid, not
foreach x of var `r(varlist)' {
  replace `x' = (`x' / i)
  }
replace pop = sqrt(pop)
 //adding MSA names
sort metid
drop _merge
merge metid using "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta"
sort MetArea
drop _merge
merge MetArea using "C:\Visakh\Research\Hamilton\Data\RobotsAndMSAs.dta"
//finding duplicated and elminating them
sort metid
quietly by metid: gen dup = cond(_N==1,0,_n)
drop if dup>0
drop Totalindustrialrobots2010
drop AnnualizedpercentchangeCAGR 
drop Robotsperthousandworkers201 
drop _merge 
drop dup
drop if Totalindustrialrobots2015 == .
drop if perwt == .

order Totalindustrialrobots2015
save "C:\Visakh\Research\Hamilton\Data\MSARobots2015.dta", replace

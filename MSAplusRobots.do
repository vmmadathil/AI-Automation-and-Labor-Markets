/*
This .DO file cleans MSA data and appends Brookings Robotics Data for each MSA 
Author: Visakh Madathil
*/

//import MSA data
use "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta" 

sort metid

save "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta", replace

//merge 2005
use "C:\Visakh\Research\Hamilton\Data\msadata2005.dta"
sort metid
merge metid using "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta"
save "C:\Visakh\Research\Hamilton\Data\msadata2005.dta", replace

//merge 2010
use "C:\Visakh\Research\Hamilton\Data\msadata2010.dta"
sort metid
merge metid using "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta"
save "C:\Visakh\Research\Hamilton\Data\msadata2010.dta", replace

//merge 2015
use "C:\Visakh\Research\Hamilton\Data\msadata2015.dta"
sort metid
merge metid using "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta"
save "C:\Visakh\Research\Hamilton\Data\msadata2015.dta", replace

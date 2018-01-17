/*
This .DO file cleans MSA data and appends Brookings Robotics Data for each MSA 
Author: Visakh Madathil
*/

//importing robot data
import excel "C:\Visakh\Research\Hamilton\Data\metro-20180811-muro-robots-appendix1(2).xlsx", sheet("All metros") firstrow
rename Metroarea MetArea
save "C:\Visakh\Research\Hamilton\Data\RobotsAndMSAs.dta"

clear

//import MSA data
use "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta" 
sort metid
save "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta", replace

clear

//merge 2005
use "C:\Visakh\Research\Hamilton\Data\msadata2005.dta"
drop pumasupr appal appld
sort metid
merge metid using "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta"
sort MetArea
save "C:\Visakh\Research\Hamilton\Data\msadata2005.dta", replace

clear

//merge 2010
use "C:\Visakh\Research\Hamilton\Data\msadata2010.dta"
drop pumasupr appal appld
sort metid
merge metid using "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta"
sort MetArea
drop _merge
merge MetArea using "C:\Visakh\Research\Hamilton\Data\RobotsAndMSAs.dta"
save "C:\Visakh\Research\Hamilton\Data\msadata2010.dta", replace

clear

//merge 2015
use "C:\Visakh\Research\Hamilton\Data\msadata2015.dta"
drop pumasupr appal appld
sort metid
merge metid using "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta"
sort MetArea
merge MetArea using "C:\Visakh\Research\Hamilton\Data\RobotsAndMSAs.dta"
save "C:\Visakh\Research\Hamilton\Data\msadata2015.dta", replace

clear





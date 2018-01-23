/*
This script creates a joins MSA and Robot data to countyfip and statefip

Author:Visakh Madathil
*/

import excel "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.xlsx", sheet("Sheet1") firstrow
sort MetroArea
save "C:\Visakh\Research\Hamilton\ReDo\Data\CountyMSA.dta", replace
import excel "C:\Visakh\Research\Hamilton\Data\RobotsPerMetros.xlsx", sheet("All metros") firstrow clear
sort MetroArea

save "C:\Visakh\Research\Hamilton\ReDo\Data\RobotsAndMSAs.dta", replace


use "C:\Visakh\Research\Hamilton\ReDo\Data\CountyMSA.dta"

merge MetroArea using "C:\Visakh\Research\Hamilton\ReDo\Data\RobotsAndMSAs.dta"

save "C:\Visakh\Research\Hamilton\ReDo\Data\MSAPlusRobots.dta"

sort statefips countyfips
drop _merge

save "C:\Visakh\Research\Hamilton\ReDo\Data\MSAPlusRobots.dta", replace

/*
This script creates a joins MSA and Robot data to countyfip and statefip

Author:Visakh Madathil
*/

//import and sorting data
import excel "C:\Path_To\MSAtoCounties.xlsx", sheet("Sheet1") firstrow
sort MetroArea
save "C:\Path_To\CountyMSA.dta", replace
import excel "C:\Path_To\RobotsPerMetros.xlsx", sheet("All metros") firstrow clear
sort MetroArea
save "C:C:\Path_To\RobotsAndMSAs.dta", replace

//merging the files 
use "C:\Path_To\CountyMSA.dta"
merge MetroArea using "C:\Path_To\RobotsAndMSAs.dta"
save "C:\Path_To\MSAPlusRobots.dta"

sort statefips countyfips
drop _merge
save "C:\Path_To\MSAPlusRobots.dta", replace

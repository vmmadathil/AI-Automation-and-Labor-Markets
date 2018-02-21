/*
This script creates a joins MSA and Robot data to countyfip and statefip

Author:Visakh Madathil
*/

clear

local pathVM "C:\Users\madat\Southern Methodist University\Lake, James - Lake_Madathil\HamiltonScholar\Data\Current" 
local pathJLdesktop "F:\oneDrive\OneDrive - Southern Methodist University\Lake_Madathil\HamiltonScholar\Data\Current"
local path "`pathVM'"

//import and sorting data
import excel "`path'\MSAtoCounties.xlsx", sheet("Sheet1") firstrow
sort MetroArea
bys MetroArea: gen n=_n							// this numbers the counties within each MSA as 1,2,3...
tab n											// there are 383 observations with n=1 which means there are 383 distinct metro areas in the data
drop n
save "`path'\CountyMSA.dta", replace
import excel "`path'\RobotsPerMetros_STATA.xlsx", sheet("All metros") firstrow clear
sort MetroArea
bys MetroArea: gen n=_n							// this numbers the counties within each MSA as 1,2,3...
tab n											// there are 382 observations with n=1 which means there are 382 distinct MSAs in the data. 
												// Note, this differs from above by 1 MSA. Based on mmerge below, this is Areciba in Puerto Rico.
drop n
save "`path'\RobotsAndMSAs.dta", replace

//merging the files 
use "`path'\CountyMSA.dta"
mmerge MetroArea using "`path'\RobotsAndMSAs.dta", type(n:1)
save "`path'\MSAPlusRobots.dta", replace
sort statefips countyfips
drop _merge
rename MetroArea met2013 						//Renaming the metro area variable, met2013 for the simplicity
sort met2013
quietly by met2013: gen dup = cond(_N==1,0,_n)
save "`path'\MSAPlusRobots.dta", replace

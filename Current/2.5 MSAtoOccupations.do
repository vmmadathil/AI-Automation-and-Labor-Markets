/*
This script will  sort individual data into industries.

*/

clear

//path variable
local VMPath = "C:\Users\madat\Southern Methodist University\Lake, James - Lake_Madathil\HamiltonScholar\Data\Current"
local pathJLdesktop "F:\oneDrive\OneDrive - Southern Methodist University\Lake_Madathil\HamiltonScholar\Data\Current"
local path "`VMPath'"

//cleaning up using dataset
use "`path'\sic4_2_census90.dta"
destring sic4, replace
destring census90, replace
sort census90
save "`path'\sic4_2_census90.dta", replace

clear

use "`path'\usa_00002_Master.dta"

//cloning occupation variable
clonevar census90 = occ1990
sort census90

//merging census data
mmerge census90 using "`path'\sic4_2_census90.dta"

replace sic4 = 1 if sic4 >= 0 && sic4 <= 0999
replace sic4 = 2 if sic4 >= 1000 && sic4 <= 1499
replace sic4 = 3 if sic4 >= 1500 && sic4 <= 1799
replace sic4 = 5 if sic4 >= 2000 && sic4 <= 3999
replace sic4 = 5 if sic4 >= 4000 && sic4 <= 4999
replace sic4 = 6 if sic4 >= 5000 && sic4 <= 5199
replace sic4 = 7 if sic4 >= 5200 && sic4 <= 5999
replace sic4 = 8 if sic4 >= 6000 && sic4 <= 6799
replace sic4 = 9 if sic4 >= 7000 && sic4 <= 8999
replace sic4 = 10 if sic4 >= 9100 && sic4 <= 9729
replace sic4 = 11 if sic4 >= 9900 && sic4 <= 9999

label define sic4l 1 "Agriculture, Forestry and Fishing" 2 "Mining" 3 "Construction" 4 "Manufacturing" 5 "Transportation, Communications, Electric, Gas and Sanitary service" 6 "Wholesale Trade" 7 "Retail Trade" 8 "Finance, Insurance and Real Estate" 9 "Services" 10 "Public Administration" 11 "Nonclassifiable"

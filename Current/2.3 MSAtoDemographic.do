/*
Breaking changes in MSA into different categories.

Author: Visakh Madathil
*/

clear

//path variables
local VMPath = "C:\Users\madat\Southern Methodist University\Lake, James - Lake_Madathil\HamiltonScholar\Data\Current"
local pathJLdesktop "F:\oneDrive\OneDrive - Southern Methodist University\Lake_Madathil\HamiltonScholar\Data\Current"
local path "`VMPath'"

use "`VMPath'\2015_2010_Differences.dta"

foreach y in 2010 2015{
 
 use "`path'\usa_00002_`y’.dta"

 foreach x of race*
 {
	//collapsing to MSA levels with wanted variables
	preserve
	keep if age >= 25 & age <= 64
	drop if classwkr == 1
	drop if school == 2
	keep if empstat == 1
	collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots`y’ year MetroArea region statefip)
	save "`path'\usa_00002_`y’_`x'_wage.dta", replace

	restore
	preserve

	collapse (sum) x race* educ* citizen*, by (Totalindustrialrobots`y’ year MetroArea region statefip)
	sort Totalindustrialrobots`y’ year MetroArea region statefip
	save "`path'\usa_00002_`y’_demo.dta", replace

	restore 

	keep if age >= 25 & age <= 64
	collapse (sum) empstat*, by (Totalindustrialrobots`y’ year MetroArea region statefip)
	sort Totalindustrialrobots`y’ year MetroArea region statefip
	save "`path'\usa_00002_`y’_lf.dta", replace

	//merging all into one dataset
	use "`path'\usa_00002_`y’_wage.dta"
	sort Totalindustrialrobots`y’ year MetroArea region statefip
	merge Totalindustrialrobots`y’ year MetroArea region statefip using "`path'\usa_00002_`y’_demo.dta"
	drop _merge 

	sort Totalindustrialrobots`y’ year MetroArea region statefip
	merge Totalindustrialrobots`y’ year MetroArea region statefip using "`path'\usa_00002_`y’_lf.dta"
	destring Totalindustrialrobots`y’, replace
	save "`VMPath'\Data\usa_00002_`y’_all.dta", replace
 
 }
}


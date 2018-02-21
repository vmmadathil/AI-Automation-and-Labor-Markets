/*
A script to modify 2015 and 2010 datasets.

Author: Visakh Madathil
*/


clear

//path variable
local VMPath = "C:\Users\madat\Southern Methodist University\Lake, James - Lake_Madathil\HamiltonScholar\Data\Current"
local pathJLdesktop "F:\oneDrive\OneDrive - Southern Methodist University\Lake_Madathil\HamiltonScholar\Data\Current"
local path "`VMPath'"

foreach y in 2010 2015{
 
 use "`path'\usa_00002_`y’.dta"
//creating categorical variables for age
replace age = 1 if age <= 18
replace age = 2 if age >= 19 & age <= 24
replace age = 3 if age >= 25 & age <= 38
replace age = 4 if age >= 39 & age <= 52
replace age = 5 if age >= 53 & age <= 64
replace age = 6 if age >= 65
label define age1 1 "0 - 18" 2 "19 - 24" 3 "25 - 38" 4 "29 - 52" 5 "53 - 64" 6 "65+"
label values age age1
tab (age), gen (age)
gen i_pop = 1
save "`path'\usa_00002_`y’.dta", replace


//collapsing to MSA levels with wanted variables
preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots`y’ year MetroArea region statefip)
save "`path'\usa_00002_`y’_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots`y’ year MetroArea region statefip)
sort Totalindustrialrobots`y’ year MetroArea region statefip
save "`path'\usa_00002_`y’_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
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
destring Totalindustr = robots`y’, replace
save "`VMPath'\usa_00002_`y’_all.dta", replace
}

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_all.dta", replace


use "`VMPath'\usa_00002_2015_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_all.dta"

drop if _merge != 3	
drop _merge

gen DTotalRobots = Totalindustrialrobots2015_2015 - Totalindustrialrobots2010_2010
gen DUhrWage = uhrwage_2015 - uhrwage_2010
gen DIncTot = inctot_2015 - inctot_2010
gen DAge1 = age1_2015 - age1_2010
gen DAge2 = age2_2015 - age2_2010
gen DAge3 = age3_2015 - age3_2010
gen DAge4 = age4_2015 - age4_2010
gen DAge5 = age5_2015 - age5_2010
gen DAge6 = age6_2015 - age6_2010
gen DRace1 = race1_2015 - race1_2010
gen DRace2 = race2_2015 - race2_2010
gen DRace3 = race3_2015 - race3_2010
gen DRace4 = race4_2015 - race4_2010
gen DRace5 = race5_2015 - race5_2010
gen DRace6 = race6_2015 - race6_2010
gen DEducd1 = educd1_2015 - educd1_2010
gen DEducd2 = educd2_2015 - educd2_2010
gen DEducd3 = educd3_2015 - educd3_2010
gen DEducd4 = educd4_2015 - educd4_2010
gen DCitizen1 = citizen1_2015 - citizen1_2010
gen DCitizen2 = citizen2_2015 - citizen2_2010
gen DCitizen3 = citizen3_2015 - citizen3_2010
gen DCitizen4 = citizen4_2015 - citizen4_2010	
gen DEmpstatd1 = empstatd1_2015 - empstatd1_2010
gen DEmpstatd2 = empstatd2_2015 - empstatd2_2010
gen DEmpstatd3 = empstatd3_2015 - empstatd3_2010
gen DEmpstatd4 = empstatd4_2015 - empstatd4_2010
gen DEmpstatd5 = empstatd5_2015 - empstatd5_2010
gen DEmpstatd6 = empstatd6_2015 - empstatd6_2010
gen DEmpstatd7 = empstatd7_2015 - empstatd7_2010
gen DEmpratio = empratio_2015 - empratio_2010

keep MetroArea region statefip DTotalRobots DUhrWage DIncTot DAge1 DAge2 DAge3 DAge4 DAge5 DAge6 DRace1 DRace2 DRace3 DRace4 DRace5 DRace6 DEducd1 DEducd2 DEducd3 DEducd4 DCitizen1 DCitizen2 DCitizen3 DCitizen4 DEmpstatd1 DEmpstatd2 DEmpstatd3 DEmpstatd4 DEmpstatd5 DEmpstatd6 DEmpstatd7 DEmpratio

save "`VMPath'\2015_2010_Differences.dta", replace

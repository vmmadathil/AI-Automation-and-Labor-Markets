/*
A script to create both mater and MSA level datasets.

Author: Visakh Madathil
*/

clear

//path variable
local VMPath = "C:\Users\madat\Southern Methodist University\Lake, James - Lake_Madathil\HamiltonScholar\Data\Current"
local pathJLdesktop "F:\oneDrive\OneDrive - Southern Methodist University\Lake_Madathil\HamiltonScholar\Data\Current"
local path "`VMPath'"

//BEGINNING WITH ALL DATA

//use "`VMPath'\usa_0005_RAW.dta"
use "`path'\usa_0005_RAW.dta"

drop if met2013 == 0 
sort met2013
keep met2013 year region statefip wkswork2 county countyfips puma conspuma gq perwt relate related sex age race hispan citizen yrsusa1 yrsusa2 school educd empstat empstatd labforce occ1990 ind1990 classwkr occsoc indnaics uhrswork inctot ftotinc incwage poverty cpi99 mig*

//changing met2013 from int to string
decode met2013, gen (met2013s)
drop met2013
rename met2013s met2013

mmerge met2013 using "C:\Users\madat\Southern Methodist University\Lake, James - Lake_Madathil\HamiltonScholar\Data\Current\RobotsAndMSAs.dta"
rename met2013 MetroArea //changing the variable name back for the sake of consistency

//Creating categorical variables for education
replace educd = 61 if educd < 62
replace educd = 63 if educd == 62
replace educd = 100 if educd > 63 & educd < 100
replace educd = 101 if educd > 101
label define educd1 61 "Less than HS" 63 "HS graduate or equivalent" 100 "Some College" 101 "Bachelors Degree or Beyond" 
label values educd educd1


//Creating categorical variables for race
replace race = 4 if race == 4 | race == 5 | race == 6
replace race = 5 if race == 7 | race == 8 | race == 9
replace race = 6 if hispan != 0
label define race1 1 "White" 2 "African American/Black" 3 "American Indian" 4 "Asian" 5 "Other" 6 "Hispanic"
label values race race1

//replacing wkswork2 variable
replace wkswork2 = 0 if wkswork2 == 0
replace wkswork2 = 6.5 if wkswork2 == 1
replace wkswork2 = 20 if wkswork2 == 2
replace wkswork2 = 33 if wkswork2 == 3
replace wkswork2 = 43.5 if wkswork2 == 4
replace wkswork2 = 48.5 if wkswork2 == 5
replace wkswork2 = 51 if wkswork2 == 6


save "`path'\usa_00002", replace
preserve


*********************************************************************************************************
drop if year == 2010 | year == 2015
drop Totalindustrialrobots2010
drop Totalindustrialrobots2015
drop AnnualizedpercentchangeCAGR
drop Robotsperthousandworkers201
save "`path'\usa_00002_2005.dta", replace
*********************************************************************************************************
restore 
preserve
drop if year == 2005 | year == 2015
drop Totalindustrialrobots2015
drop AnnualizedpercentchangeCAGR
drop Robotsperthousandworkers201
save "`path'\usa_00002_2010.dta", replace
*********************************************************************************************************
restore
preserve
drop if year == 2005 | year == 2010
drop Totalindustrialrobots2010
drop AnnualizedpercentchangeCAGR
drop Robotsperthousandworkers201
save "`path'\usa_00002_2015.dta", replace
*********************************************************************************************************
restore 
save "`path'\usa_00002_Master.dta", replace
clear
/********************************************************************************************************
*********************************************************************************************************
********************************************************************************************************/

//Creating MSA level datasets

//Starting with 2005
use "`path'\usa_00002_2005.dta"
//creating uhrwage variable
gen uhrwage = (incwage * cpi99)/(uhrswork * wkswork2)
//creating categorical variables
tab(educd), gen (educd)
tab(sex), gen (sex)
tab(race), gen (race)
tab(empstatd), gen (empstatd)
tab (citizen), gen (citizen)
//dropping unwanted variables
drop if perwt == 0
drop if gq == 3 | gq == 4
drop if relate == 13
drop if empstatd == 14 | empstatd == 15
drop if occ1990 == 905
save "`path'\usa_00002_2005.dta", replace

//collapsing to MSA levels
preserve
keep if age >= 25 & age <= 64



drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (cpi99 year MetroArea region statefip)
save "`path'\usa_00002_2005_wage.dta", replace


restore
preserve 

collapse (sum) sex* race* educ* citizen*, by (cpi99 year MetroArea region statefip)
sort cpi99 year MetroArea region statefip
save "`path'\usa_00002_2005_demo.dta", replace

restore 
preserve

keep if age >= 25 & age <= 64
collapse (sum) empstat*, by (cpi99 year MetroArea region statefip)
sort cpi99 year MetroArea region statefip
save "`path'\usa_00002_2005_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2005_wage.dta"
sort cpi99 year MetroArea region statefip
merge cpi99 year MetroArea region statefip using "`path'\usa_00002_2005_demo.dta"
drop _merge 

sort cpi99 year MetroArea region statefip
merge cpi99 year MetroArea region statefip using "`path'\usa_00002_2005_lf.dta"
drop _merge


save "`path'\usa_00002_2005_all.dta", replace

*********************************************************************************************************

//loop for 2010 and 2015
foreach y in 2010 2015{
 
 use "`path'\usa_00002_`y’.dta"
//creating uhrwage variable
gen uhrwage = (incwage * cpi99)/(uhrswork * wkswork2)
//creating categorical variables
tab(educd), gen (educd)
tab(sex), gen (sex)
tab(race), gen (race)
tab(empstatd), gen (empstatd)
tab (citizen), gen (citizen)
//dropping unwanted variables
drop if perwt == 0
drop if gq == 3 | gq == 4
drop if relate == 13
drop if empstatd == 14 | empstatd == 15
drop if occ1990 == 905
save "`path'\usa_00002_`y’.dta", replace

//collapsing to MSA levels with wanted variables
preserve
keep if age >= 25 & age <= 64
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots`y’ year MetroArea region statefip)
save "`path'\usa_00002_`y’_wage.dta", replace

restore
preserve

collapse (sum) sex* race* educ* citizen*, by (Totalindustrialrobots`y’ year MetroArea region statefip)
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


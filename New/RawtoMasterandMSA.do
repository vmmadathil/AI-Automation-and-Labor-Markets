/*
A script to create both mater and MSA level datasets.

Author: Visakh Madathil
*/
//path variable
local VMPath = "C:\Visakh\Research\Hamilton"


//BEGINNING WITH ALL DATA
use "`VMPath'\Data\usa_0005_RAW.dta"

drop if countyfips == 0 
sort statefip countyfips
keep year region statefip wkswork2 county countyfips puma conspuma gq perwt relate related sex age race hispan citizen yrsusa1 yrsusa2 school educd empstat empstatd labforce occ1990 ind1990 classwkr occsoc indnaics uhrswork inctot ftotinc incwage poverty cpi99 mig*

merge statefip countyfips using "C:\Visakh\Research\Hamilton\ReDo\Data\MSAPlusRobots.dta"

//Creating categorical variables for education
replace educd = 61 if educd < 62
replace educd = 63 if educd == 62
replace educd = 100 if educd > 63
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


//changing perwt
replace perwt = (perwt/100)

save "`VMPath'\usa_00002"
preserve
*********************************************************************************************************
drop if year == 2010 | year == 2015
drop Totalindustrialrobots2010
drop Totalindustrialrobots2015
drop AnnualizedpercentchangeCAGR
drop Robotsperthousandworkers201
save "`VMPath'\usa_00002_2005.dta", replace
*********************************************************************************************************
restore 
preserve
drop if year == 2005 | year == 2015
drop Totalindustrialrobots2015
drop AnnualizedpercentchangeCAGR
drop Robotsperthousandworkers201
save "`VMPath'\usa_00002_2010.dta", replace
*********************************************************************************************************
restore
preserve
drop if year == 2005 | year == 2010
drop Totalindustrialrobots2010
drop AnnualizedpercentchangeCAGR
drop Robotsperthousandworkers201
save "`VMPath'\usa_00002_2015.dta", replace
*********************************************************************************************************
restore 
save "`VMPath'\usa_00002_Master.dta", replace
clear


/********************************************************************************************************
*********************************************************************************************************
********************************************************************************************************/

//Creating MSA level datasets

//Starting with 2005
use "`VMPath'\usa_00002_2005.dta"
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
save "`VMPath'\usa_00002_2005.dta", replace

//collapsing to MSA levels
preserve
keep if age >= 25 & age <= 64
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (cpi99 year MetroArea region statefip)
save "`VMPath'\Data\usa_00002_2005_wage.dta", replace


restore
preserve 

collapse (sum) sex* race* educ* citizen*, by (cpi99 year MetroArea region statefip)
sort cpi99 year MetroArea region statefip
save "`VMPath'\Data\usa_00002_2005_demo.dta", replace

restore 
preserve

keep if age >= 25 & age <= 64
collapse (sum) empstat*, by (cpi99 year MetroArea region statefip)
sort cpi99 year MetroArea region statefip
save "`VMPath'\Data\usa_00002_2005_lf.dta", replace

//merging all into one dataset
use "`VMPath'\Data\usa_00002_2005_wage.dta"
sort cpi99 year MetroArea region statefip
merge cpi99 year MetroArea region statefip using "`VMPath'\Data\usa_00002_2005_demo.dta"
drop _merge 

sort cpi99 year MetroArea region statefip
merge cpi99 year MetroArea region statefip using "`VMPath'\Data\usa_00002_2005_lf.dta"
drop _merge


save "`VMPath'\Data\usa_00002_2005_all.dta", replace

*********************************************************************************************************

//Now 2010
use "`VMPath'\usa_00002_2010.dta"
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
save "`VMPath'\usa_00002_2010.dta"

//collapsing to MSA levels with wanted variables
preserve
keep if age >= 25 & age <= 64
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`VMPath'\Data\usa_00002_2010_wage.dta", replace

restore
preserve

collapse (sum) sex* race* educ* citizen*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`VMPath'\Data\usa_00002_2010_demo.dta", replace

restore 

keep if age >= 25 & age <= 64
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`VMPath'\Data\usa_00002_2010_lf.dta", replace

//merging all into one dataset
use "`VMPath'\Data\usa_00002_2010_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`VMPath'\Data\usa_00002_2010_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`VMPath'\Data\usa_00002_2010_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\Data\usa_00002_2010_all.dta", replace


*********************************************************************************************************

//Finally, 2015
use "`VMPath'\usa_00002_2015.dta"
//creating uhrwage variable
gen uhrwage = (incwage * cpi99)/(uhrswork * wkswork2)
//dropping unwanted variables
drop if perwt == 0
drop if gq == 3 | gq == 4
drop if relate == 13
drop if empstatd == 14 | empstatd == 15
drop if occ1990 == 905
//creating categorical variables
tab(educd), gen (educd)
tab(sex), gen (sex)
tab(race), gen (race)
tab(empstatd), gen (empstatd)
tab (citizen), gen (citizen)

//collapsing to MSA levels
preserve
keep if age >= 25 & age <= 64
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`VMPath'\Data\usa_00002_2015_wage.dta", replace

restore
preserve

collapse (sum) sex* race* educ* citizen*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`VMPath'\Data\usa_00002_2015_demo.dta", replace

restore 
preserve

keep if age >= 25 & age <= 64
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`VMPath'\Data\usa_00002_2015_lf.dta", replace

//merging all into one dataset
use "`VMPath'\Data\usa_00002_2015_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`VMPath'\Data\usa_00002_2015_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`VMPath'\Data\usa_00002_2015_lf.dta"
save "`VMPath'\Data\usa_00002_2015_all.dta", replace

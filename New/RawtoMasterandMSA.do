/*
A script to create both mater and MSA level datasets.

Author: Visakh Madathil
*/
//path variable
local VMPath = "C:\Visakh\Research\Hamilton"


//BEGINNING WITH ALL DATA
use "`VMPath'\usa_00002_RAW.dta"

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

//keeping wanted variables
keep year region statefip county countyfips puma conspuma gq perwt relate related sex age race hispan citizen yrsusa1 yrsusa2 school educd empstat empstatd labforce occ1990 ind1990 classwkr occsoc indnaics uhrswork inctot ftotinc incwage poverty mig*

//merge MSA names 
sort statefip countyfips
merge statefip countyfips using "`VMPath'\Data\\MSAtoCounties.dta"
//drop observations not in MSAs
drop if _merge != 3

//add robot data
sort MetArea
drop _merge
merge MetArea using "C:\Visakh\Research\Hamilton\Data\RobotsAndMSAs.dta"
drop if _merge != 3
drop _merge

//add CPI Data
sort year
merge year using "C:\Visakh\Research\Hamilton\Data\CPI.dta"
drop _merge

//creating uhrwage
gen uhrwage = ((incwage * cpi99)/(uhrswork * wkswork1)

save "`VMPath'\usa_00002", replace
preserve

drop if year == 2010 | year == 2015
save "`VMPath'\usa_00002_2005.dta", replace

restore 
preserve
drop if year == 2005 | year == 2015
save "`VMPath'\usa_00002_2010.dta", replace

restore
preserve
drop if year == 2005 | year == 2010
save "`VMPath'\usa_00002_2015.dta"

restore 
save "`VMPath'\usa_00002_Master.dta"
clear

//Creating MSA level datasets
use "`VMPath'\usa_00002_2005.dta"
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
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (year MetArea metid region statefip)

restore
preserve

collapse (sum) sex* race* educ* citizen* by (year MetArea metid region statefip)

restore 
preserve

keep if age >= 25 & age <= 64
collapse (sum) empstat* by (year MetArea metid region statefip)



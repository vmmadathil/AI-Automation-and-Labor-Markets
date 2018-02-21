/*
This splits MSA to more demographic level categories
*/


local VMPath = "C:\Users\madat\Southern Methodist University\Lake, James - Lake_Madathil\HamiltonScholar\Data\Current"
local pathJLdesktop "F:\oneDrive\OneDrive - Southern Methodist University\Lake_Madathil\HamiltonScholar\Data\Current"
local path "`VMPath'"


//importing race
use "`path'\usa_00002_2010.dta"

//dropping the race variable
keep if race1 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_race1_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_race1_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_race1_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_race1_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_race1_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_race1_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_race1_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if race1 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_race1_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_race1_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_race1_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_race1_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_race1_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_race1_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_race1_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_race1_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_race1_all.dta", replace


use "`VMPath'\usa_00002_2015_race1_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_race1_all.dta"

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

save "`VMPath'\2015_2010_race1_Differences.dta", replace


clear


//REPEAT FOR ALL OTHER VARIABLES


use "`path'\usa_00002_2010.dta"

keep if race2 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_race2_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_race2_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_race2_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_race2_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_race2_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_race2_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_race2_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if race2 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_race2_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_race2_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_race2_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_race2_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_race2_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_race2_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_race2_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_race2_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_race2_all.dta", replace


use "`VMPath'\usa_00002_2015_race2_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_race2_all.dta"

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

save "`VMPath'\2015_2010_race2_Differences.dta", replace




use "`path'\usa_00002_2010.dta"

keep if race3 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_race3_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_race3_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_race3_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_race3_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_race3_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_race3_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_race3_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if race3 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_race3_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_race3_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_race3_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_race3_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_race3_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_race3_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_race3_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_race3_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_race3_all.dta", replace


use "`VMPath'\usa_00002_2015_race3_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_race3_all.dta"

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

save "`VMPath'\2015_2010_race3_Differences.dta", replace




use "`path'\usa_00002_2010.dta"

keep if race4 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_race4_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_race4_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_race4_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_race4_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_race4_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_race4_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_race4_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if race4 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_race4_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_race4_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_race4_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_race4_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_race4_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_race4_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_race4_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_race4_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_race4_all.dta", replace


use "`VMPath'\usa_00002_2015_race4_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_race4_all.dta"

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

save "`VMPath'\2015_2010_race4_Differences.dta", replace






use "`path'\usa_00002_2010.dta"

keep if race5 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_race5_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_race5_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_race5_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_race5_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_race5_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_race5_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_race5_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if race5 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_race5_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_race5_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_race5_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_race5_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_race5_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_race5_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_race5_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_race5_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_race5_all.dta", replace


use "`VMPath'\usa_00002_2015_race5_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_race5_all.dta"

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

save "`VMPath'\2015_2010_race5_Differences.dta", replace




use "`path'\usa_00002_2010.dta"

keep if race6 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_race6_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_race6_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_race6_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_race6_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_race6_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_race6_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_race6_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if race6 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_race6_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_race6_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_race6_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_race6_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_race6_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_race6_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_race6_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_race6_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_race6_all.dta", replace


use "`VMPath'\usa_00002_2015_race6_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_race6_all.dta"

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

save "`VMPath'\2015_2010_race6_Differences.dta", replace




use "`path'\usa_00002_2010.dta"

keep if sex1 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_sex1_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_sex1_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_sex1_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_sex1_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_sex1_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_sex1_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_sex1_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if sex1 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_sex1_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_sex1_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_sex1_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_sex1_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_sex1_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_sex1_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_sex1_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_sex1_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_sex1_all.dta", replace


use "`VMPath'\usa_00002_2015_sex1_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_sex1_all.dta"

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

save "`VMPath'\2015_2010_sex1_Differences.dta", replace




use "`path'\usa_00002_2010.dta"

keep if sex2 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_sex2_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_sex2_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_sex2_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_sex2_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_sex2_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_sex2_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_sex2_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if sex2 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_sex2_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_sex2_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_sex2_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_sex2_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_sex2_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_sex2_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_sex2_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_sex2_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_sex2_all.dta", replace


use "`VMPath'\usa_00002_2015_sex2_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_sex2_all.dta"

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

save "`VMPath'\2015_2010_sex2_Differences.dta", replace






use "`path'\usa_00002_2010.dta"

keep if age == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_age1_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_age1_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_age1_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_age1_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_age1_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_age1_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_age1_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if age1 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_age1_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_age1_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_age1_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_age1_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_age1_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_age1_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_age1_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_age1_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_age1_all.dta", replace


use "`VMPath'\usa_00002_2015_age1_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_age1_all.dta"

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

save "`VMPath'\2015_2010_age1_Differences.dta", replace



use "`path'\usa_00002_2010.dta"

keep if age == 2

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_age2_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_age2_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_age2_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_age2_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_age2_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_age2_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_age2_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if age2 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_age2_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_age2_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_age2_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_age2_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_age2_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_age2_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_age2_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_age2_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_age2_all.dta", replace


use "`VMPath'\usa_00002_2015_age2_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_age2_all.dta"

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

save "`VMPath'\2015_2010_age2_Differences.dta", replace






use "`path'\usa_00002_2010.dta"

keep if age == 3

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_age3_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_age3_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_age3_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_age3_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_age3_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_age3_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_age3_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if age3 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_age3_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_age3_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_age3_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_age3_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_age3_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_age3_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_age3_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_age3_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_age3_all.dta", replace


use "`VMPath'\usa_00002_2015_age3_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_age3_all.dta"

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

save "`VMPath'\2015_2010_age3_Differences.dta", replace






use "`path'\usa_00002_2010.dta"

keep if educd1 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_educ1_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_educ1_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_educ1_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_educ1_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_educ1_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_educ1_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_educ1_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if educd1 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_educ1_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_educ1_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_educ1_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_educ1_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_educ1_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_educ1_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_educ1_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_educ1_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_educ1_all.dta", replace


use "`VMPath'\usa_00002_2015_educ1_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_educ1_all.dta"

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

save "`VMPath'\2015_2010_educ1_Differences.dta", replace


clear


use "`path'\usa_00002_2010.dta"

keep if educd2 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_educ2_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_educ2_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_educ2_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_educ2_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_educ2_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_educ2_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_educ2_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if educd2 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_educ2_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_educ2_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_educ2_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_educ2_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_educ2_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_educ2_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_educ2_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_educ2_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_educ2_all.dta", replace


use "`VMPath'\usa_00002_2015_educ2_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_educ2_all.dta"

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

save "`VMPath'\2015_2010_educ2_Differences.dta", replace





use "`path'\usa_00002_2010.dta"

keep if educd3 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_educ3_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_educ3_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_educ3_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_educ3_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_educ3_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_educ3_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_educ3_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if educd3 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_educ3_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_educ3_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_educ3_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_educ3_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_educ3_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_educ3_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_educ3_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_educ3_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_educ3_all.dta", replace


use "`VMPath'\usa_00002_2015_educ3_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_educ3_all.dta"

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

save "`VMPath'\2015_2010_educ3_Differences.dta", replace





use "`path'\usa_00002_2010.dta"

keep if educd4 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
save "`path'\usa_00002_2010_educ4_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_educ4_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2010 year MetroArea region statefip)
sort Totalindustrialrobots2010 year MetroArea region statefip
save "`path'\usa_00002_2010_educ4_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2010_educ4_wage.dta"
sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_educ4_demo.dta"
drop _merge 

sort Totalindustrialrobots2010 year MetroArea region statefip
merge Totalindustrialrobots2010 year MetroArea region statefip using "`path'\usa_00002_2010_educ4_lf.dta"
destring Totalindustrialrobots2010, replace
save "`VMPath'\usa_00002_2010_educ4_all.dta", replace

clear 

use "`path'\usa_00002_2015.dta"

keep if educd4 == 1

preserve
keep if age == 1 | age == 2 | age == 3
drop if classwkr == 1
drop if school == 2
keep if empstat == 1
collapse (mean) uhrwage incwage inctot ftotinc [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
save "`path'\usa_00002_2015_educ4_wage.dta", replace

restore
preserve

collapse (sum) i_pop age* sex* race* educ* citizen* [w = perwt], by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_educ4_demo.dta", replace

restore 

keep if age == 1 | age == 2 | age == 3
collapse (sum) empstat*, by (Totalindustrialrobots2015 year MetroArea region statefip)
sort Totalindustrialrobots2015 year MetroArea region statefip
save "`path'\usa_00002_2015_educ4_lf.dta", replace

//merging all into one dataset
use "`path'\usa_00002_2015_educ4_wage.dta"
sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_educ4_demo.dta"
drop _merge 

sort Totalindustrialrobots2015 year MetroArea region statefip
merge Totalindustrialrobots2015 year MetroArea region statefip using "`path'\usa_00002_2015_educ4_lf.dta"
destring Totalindustrialrobots2015, replace
save "`VMPath'\usa_00002_2015_educ4_all.dta", replace

clear

//creating a data set that has the changes for all the variables
use "`VMPath'\usa_00002_2010_educ4_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2010 
} 
rename MetroArea_2010 MetroArea
rename region_2010 region
rename statefip_2010 statefip

sort MetroArea region statefip
save "`VMPath'\usa_00002_2010_educ4_all.dta", replace


use "`VMPath'\usa_00002_2015_educ4_all.dta"
gen empratio = empstatd2/(age3 + age4 + age5)
 foreach x of var * { 
	rename `x' `x'_2015
} 
rename MetroArea_2015 MetroArea
rename region_2015 region
rename statefip_2015 statefip

sort MetroArea region statefip
mmerge MetroArea region statefip using "`VMPath'\usa_00002_2010_educ4_all.dta"

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

save "`VMPath'\2015_2010_educ4_Differences.dta", replace

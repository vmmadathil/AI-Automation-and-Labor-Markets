/*
A script to create both mater and MSA level datasets.

Author: Visakh Madathil
*/
//path variable
local VMPath = "C:\Visakh\Research\Hamilton"


//BEGINNING WITH ALL DATA
use "`VMPath'\usa_00002"

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


keep year region statefip county countyfips puma conspuma gq perwt relate related sex age race hispan citizen yrsusa1 yrsusa2 school educd empstat empstatd labforce occ1990 ind1990 classwkr occsoc indnaics uhrswork inctot ftotinc incwage poverty mig*

save "`VMPath'\usa_00002", replace
preserve




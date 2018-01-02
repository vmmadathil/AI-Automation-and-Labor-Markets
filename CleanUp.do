/*
This .DO file will format IPUMS population data into Metropolitan Statisical 
Areas (MSAs) as per the 2015 OMB definitions. Brookings Robotics Data for each
MSA is then appended.

Author - Visakh Madathil
*/

use "C:\Visakh\Research\Hamilton\usa_00002_Total_Set_Cleaned_Counties.dta" 
replace educd = 61 if educd < 62
replace educd = 63 if educd == 62
replace educd = 100 if educd < 101 & educd > 63
replace educd = 102 if educd > 101
label define educd1 61 "Less than HS" 63 "HS graduate or equivalent" 100 "Some College" 101 "Bachelors Degree" 102 "Graduate or Professional Degree"
label values educd educd1
tab(educd), gen (educd)
tab empstat, gen(empstat)
tab occ, gen (occ)
tab ind, gen (ind)
tab sex, gen (sex)
tab race, gen (race)
replace perwt = perwt/100
tab raced, gen (raced)
drop hispan
drop hispand
tab bpl, gen (bpl)
tab bpld, gen (bpld)
tab school, gen (school)
tab gradeatt, gen (gradeatt)
tab gradeattd, gen (gradeattd)
tab empstatd, gen (empstatd)
tab labforce, gen (labforce)
tab classwkr, gen (classwkr)
tab classwkrd, gen (classwkrd)
tab wkswork2, gen (wkswork2)
tab uhrswork, gen (uhrswork)
tab migrate1d, gen (migrate1d)
tab migplac1, gen (migplac1)

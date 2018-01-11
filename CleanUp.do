/*
This .DO file will format IPUMS population data into Metropolitan Statisical 
Areas (MSAs) as per the 2015 OMB definitions. Brookings Robotics Data for each
MSA is then appended.

Author - Visakh Madathil
*/

use "C:\Visakh\Research\Hamilton\usa_00002_Total_Set_Cleaned_Counties.dta" 

//Must drop counties that do not contain a value, or else correspondence will not work
drop if county == 0

//Creating categorical variables and labels for education
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
tab raced, gen (raced)
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

replace perwt = perwt/100

save "C:\Visakh\Research\Hamilton\usa_00002_Total_Set_Cleaned_Counties.dta", replace

use "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta" 

rename statefip StateName
rename STATE statefip
rename COUNTYFIPS countyfips

egen metid = group(MetArea)

destring statefip, replace
sort countyfips statefip

save "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta", replace

//The merging of the datasets
use "C:\Visakh\Research\Hamilton\usa_00002_Total_Set_Cleaned_Counties.dta" 
sort countyfips statefip
merge countyfips statefip using "C:\Visakh\Research\Hamilton\Data\MSAtoCounties.dta" 
//saving master individual data set
save "C:\Visakh\Research\Hamilton\usa_00002_Total_Set_Cleaned_Counties.dta", replace
	

//Dropping unneeded variables to free up memory
drop met2013
drop met2013err
drop city
drop cityer
drop region
drop stateicp
drop metro
drop metarea
drop metaread
drop citypop
drop puma
drop homeland
drop cntry
drop hispan
drop hispand
drop datanum
drop dataserial
drop serial
drop hhwt
drop county
drop countyfips
drop conspuma
drop cpuma0010
drop gq
drop pernum
drop cbpernum
drop slwt
drop repwtp
drop relate
drop related
drop migrateld
drop migplac1
drop migrate1
drop npboss50
drop bpl
drop bpld
drop race
drop raced
drop citizen
drop yrsusa1
drop yrsusa2
drop school
drop educ
drop educd
drop gradeatt
drop gradeattd
drop schltype
drop empstat
drop empstatd
drop labforce
drop occ
drop occ1950
drop occ1990
drop occ2010
drop ind
drop ind1950
drop ind1990
drop ind2010
drop classwkr
drop classwkrd
drop occsoc
drop indnaics
drop wkswork2
drop uhrswork
drop wrklstwk
drop abset
drop looking
drop availble
drop wrkrecal
drop workedyr
drop occscore
drop sei
drop hwsei
drop presgl
drop prent
drop erscor50
drop erscor90
drop edscor50
drop edscor90
drop npboss50
drop migrate1
drop migrate1d
drop migplac1
drop migpuma1
drop movedin
drop repwtp1
drop repwtp2
drop repwtp3
drop repwtp4
drop repwtp5
drop repwtp6
drop repwtp7
drop repwtp8
drop repwtp9
drop repwtp10
drop repwtp11
drop repwtp12
drop repwtp13
drop repwtp14
drop repwtp15
drop repwtp16
drop repwtp17
drop repwtp18
drop repwtp19
drop repwtp20
drop repwtp21
drop repwtp22
drop repwtp23
drop repwtp24
drop repwtp25
drop repwtp26
drop repwtp27
drop repwtp28
drop repwtp29
drop repwtp30
drop repwtp31
drop repwtp32
drop repwtp33
drop repwtp34
drop repwtp35
drop repwtp36
drop repwtp37
drop repwtp38
drop repwtp39
drop repwtp40
drop repwtp41
drop repwtp42
drop repwtp43
drop repwtp44
drop repwtp45
drop repwtp46
drop repwtp47
drop repwtp48
drop repwtp49
drop repwtp50
drop repwtp51
drop repwtp52
drop repwtp53
drop repwtp54
drop repwtp55
drop repwtp56
drop repwtp57
drop repwtp58
drop repwtp59
drop repwtp60
drop repwtp61
drop repwtp62
drop repwtp63
drop repwtp64
drop repwtp65
drop repwtp66
drop repwtp67
drop repwtp68
drop repwtp69
drop repwtp70
drop repwtp71
drop repwtp72
drop repwtp73
drop repwtp74
drop repwtp75
drop repwtp76
drop repwtp77
drop repwtp78
drop repwtp79
drop repwtp80

//mutliplying variables with the person weight
foreach x of varlist _all {
	replace `x' = (`x' * perwt)
}


/*
A .do file to keep track of all regressions ran insofar

Author: Visakh Madathil
*/


clear 

//path variables
local VMPath "C:\Users\madat\Southern Methodist University\Lake, James - Lake_Madathil\HamiltonScholar\Data\Current"     // JL: you don't need "=" between macro name and macro text
local pathJLdesktop "F:\oneDrive\OneDrive - Southern Methodist University\Lake_Madathil\HamiltonScholar\Data\Current"
local path "`VMPath'"

cap log cl											  // JL: cap is a command that tells STATA not to stiop the script if the following command returns an error. 
													  // If the do-file crashed and we're now re-running it, this line of code will close the currently open log file because
													  // we can't use the command "log using ..." if there's an already open log file.
log using "`path'\results.log", replace               // JL: save as .log rather than .txt and always use the "replace" option because otherwise the do-file will crash if there's a 
													  // pre-existing file with the same file name

use "`path'\2015_2010_Differences.dta"				  // JL: all paths should just refer to `path' so we only have to change the path in line 13 and it flow thorughout

// run regressions
gen constant = 1
loc m=1												  // JL: this macro "m" will be a counter for recording the regression results of various models
reghdfe DUhrWage DTotalRobots , absorb(constant)	  // JL: the syntax for all regression commands in STATA is of the form commandName y x ... but you'd written commandName x y ...
eststo m`m'											  // JL: store regression results
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  // JL: I'm changing the naming convention of the stored results to distinguish between different types of models that we're running
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close


log using "`path'\race1.log", replace               
													  
clear
													  
use "`path'\2015_2010_race1_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close



log using "`path'\race2.log", replace               
													  
clear
													  
use "`path'\2015_2010_race2_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close



log using "`path'\race3.log", replace               
													  
clear
													  
use "`path'\2015_2010_race3_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close



log using "`path'\race4.log", replace               
													  
clear
													  
use "`path'\2015_2010_race4_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close




log using "`path'\race5.log", replace               
													  
clear
													  
use "`path'\2015_2010_race5_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close




log using "`path'\race6.log", replace               
													  
clear
													  
use "`path'\2015_2010_race6_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close




log using "`path'\sex1.log", replace               
													  
clear
													  
use "`path'\2015_2010_sex1_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close



log using "`path'\sex2.log", replace               
													  
clear
													  
use "`path'\2015_2010_sex2_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close



log using "`path'\age1.log", replace               
													  
clear
													  
use "`path'\2015_2010_age1_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close



log using "`path'\age2.log", replace               
													  
clear
													  
use "`path'\2015_2010_age2_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close



log using "`path'\age3.log", replace               
													  
clear
													  
use "`path'\2015_2010_age3_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close



log using "`path'\educ1.log", replace               
													  
clear
													  
use "`path'\2015_2010_educ1_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close



log using "`path'\educ2.log", replace               
													  
clear
													  
use "`path'\2015_2010_educ2_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close




log using "`path'\educ3.log", replace               
													  
clear
													  
use "`path'\2015_2010_educ3_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close





log using "`path'\educ4.log", replace               
													  
clear
													  
use "`path'\2015_2010_educ4_Differences.dta"				  

// run regressions
gen constant = 1
loc m=1												  
reghdfe DUhrWage DTotalRobots , absorb(constant)	  
eststo m`m'											  
loc m=`m'+1
reghdfe DIncTot DTotalRobots, absorb(constant)
eststo m`m'
loc m=`m'+1
reghdfe DEmpratio DTotalRobots, absorb(constant)
eststo m`m'

loc m=1
reghdfe DUhrWage DTotalRobots, absorb(region)
eststo n`m'											  
reghdfe DIncTot DTotalRobots, absorb(region)
reghdfe DEmpratio DTotalRobots, absorb(region)


// put regression results into a table format
#delimit ;
noi estout m1 m2 m3 n1, keep(DTotalRobots) cells(b(star fmt(3)) se(par fmt(3))) 
stats(N, fmt(%9.0g 3 3 3)) style(fixed) starlevels(# 0.10 ^ 0.05 * 0.01) 
legend title("Table title") ;
#delimit cr	

log close

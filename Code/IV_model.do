clear

use  "Data\Derived\HAQ.dta"

*Merge data 

merge 1:1 Code using "Data\Derived\r&d.dta", keep(match) nogenerate
merge 1:1 Code using "Data\Derived\BMI.dta", keep(match) nogenerate
merge 1:1 Code using "Data\Derived\obesity.dta", keep(match) nogenerate
merge 1:1 Code using "Data\Derived\m_age.dta", keep(match) nogenerate
replace Code = subinstr(Code," Average","",.)
merge 1:1 Code using "Data\Derived\research_papers.dta", keep(match) nogenerate
merge 1:1 Code using "Data\Derived\diabetes.dta", keep(match) nogenerate
merge 1:1 Code using "Data\Derived\GDPPC.dta", keep(match) nogenerate
merge 1:1 Code using "Data\Derived\mortality.dta", keep(match) nogenerate


*Regression
gen lGDPPC=log(GDPPC)
gen lrd=log(rd)
gen lmortality=log(mortality)
gen lpapers=log(yr_papers)


*Descriptive Statistics
*ssc install asdoc in case it is not installed
asdoc summarize mortality lrd lpapers lGDPPC m_age HAQ BMI diabetes, replace save(Results\descriptive_statistics.doc) title(Descriptive statistics)


*first stage
reg lrd lpapers lGDPPC m_age HAQ BMI diabetes
outreg2 using "Results\first_stage.xls", replace
*second stage
ivregress 2sls lmortality lGDPPC m_age HAQ BMI diabetes (lrd = lpapers), robust
outreg2 using "Results\second_stage.xls", replace

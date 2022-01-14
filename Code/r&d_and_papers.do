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
gen lpapers=log(yr_papers)
gen lmortality=log(mortality)

reg lmortality lrd lpapers, robust
outreg2 using "Results\r&d_and_papers.xls", replace
reg lmortality lrd lpapers lGDPPC, robust
outreg2 using "Results\r&d_and_papers.xls", 
reg lmortality lrd lpapers lGDPPC m_age, robust
outreg2 using "Results\r&d_and_papers.xls"
reg lmortality lrd lpapers lGDPPC m_age HAQ , robust
outreg2 using "Results\r&d_and_papers.xls"
reg lmortality lrd lpapers lGDPPC m_age HAQ BMI, robust
outreg2 using "Results\r&d_and_papers.xls"
reg lmortality lrd lpapers lGDPPC m_age HAQ BMI diabetes, robust
outreg2 using "Results\r&d_and_papers.xls"
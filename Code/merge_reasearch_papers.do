clear

use  "Data\Derived\HAQ.dta"

*Merge data

merge 1:1 Code using "Data\Derived\BMI.dta", keep(match) nogenerate
merge 1:1 Code using "Data\Derived\obesity.dta", keep(match) nogenerate
merge 1:1 Code using "Data\Derived\m_age.dta", keep(match) nogenerate
replace Code = subinstr(Code," Average","",.)
merge 1:1 Code using "Data\Derived\research_papers.dta", keep(match) nogenerate
merge 1:1 Code using "Data\Derived\diabetes.dta", keep(match) nogenerate
merge 1:1 Code using "Data\Derived\GDPPC.dta", keep(match) nogenerate
merge 1:1 Code using "Data\Derived\mortality.dta", keep(match) nogenerate

*generate logs of variables
generate lGDPPC=log(GDPPC)
generate lpapers=log(yr_papers)
generate lmortality=log(mortality)

*run regressions
regress lmortality lpapers lGDPPC, robust
outreg2 using "Results\papers.xls", replace
regress lmortality lpapers lGDPPC m_age, robust
outreg2 using "Results\papers.xls"
regress lmortality lpapers lGDPPC m_age HAQ , robust
outreg2 using "Results\papers.xls"
regress lmortality lpapers lGDPPC m_age HAQ BMI, robust
outreg2 using "Results\papers.xls"
regress lmortality lpapers lGDPPC m_age HAQ BMI diabetes, robust
outreg2 using "Results\r&d.xls"
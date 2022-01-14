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


*generate logs of variables
generate lGDPPC=log(GDPPC)
generate lrd=log(rd)
generate lmortality=log(mortality)
generate lpapers=log(yr_papers)


*Descriptive Statistics
*ssc install asdoc in case it is not installed
asdoc summarize mortality lrd lpapers lGDPPC m_age HAQ BMI diabetes, replace save(Results\descriptive_statistics.doc) title(Descriptive statistics)

save "Data\Derived\IV_data.dta", replace
clear

use  "Data\Derived\IV_data.dta"


*regressions

*first stage
regress lrd lpapers lGDPPC m_age HAQ BMI diabetes
outreg2 using "Results\first_stage.xls", replace
*second stage
ivregress 2sls lmortality lGDPPC m_age HAQ BMI diabetes (lrd = lpapers), robust
outreg2 using "Results\second_stage.xls", replace

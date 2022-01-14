
clear

* clean data
do code/clean_data.do

* descriptive statistics
do code/descriptive_statistics.do

* regress on r&d
do code/regress_mortality_on_r&d.do

* regress on papers
do code/regress_mortality_on_papers.do

* regress on both 
do code/regress_mortality_on_r&d_and_papers.do

* IV model
do code/IV_model.do
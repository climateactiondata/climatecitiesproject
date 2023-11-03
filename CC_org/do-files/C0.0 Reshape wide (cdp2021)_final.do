********************************************************************************
* Title			:	Cities Climate Action
* Purpose		: 	Reshaping CDP 2021 data into wide format
* Author		: 	Richmond Silvanus Baye & Tanya O'Garra
********************************************************************************

****NOTE - the code reported here entails some "saves" - please make sure you enter the correct path for your files if you are not using desktop

*FIRST STEPS	
set more off 
set maxvar 32000

*set directory (ADJUST AS NEEDED)
cd "C:\Users\Administrator\Desktop\CC_org" // ADJUST PATH NAME AS NEEDED

*local macro for path names
local climcit "C:\Users\Administrator\Desktop\CC_org" //ADJUST PATH NAME AS NEEDED

*** OPEN CDP 2021 DATASET (downloaded from https://data.cdp.net/) - note: THIS IS  VERY large file, so you can start from step 2 file below
use "`climcit'\inputs\cdp_2021 (Jan11).dta"

keep accountnumber organization questionnumber columnnumber rownumber responseanswer

**SAVE as new dataset 
save "`climcit'/cdp_2021 step2.dta",replace



*** CONCATENATE RESPONSES FROM SELECT MULTIPLE QUESTIONS
* NB: These fields will be split into dummy variables later on

* keep a dataset of responses with multiple answers
* identify select multiple fields by flagging duplicates in dataset
duplicates tag accountnumber questionnumber columnnumber rownumber, gen (dup)
	
* mark all select multiple fields
levelsof questionnumber if dup, loc(qns) clean
	
gen sm_question = 0
foreach qn in `qns' {
	replace sm_question = 1 if questionnumber == "`qn'"
}
	
* keep select multiple fields only
keep if sm_question == 1
drop dup sm_question
	
* Reshape data into wide format 
bysort accountnumber questionnumber columnnumber rownumber: gen index = _n 
reshape wide responseanswer, i(accountnumber questionnumber columnnumber rownumber) j(index)

* combine answers for each. Seperate individual responses by "|"
egen answerjoined = concat(responseanswer*), punct("|")
keep accountnumber questionnumber columnnumber rownumber answerjoined
rename answerjoined responseanswer

**SAVE as new dataset
save "`climcit'/cdp_2021 step3.dta", replace
clear



*** MERGE select multiple fields back into the main dataset
use "`climcit'/cdp_2021 step2.dta" 
	
* Drop duplicates in select multiple field so each field now contains a single row
* The concated values will be merged in to replace multiple rows
duplicates drop accountnumber questionnumber columnnumber rownumber, force
	
* Merge concatenated values back into main dataset to dropped values
merge 1:1 accountnumber questionnumber columnnumber rownumber using "`climcit'/cdp_2021 step3.dta", update replace nogen

**SAVE as new dataset
save "`climcit'/cdp_2021 step4.dta", replace 



*PREP DATA TO RESHAPE TO WIDE FORMAT AT CITY LEVEL

*use "`climcit'/cdp_2021 step4.dta" 
	
* Drop duplicates in select multiple field so each field now contains a single row
* The concated values will be merged in to replace multiple rows
duplicates drop accountnumber questionnumber columnnumber rownumber, force
	
* Merge concatenated values back into main dataset to dropped values
merge 1:1 accountnumber questionnumber columnnumber rownumber using "`climcit'/cdp_2021 step3.dta", update replace nogen


* generate a new variable field by combining the old qn, col and rows. This will be used 
* as the jvar when reshaping the dataset to the city level
gen varname = "q_"+ questionnumber + "_" + string(columnnumber) + "_" + string(rownumber)
	
* change varname to name format
replace varname = strtoname(varname)

*KEEP only those variables used for current paper (see CDP 2021 questionnaire to match question number to question)
keep if strpos( varname , "q_0_1")>0 | strpos(varname, "q_1_0")>0 | strpos(varname, "q_1_6")>0  | strpos(varname, "q_1_7")>0 | strpos(varname, "q_2_1")>0 | strpos(varname, "q_2_3")>0 | strpos(varname, "q_2_3a")>0 | strpos(varname, "q_5_0a")>0 | strpos(varname, "q_5_0b")>0  | strpos(varname, "q_5_0c")>0  | strpos(varname, "q_5_0d")>0  | strpos(varname, "q_6_0")>0  | strpos(varname, "q_6_2")>0
drop if strpos( varname , "q_6_2a")>0 
*not used in final analysis
drop if strpos(varname, "q_1_0")>0
drop if strpos(varname , "q_6_2a")>0 

**SAVE as new dataset
save "`climcit'/cdp_2021 step5.dta", replace 
clear



*** RESHAPE	

use "`climcit'/cdp_2021 step5.dta"
* rename responseanswer to q which will be the prefix for all 
rename responseanswer q      			
keep q accountnumber varname

* reshape data to WIDE format using accountname as ivar and varname as jvar	
reshape wide q, i(accountnumber) j(varname) string	
rename qq_* q_*

**SAVE as new dataset
save "`climcit'/cdp_2021 widev0.dta", replace
clear



*** ADD CITY INFORMATION	
use "`climcit'\inputs\cdp_2021 (Jan11).dta"

keep accountnumber organization country cdpregion
duplicates drop accountnumber, force
	
**SAVE as new dataset
save "`climcit'/cdp_2021_citydetails",replace
clear	
	
	
* Merge with main data
use "`climcit'/cdp_2021 widev0.dta"  
merge 1:1 accountnumber using "`climcit'/cdp_2021_citydetails", nogen 	
	
order accountnumber organization country cdpregion, first
	
save "`climcit'/cdp_2021_wide", replace
clear
	
	
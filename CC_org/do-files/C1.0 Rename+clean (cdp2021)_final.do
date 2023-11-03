*********************************************************************
*Title		: Clean CDP 2021
*Purpose	: Organises & Renames CDP 2021 Data
*Author		: Tanya O'Garra
*********************************************************************

clear

*set directory (ADJUST AS NEEDED)
cd "C:\Users\Administrator\Desktop\CC_org" // ADJUST PATH NAME AS NEEDED

*local macro for path names
local climcit "C:\Users\Administrator\Desktop\CC_org" //ADJUST PATH NAME AS NEEDED

use "`climcit'/cdp_2021_wide"

************************************
*FIRST STEPS									
************************************

*Remove "Question not applicable" answers from entire dataset
foreach var of varlist q_0_1_1_1- q_6_2_0_0{
replace 	`var' 	=	 subinstr(`var',"Question not applicable","",.)
}
	
************************************
*SECTION 0.0 Introduction variables 
************************************

*0.1 Details of city
gen   		i_city_bound 	=	q_0_1_1_1
label var 	i_city_bound 	"Administrative boundary of city"
gen    		i_gen_des   	=	q_0_1_2_1 	
label var  i_gen_des 		"General description of city (TEXT)"



**********************
*SECTION 1. GOVERNANCE
**********************


*QUESTIONS ON COVID-19
*1.6 Please provide info on the overall impact of COVID on climate action in your city
gen  	covimpct_act 			=	q_1_6_1_1   
gen  	covimpct_act_dtail		=	q_1_6_2_1 	
label var   covimpct_act   		"Impact of COVID on climate action in your city"
label var   covimpct_act_dtail 	"Details of impact of COVID on climate action in your city"


*1.7 Please provide info on the impact of the covid economic response on climate action in your city and synergies between covid recovery interventions and climate action
replace 	q_1_7_1_1   			= subinstr(q_1_7_1_1, "|", "",.)
replace 	q_1_7_2_1   			= subinstr(q_1_7_2_1, "|||||||||||||||||||||||", "",.)
gen  	 	covimpct_econ			=	q_1_7_1_1  	
gen  	 	cov_recov				=	q_1_7_2_1  	
gen  		cov_recov_dtail			=	q_1_7_3_1 	


*Convert 1.7 column 2 to upper cases for regular expression
replace cov_recov = upper(cov_recov)

*Split variables and drop those with all missing
split cov_recov, p(|)    			
order cov_recov1- cov_recov11, after(cov_recov)
*Remove variables with empty cells
*drop cov_recov13-cov_recov23


********************************
*SECTION 2. HAZARDS/RISKS
********************************

*2.1 List the most significant climate hazard faced by your city and the prob of the consequence of these hazards, frequency and intensity
*Remove pipe from responses 
foreach j of varl q_2_1_*_*{
	replace `j' = subinstr(`j',"|","",.)
}

* loop through hazard variables and clean
forval j = 1/30 {
	gen cc_sig_hazd_`j'_type 		= 	q_2_1_1_`j'        					    
	gen cc_sig_hazd_`j'_prior 		= 	q_2_1_2_`j'         					
	gen cc_sig_hazd_`j'_prob  		= 	q_2_1_3_`j'         					
	gen cc_sig_hazd_`j'_magn 		= 	q_2_1_4_`j' 
	
	label var cc_sig_hazd_`j'_type    	 "Type of climate hazard `j'"
	label var cc_sig_hazd_`j'_prior  	 "Impact of climate hazard prior to this year `j'"
	label var cc_sig_hazd_`j'_prob   	 "Probability of climate hazard `j'"
	label var cc_sig_hazd_`j'_magn    	 "Magnitude of climate hazard `j'"
}


*2.3 Is your city facing risk to public health or health systemss associated with cc?
gen  	 	ccimpct_hlth 	= q_2_3_0_0 		
label var 	ccimpct_hlth   "Is your city facing risk to public health or health systems"


*2.3a If yes, please report on how cc impacts health outcomes and health services in your city
forval j = 1/20 {
forval i = 1/20 {
    replace q_2_3a_`i'_`j' = subinstr(q_2_3a_`i'_`j',"||||||||||||||||||||||","",.)
	}
	}
	
forval j = 1/20 {
	gen  	  ccimpct_hlth_`j'_issue    =	q_2_3a_4_`j' 
	label var 	ccimpct_hlth_`j'_issue	 "Health issues"
	}


 
********************************
*SECTION 5. EMISSIONS REDUCTION
********************************

***MITIGATION TARGET SETTING***
	
*5.0a BASE YEAR EMISSIONS TARGET - please provide your sector specific targets (Note - added column q_5_0a_4_`j' added in 2021)
**Completed if BASE YEAR emissons target is selected in response to q5.0

*****Selective removal of pipes
**Rename variables which have pipes that you want to retain (in this case, listings of initiatives that cities are part of)
forval j = 1/20 {
rename q_5_0a_14_`j' qfixed_5_0a_14_`j'
}
*remove pipes from all other variables responses
foreach j of varl q_5_0a_*_*{
		replace `j' = subinstr(`j',"|","",.)
}
*then remove excess pipes from the variables you wanted to retain individual (divider) pipes in
forval j = 1/20 {
replace qfixed_5_0a_14_`j' = subinstr(qfixed_5_0a_14_`j',"|||||||||||||||||||||||||||||||||||","",.)
replace qfixed_5_0a_14_`j' = subinstr(qfixed_5_0a_14_`j',"|||||||||||||||||||||||||||||||||","",.)
replace qfixed_5_0a_14_`j' = subinstr(qfixed_5_0a_14_`j',"||||||||||||||||||||||||||||||||","",.)
}

*Generate new renamed variables
forval j = 1/20 {
	gen   	ghg_tgt_abs`j'_sect 		= q_5_0a_1_`j' 					 	
	gen   	ghg_tgt_abs`j'_bound 		= q_5_0a_3_`j' 	 	
	gen    	ghg_tgt_abs`j'_tgtyr 		= q_5_0a_9_`j'		

}

*Labels not produced for these variables	


*5.0b FIXED LEVEL TARGET - please provide details of your total fixed level target/*Note - added column q_5_0b_4_`j' added in 2021*/
**Completed if FIXED LEVEL TARGET is selected in response to q5.0:

*****Selective removal of pipes
**Rename variables which have pipes that you want to retain (in this case, listings of initiatives that cities are part of)
forval j = 1/20 {
rename q_5_0b_13_`j' qfixed_5_0b_13_`j'
}

*remove pipes from all other variables responses
foreach j of varl q_5_0b_*_*{
		replace `j' = subinstr(`j',"|","",.)
}

*then remove excess pipes from the variables you wanted to retain individual (divider) pipes in
forval j = 1/20 {
replace qfixed_5_0b_13_`j' = subinstr(qfixed_5_0b_13_`j',"|||||||||||||||||||||||||||||||||||","",.)
replace qfixed_5_0b_13_`j' = subinstr(qfixed_5_0b_13_`j',"|||||||||||||||||||||||||||||||||","",.)
replace qfixed_5_0b_13_`j' = subinstr(qfixed_5_0b_13_`j',"||||||||||||||||||||||||||||||||","",.)
}

*Generate new renamed variables
forval j = 1/20 {
	gen   	 ghg_tgt_fxd`j'_sect	 	= q_5_0b_1_`j'  	
	gen  	 ghg_tgt_fxd`j'_bound 		= q_5_0b_3_`j'
	gen  	 ghg_tgt_fxd`j'_tgtyr 		= q_5_0b_7_`j' 
}

*Labels not produced for these variables	



*5.0c BASE YEAR INTENSITY TARGET - please provide details of your total city-wide base year intensity target /*Note - two columns (subquestions) added in 2021 - not coded here*/
**Completed if BASE YEAR INTENSITY TARGET is selected in response to q5.0

*****Selective removal of pipes
**Rename variables which have pipes that you want to retain (in this case, listings of initiatives that cities are part of)
forval j = 1/20 {
rename q_5_0c_16_`j' qfixed_5_0c_16_`j'
}

*remove pipes from all other variables responses
foreach j of varl q_5_0c_*_*{
		replace `j' = subinstr(`j',"|","",.)
}

*then remove excess pipes from the variables you wanted to retain individual (divider) pipes in
forval j = 1/20 {
replace qfixed_5_0c_16_`j' = subinstr(qfixed_5_0c_16_`j',"|||||||||||||||||||||||||||||||||||","",.)
replace qfixed_5_0c_16_`j' = subinstr(qfixed_5_0c_16_`j',"|||||||||||||||||||||||||||||||||","",.)
replace qfixed_5_0c_16_`j' = subinstr(qfixed_5_0c_16_`j',"||||||||||||||||||||||||||||||||","",.)
}

*Generate new renamed variables
forval j = 1/20 {
	gen   	 ghg_tgt_int`j'_sect	 	= q_5_0c_1_`j'  	
	gen  	 ghg_tgt_int`j'_bound 		= q_5_0c_3_`j' 
	gen  	 ghg_tgt_int`j'_tgtyr		= q_5_0c_11_`j' 
}

*Labels not produced for these variables	



*5.0d BUSINESS AS USUAL TARGET - please provide details of your total city-wide baseline scenario target /*Note - added column q_5_0d_4_`j' added in 2021*/
**Competed if Baseline scenario (BUSINESS AS USUAL) target” is selected in response to 5.0:

*****Selective removal of pipes
**Rename variables which have pipes that you want to retain (in this case, listings of initiatives that cities are part of)
forval j = 1/20 {
rename q_5_0d_15_`j' qfixed_5_0d_15_`j'
}

*remove pipes from all other variables responses
foreach j of varl q_5_0d_*_*{
		replace `j' = subinstr(`j',"|","",.)
}

*then remove excess pipes from the variables you wanted to retain individual (divider) pipes in
forval j = 1/20 {
replace qfixed_5_0d_15_`j' = subinstr(qfixed_5_0d_15_`j',"|||||||||||||||||||||||||||||||||||","",.)
replace qfixed_5_0d_15_`j' = subinstr(qfixed_5_0d_15_`j',"|||||||||||||||||||||||||||||||||","",.)
replace qfixed_5_0d_15_`j' = subinstr(qfixed_5_0d_15_`j',"||||||||||||||||||||||||||||||||","",.)
}

*Generate new renamed variables
forval j = 1/20 {
	gen   	 ghg_tgt_bau`j'_sect	 	= q_5_0d_1_`j'  	
	gen  	 ghg_tgt_bau`j'_bound 		= q_5_0d_3_`j'
	gen  	 ghg_tgt_bau`j'_tgtyr  	 	= q_5_0d_8_`j' 
}

*Labels not produced for these variables	


*************************
*SECTION 6. OPPORTUNITIES
*************************

*6.0 Please indicate the opportunities your city has identified as a result of addressing cc and describe how the city is positioning to take advantage
forval i = 1/39 {
	gen 	opp_`i' 		=	 q_6_0_1_`i'  
	label var 	opp_`i' 		"Opportunities your city has identified"
}

*6.2  Does city collaborate with business on sustainability issues or projects
gen 		opp_collbz = q_6_2_0_0
label var  	opp_collbz  "Does city collaborate with business on sustainability issues or projects"


 
*********************************************************************************
*FINAL STEPS
*********************************************************************************

*Keep variables and save 
rename organization city
rename accountnumber accnum      
          
order accnum city country cdpregion, before(i_city_bound)

keep accnum - opp_collbz

destring, replace

save "`climcit'\cdp_2021_renamed", replace
clear


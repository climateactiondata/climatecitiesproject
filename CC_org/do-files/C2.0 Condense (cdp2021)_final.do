*********************************************************************
*Title		: Step 2 CDP 2021 Organisation
*Purpose	: Organises and condenses CDP data for Climate Cities paper(2021)
*Author		: Tanya O'Garra & Janhvi Kumar
*********************************************************************

*INSTALL DROPMISS
*findit dropmiss
*To install, select dm89_1

clear

*set directory (ADJUST AS NEEDED)
cd "C:\Users\Administrator\Desktop\CC_org" // ADJUST PATH NAME AS NEEDED

*local macro for path names
local climcit "C:\Users\Administrator\Desktop\CC_org" //ADJUST PATH NAME AS NEEDED

use "`climcit'\cdp_2021_renamed"

*************************************************************
*****GOVERNANCE (Section 1 CDP questionnaire)*****
*************************************************************


******COVID-19 IMPACT

**Impact of Covid19 on city climate actions
*reorganising the "other" variable for covimpct_act
gen covimpct_act_org =covimpct_act
replace covimpct_act_org="Other" if regexm(covimpct_act_org, "Other"+)

*Generating covimpct_act_codes
label define covact  1 "Increased emphasis on climate action"  2 "Decreased emphasis on climate action" 3 "No change on emphasis on climate action" 4 "Other", replace
encode covimpct_act_org, label(covact) gen( covimpct_act_code)

*Only the "other" category details
gen covimpct_act_otherTEXT= covimpct_act if regexm(covimpct_act, "Other, please specify"+)
replace covimpct_act_otherTEXT= substr(covimpct_act_otherTEXT, 24, .)

order covimpct_act_dtail, after(covimpct_act_otherTEXT)

label var covimpct_act_code "Impact of Covid on city climate actions"

*clean-up
drop covimpct_act_org


**Impact of Covid19 on city climate finance
*Reorganising the "other" variable for covimpct_econ
gen covimpct_econ_org =covimpct_econ
replace covimpct_econ_org="Other" if regexm(covimpct_econ_org, "Other"+)

*Generating covimpct_econ_codes
label define covecon  1 "Increased finance available for climate action"  2 "Reduced finance available for climate action" 3 "No change on finance available for climate action" 4 "Other", replace
encode covimpct_econ_org, label(covecon) gen( covimpct_econ_code)

*Only the "other" category details
gen covimpct_econ_otherTEXT= covimpct_econ if regexm(covimpct_econ, "Other, please specify"+)
replace covimpct_econ_otherTEXT= substr(covimpct_econ_otherTEXT, 23, .)

label var covimpct_econ_code "Impact of Covid on city climate finance"

*clean-up
drop covimpct_econ_org



******'Green recovery' interventions
gen covrecov_univers=0
gen covrecov_health=0 
gen covrecov_wash=0 
gen covrecov_employ=0 
gen covrecov_greentrain=0 
gen covrecov_justtrans=0 
gen covrecov_sustfood=0 
gen covrecov_susttransp=0 
gen covrecov_internet=0 
gen covrecov_tech=0 
gen covrecov_greenspace=0 
gen covrecov_dontknow=0 
gen covrecov_other=0 

forval i=1/12{
replace covrecov_univers=1 if regexm(cov_recov`i', "RECOVERY INTERVENTIONS THAT DEVELOP OR STRENGTHEN UNIVERSAL SOCIAL PROTECTION SYSTEMS THAT ENHANCE RESILIENCE TO SHOCKS, INCLUDING CLIMATE CHANGE") | inlist(cov_recov`i', "RECOVERY INTERVENTIONS THAT DEVELOP OR STRENGTHEN UNIVERSAL SOCIAL PROTECTION SYSTEMS THAT ENHANCE RESILIENCE TO SHOCKS, INCLUDING CLIMATE CHANGE")
replace covrecov_health=1 if regexm(cov_recov`i', "RECOVERY INTERVENTIONS THAT DEVELOP OR STRENGTHEN HEALTH/HEALTH CARE SERVICES IN YOUR CITY THAT ENHANCE RESILIENCE TO SHOCKS, INCLUDING CLIMATE CHANGE") | inlist(cov_recov`i', "RECOVERY INTERVENTIONS THAT DEVELOP OR STRENGTHEN HEALTH/HEALTH CARE SERVICES IN YOUR CITY THAT ENHANCE RESILIENCE TO SHOCKS, INCLUDING CLIMATE CHANGE")
replace covrecov_wash=1 if regexm(cov_recov`i', "RRECOVERY INTERVENTIONS THAT INCREASE INVESTMENT IN WATER, SANITATION, AND HYGIENE (WASH) SERVICES, FACILITIES AND/OR INFRASTRUCTURE") | inlist(cov_recov`i', "RECOVERY INTERVENTIONS THAT INCREASE INVESTMENT IN WATER, SANITATION, AND HYGIENE (WASH) SERVICES, FACILITIES AND/OR INFRASTRUCTURE")
replace covrecov_employ=1 if regexm(cov_recov`i', "RECOVERY INTERVENTIONS THAT FOCUS ON EMPLOYMENT OPPORTUNITIES IN GREEN SECTORS") | inlist(cov_recov`i', "RECOVERY INTERVENTIONS THAT FOCUS ON EMPLOYMENT OPPORTUNITIES IN GREEN SECTORS")
replace covrecov_greentrain=1 if regexm(cov_recov`i', "RECOVERY INTERVENTIONS THAT PROVIDE RESIDENTS WITH EFFECTIVE ACCESS TO TRAINING PROGRAMS RELATED TO GREEN SECTORS") | inlist(cov_recov`i', "RECOVERY INTERVENTIONS THAT PROVIDE RESIDENTS WITH EFFECTIVE ACCESS TO TRAINING PROGRAMS RELATED TO GREEN SECTORS")
replace covrecov_justtrans=1 if regexm(cov_recov`i', "RECOVERY INTERVENTIONS THAT SUPPORT JUST TRANSITION STRATEGIES FOR WORKERS AND COMMUNITIES") | inlist(cov_recov`i', "RECOVERY INTERVENTIONS THAT SUPPORT JUST TRANSITION STRATEGIES FOR WORKERS AND COMMUNITIES")
replace covrecov_sustfood=1 if regexm(cov_recov`i', "RECOVERY INTERVENTIONS THAT CHANNEL INVESTMENT IN SUSTAINABLE, RESILIENT AGRICULTURE AND FOOD SUPPLY CHAINS") | inlist(cov_recov`i', "RECOVERY INTERVENTIONS THAT CHANNEL INVESTMENT IN SUSTAINABLE, RESILIENT AGRICULTURE AND FOOD SUPPLY CHAINS")
replace covrecov_susttransp=1 if regexm(cov_recov`i', "RECOVERY INTERVENTIONS THAT BOOST PUBLIC AND SUSTAINABLE TRANSPORT OPTIONS") | inlist(cov_recov`i', "RECOVERY INTERVENTIONS THAT BOOST PUBLIC AND SUSTAINABLE TRANSPORT OPTIONS")
replace covrecov_internet=1 if regexm(cov_recov`i', "RECOVERY INTERVENTIONS THAT BUILD OUT BROADBAND AND INTERNET SERVICES TO THOSE WITH INADEQUATE ACCESS") | inlist(cov_recov`i', "RECOVERY INTERVENTIONS THAT BUILD OUT BROADBAND AND INTERNET SERVICES TO THOSE WITH INADEQUATE ACCESS")
replace covrecov_tech=1 if regexm(cov_recov`i', "RECOVERY INTERVENTIONS THAT SCALE UP INVESTMENTS IN AND ACCESS TO DIGITAL TECHNOLOGIES, FUNDING MECHANISMS, AND CAPACITY-BUILDING SOLUTIONS TO ENHANCE RESILIENCE TO SHOCKS, INCLUDING CLIMATE CHANGE") | inlist(cov_recov`i', "RRECOVERY INTERVENTIONS THAT SCALE UP INVESTMENTS IN AND ACCESS TO DIGITAL TECHNOLOGIES, FUNDING MECHANISMS, AND CAPACITY-BUILDING SOLUTIONS TO ENHANCE RESILIENCE TO SHOCKS, INCLUDING CLIMATE CHANGE")
replace covrecov_greenspace=1 if regexm(cov_recov`i', "RECOVERY INTERVENTIONS THAT INCREASE ACCESS TO URBAN GREEN SPACES") | inlist(cov_recov`i', "RECOVERY INTERVENTIONS THAT INCREASE ACCESS TO URBAN GREEN SPACES")
replace covrecov_dontknow=1 if regexm(cov_recov`i', "DO NOT KNOW") | inlist(cov_recov`i', "DO NOT KNOW")
replace covrecov_other=1 if regexm(cov_recov`i', "OTHER|OTHER,PLEASE SPECIFY"+) | inlist(cov_recov`i', "OTHER|OTHER,PLEASE SPECIFY"+)
}

label val covrecov_univers - covrecov_other select_yn 


**Only the "other" category details
forval i=1/12{
gen covrecov_`i'_otherTEXT = cov_recov`i' if regexm(cov_recov`i', "OTHER, PLEASE SPECIFY"+)
}

forval i =1/12{
replace covrecov_`i'_otherTEXT= substr(covrecov_`i'_otherTEXT, 23, .)
}

egen covrecov_otherTEXT=concat( covrecov_1_otherTEXT- covrecov_12_otherTEXT)
drop covrecov_1_otherTEXT- covrecov_12_otherTEXT

order cov_recov_dtail, after( covrecov_otherTEXT)


*************************************************************
****CC RISK & VULNERABILITY (Section 2 CDP survey)****
*************************************************************


*****CLIMATE HAZARDS

*Most significant climate hazard faced by your city
gen cc_hazd_precip   	=0
gen cc_hazd_storm    	=0
gen cc_hazd_cold     	=0
gen cc_hazd_hot			=0
gen cc_hazd_water		=0
gen cc_hazd_fire		=0
gen cc_hazd_flood		=0
gen cc_hazd_chemical	=0
gen cc_hazd_mass		=0
gen cc_hazd_bio			=0

forval i =1/30{
replace cc_hazd_precip	 =1	 if regexm(cc_sig_hazd_`i'_type, "Extreme Precipitation"+) | inlist(cc_sig_hazd_`i'_type, "Extreme Precipitation"+)
replace cc_hazd_storm	 =1	 if regexm(cc_sig_hazd_`i'_type, "Storm and wind"+) | inlist(cc_sig_hazd_`i'_type, "Storm and wind"+)
replace cc_hazd_cold	 =1	 if regexm(cc_sig_hazd_`i'_type, "Extreme cold temperature"+) | inlist(cc_sig_hazd_`i'_type, "Extreme cold temperature"+)
replace cc_hazd_hot		 =1	 if regexm(cc_sig_hazd_`i'_type, "Extreme hot temperature"+) | inlist(cc_sig_hazd_`i'_type, "Extreme hot temperature"+)
replace cc_hazd_water	 =1	 if regexm(cc_sig_hazd_`i'_type, "Water Scarcity"+) | inlist(cc_sig_hazd_`i'_type, "Water Scarcity"+)
replace cc_hazd_fire	 =1	 if regexm(cc_sig_hazd_`i'_type, "Wild fire"+) | inlist(cc_sig_hazd_`i'_type, "Wild fire"+)
replace cc_hazd_flood	 =1	 if regexm(cc_sig_hazd_`i'_type, "Flood and sea level rise"+) | inlist(cc_sig_hazd_`i'_type, "Flood and sea level rise"+)
replace cc_hazd_chemical =1	 if regexm(cc_sig_hazd_`i'_type, "Chemical change"+) | inlist(cc_sig_hazd_`i'_type, "chemical change"+)
replace cc_hazd_mass	 =1	 if regexm(cc_sig_hazd_`i'_type, "Mass movement"+) | inlist(cc_sig_hazd_`i'_type, "Mass movement"+)
replace cc_hazd_bio		 =1	 if regexm(cc_sig_hazd_`i'_type, "Biological hazards"+) | inlist(cc_sig_hazd_`i'_type, "Biological hazards"+)
}
label values cc_hazd_precip - cc_hazd_bio select_yn 


**Climate hazards that have MEDIUM-HIGH or HIGH PROBABILITY  only
gen cc_hazd_prob_precip=0
gen cc_hazd_prob_storm=0
gen cc_hazd_prob_cold=0
gen cc_hazd_prob_hot=0
gen cc_hazd_prob_water=0
gen cc_hazd_prob_fire=0
gen cc_hazd_prob_flood=0
gen cc_hazd_prob_chemical=0
gen cc_hazd_prob_mass=0
gen cc_hazd_prob_bio=0

gen cc_prob_med_hig=0

forval i=1/30{
replace cc_prob_med_hig=1 if inlist(cc_sig_hazd_`i'_prob, "Medium High")
replace cc_prob_med_hig=1 if inlist(cc_sig_hazd_`i'_prob, "High")
}

forval i=1/30{
replace cc_hazd_prob_precip= cc_prob_med_hig if regexm(cc_sig_hazd_`i'_type, "Extreme Precipitation"+)
replace cc_hazd_prob_storm= cc_prob_med_hig if regexm(cc_sig_hazd_`i'_type, "Storm and wind"+)
replace cc_hazd_prob_cold= cc_prob_med_hig if regexm(cc_sig_hazd_`i'_type, "Extreme cold temperature"+)
replace cc_hazd_prob_hot= cc_prob_med_hig if regexm(cc_sig_hazd_`i'_type, "Extreme hot temperature"+)
replace cc_hazd_prob_water= cc_prob_med_hig if regexm(cc_sig_hazd_`i'_type, "Water Scarcity"+)
replace cc_hazd_prob_fire= cc_prob_med_hig if regexm(cc_sig_hazd_`i'_type, "Wild fire"+)
replace cc_hazd_prob_flood= cc_prob_med_hig if regexm(cc_sig_hazd_`i'_type, "Flood and sea level rise"+)
replace cc_hazd_prob_chemical= cc_prob_med_hig if regexm(cc_sig_hazd_`i'_type, "Chemical change "+)
replace cc_hazd_prob_mass= cc_prob_med_hig if regexm(cc_sig_hazd_`i'_type, "Mass movement"+)
replace cc_hazd_prob_bio= cc_prob_med_hig if regexm(cc_sig_hazd_`i'_type, "Biological hazards"+)
}
label val cc_hazd_prob_precip - cc_hazd_prob_bio select_yn


*****NEW VAR, (ADDED TO LEVEL 4) whether city has had MEDIUM-HIGH/HIGH PROBABILITY impacts from at least one climate hazard (based on whether they selected at least one from the list)*********
*egen cc_hazd_prob_yes=anymatch( cc_hazd_prob_precip - cc_hazd_prob_bio), values(1) 
*order cc_hazd_prob_yes, before(cc_hazd_prob_precip )
*label var cc_hazd_prob_yes "Whether any med-high/high probability climate hazards (binary, all years)"

drop cc_prob_med_hig



*******City facing risk to public health or health systems associated with climate change
gen ccimpct_hlth_codes=.
replace ccimpct_hlth_codes=1 if regexm(ccimpct_hlth, "Yes")
replace ccimpct_hlth_codes=0 if regexm(ccimpct_hlth, "No$")
replace ccimpct_hlth_codes=0 if regexm(ccimpct_hlth, "No, please explain"+)
replace ccimpct_hlth_codes=100 if regexm(ccimpct_hlth, "Do not know")

label val ccimpct_hlth_codes yndk
label var ccimpct_hlth_codes "City facing health risk from climate change"

*generate binary version of above
gen ccimpct_hlth_yes=ccimpct_hlth_codes
recode ccimpct_hlth_yes 100=0

***********Climate-related health issues faced by city
gen ccimpct_hlth_iss_heat=0 if ccimpct_hlth_yes==1
gen ccimpct_hlth_iss_vect=0 if ccimpct_hlth_yes==1
gen ccimpct_hlth_iss_water=0 if ccimpct_hlth_yes==1
gen ccimpct_hlth_iss_air=0 if ccimpct_hlth_yes==1
gen ccimpct_hlth_iss_noncomm=0 if ccimpct_hlth_yes==1
gen ccimpct_hlth_iss_mental=0 if ccimpct_hlth_yes==1
gen ccimpct_hlth_iss_phy_inj=0 if ccimpct_hlth_yes==1
gen ccimpct_hlth_iss_food=0 if ccimpct_hlth_yes==1
gen ccimpct_hlth_iss_dis_water=0 if ccimpct_hlth_yes==1
gen ccimpct_hlth_iss_dis_hlth=0 if ccimpct_hlth_yes==1
gen ccimpct_hlth_iss_over_hlth=0 if ccimpct_hlth_yes==1
gen ccimpct_hlth_iss_lack_clim=0 if ccimpct_hlth_yes==1
gen ccimpct_hlth_iss_dam_hlth_infra=0 if ccimpct_hlth_yes==1
gen ccimpct_hlth_iss_dis_hlth_serv=0 if ccimpct_hlth_yes==1
gen ccimpct_hlth_iss_other=0 if ccimpct_hlth_yes==1

forval i=1/19{
replace ccimpct_hlth_iss_heat =1 if regexm(ccimpct_hlth_`i'_issue, "Heat-related illnesses")
replace ccimpct_hlth_iss_vect=1 if regexm(ccimpct_hlth_`i'_issue, "Vector-borne infectious diseases (e.g. malaria, dengue, Lyme disease, tick-borne encephalitis)")
replace ccimpct_hlth_iss_water=1 if regexm(ccimpct_hlth_`i'_issue, "Water-borne and food-borne infectious diseases (e.g. diarrhoeal diseases and wound infections)")
replace ccimpct_hlth_iss_air=1 if regexm(ccimpct_hlth_`i'_issue, "Air-pollution related illnesses")
replace ccimpct_hlth_iss_noncomm=1 if regexm(ccimpct_hlth_`i'_issue, "Exacerbation of Non-Communicable Disease Symptoms (e.g. respiratory disease, cardiovascular disease, renal disease)")
replace ccimpct_hlth_iss_mental=1 if regexm(ccimpct_hlth_`i'_issue, "Mental health impacts")
replace ccimpct_hlth_iss_phy_inj=1 if regexm(ccimpct_hlth_`i'_issue, "Direct physical injuries and deaths due to extreme weather events")
replace ccimpct_hlth_iss_food=1 if regexm(ccimpct_hlth_`i'_issue, "Food & Nutrition Security")
replace ccimpct_hlth_iss_dis_water=1 if regexm(ccimpct_hlth_`i'_issue, "Disruption to water, sanitation and wastewater services")
replace ccimpct_hlth_iss_dis_hlth=1 if regexm(ccimpct_hlth_`i'_issue, "Disruption of health-related services (e.g. roads, electricity, communications, emergency/ambulatory response, laboratories, pharmacies)")
replace ccimpct_hlth_iss_over_hlth=1 if regexm(ccimpct_hlth_`i'_issue, "Overwhelming of health service provision due to increased demand")
replace ccimpct_hlth_iss_lack_clim=1 if regexm(ccimpct_hlth_`i'_issue, "Lack of climate-informed surveillance, preparedness, early warning and response")
replace ccimpct_hlth_iss_dam_hlth_infra=1 if regexm(ccimpct_hlth_`i'_issue, "Damage/destruction to health infrastructure and technology")
replace ccimpct_hlth_iss_dis_hlth_serv=1 if regexm(ccimpct_hlth_`i'_issue, "Disruption of health-related services (e.g. roads, electricity, communications, emergency/ambulatory response, laboratories, pharmacies)")
replace ccimpct_hlth_iss_other=1 if regexm(ccimpct_hlth_`i'_issue, "Other, please specify"+)
}



***********************************************************
*****SECTION 5: EMISSIONS REDUCTION (CDP questionnaire)***
***********************************************************

*****GHG emissions reduction target - generating dummy variables for ghg_tgt*******
gen ghg_tgt_bsyr_abs=0
gen ghg_tgt_fxd=0
gen ghg_tgt_bsyr_intens=0
gen ghg_tgt_bau=0
gen ghg_tgt_none=0

replace ghg_tgt_bsyr_abs=1 if regexm(ghg_tgt, "Base year emissions"+)
replace ghg_tgt_fxd=1 if regexm(ghg_tgt, "Fixed level target")
replace ghg_tgt_bsyr_int=1 if regexm(ghg_tgt, "Base year intensity target")
replace ghg_tgt_bau=1 if regexm(ghg_tgt, "Baseline scenario"+)
replace ghg_tgt_none=1 if regexm(ghg_tgt, "No target")

egen ghg_tgt_sum=rowtotal(ghg_tgt_bsyr_abs-ghg_tgt_none)
gen ghg_tgt_missing= ghg_tgt_sum==0
recode ghg_tgt_sum (0=.)

foreach x of varlist ghg_tgt_bsyr_abs ghg_tgt_fxd ghg_tgt_bsyr_intens ghg_tgt_bau ghg_tgt_none{
replace `x'=. if ghg_tgt_missing==1
}



*********BASE YEAR EMISSIONS REDUCTIONS - ABSOLUTE TARGETS - organising ghg_tgt_abs_sect********
*re-organising the 'other' category
forval i=1/20{
tostring ghg_tgt_abs`i'_sect, replace
}

forval i=1/20{
gen ghg_tgt_abs`i'_sect_org =ghg_tgt_abs`i'_sect
replace ghg_tgt_abs`i'_sect_org="Other" if regexm(ghg_tgt_abs`i'_sect_org, "Other:"+)
replace ghg_tgt_abs`i'_sect_org="Other" if regexm(ghg_tgt_abs`i'_sect_org, "Other, please specify"+)
replace ghg_tgt_abs`i'_sect_org="Other" if regexm(ghg_tgt_abs`i'_sect_org, "Other")
replace ghg_tgt_abs`i'_sect_org="Other" if regexm(ghg_tgt_abs`i'_sect_org, "other"+)
}

forval i=1/20{
order ghg_tgt_abs`i'_sect_org, after(ghg_tgt_abs`i'_sect)
}

*Creating variables: emissions reduction targets for "All EMISSIONS"
forval i=1/20{
gen ghg_tgt_abs`i'_bound_all=ghg_tgt_abs`i'_bound if inlist(ghg_tgt_abs`i'_sect_org, "All emissions sources included in city inventory")
}
forval i=1/20{
gen ghg_tgt_abs`i'_tgtyr_all=ghg_tgt_abs`i'_tgtyr if inlist(ghg_tgt_abs`i'_sect_org, "All emissions sources included in city inventory")
}


*Creating variables: emissions reduction targets for "TRANSPORT"
forval i=1/20{
gen ghg_tgt_abs`i'_bound_trans=ghg_tgt_abs`i'_bound if inlist(ghg_tgt_abs`i'_sect_org, "Transport")
}
forval i=1/20{
gen ghg_tgt_abs`i'_tgtyr_trans=ghg_tgt_abs`i'_tgtyr if inlist(ghg_tgt_abs`i'_sect_org, "Transport")
}


*Creating variables: emissions reduction targets for "ENERGY"
forval i=1/20{
gen ghg_tgt_abs`i'_bound_ener=ghg_tgt_abs`i'_bound if inlist(ghg_tgt_abs`i'_sect_org, "Energy")
}
forval i=1/20{
gen ghg_tgt_abs`i'_tgtyr_ener=ghg_tgt_abs`i'_tgtyr if inlist(ghg_tgt_abs`i'_sect_org, "Energy")
}

*Creating variables: emissions reduction targets for "WASTE"
forval i=1/20{
gen ghg_tgt_abs`i'_bound_wast=ghg_tgt_abs`i'_bound if inlist(ghg_tgt_abs`i'_sect_org, "Waste")
}
forval i=1/20{
gen ghg_tgt_abs`i'_tgtyr_wast=ghg_tgt_abs`i'_tgtyr if inlist(ghg_tgt_abs`i'_sect_org, "Waste")
}



***********REORGANISING "ALL EMISSIONS" TARGETS*******************************
*****bound*****
forval i=1/20{
tostring ghg_tgt_abs`i'_bound_all, replace
}

forval i=1/20{
replace ghg_tgt_abs`i'_bound_all="1" if regexm(ghg_tgt_abs`i'_bound_all, "Same"+)
replace ghg_tgt_abs`i'_bound_all="2" if regexm(ghg_tgt_abs`i'_bound_all, "Smaller"+)
replace ghg_tgt_abs`i'_bound_all="3" if regexm(ghg_tgt_abs`i'_bound_all, "Larger"+)
replace ghg_tgt_abs`i'_bound_all="4" if regexm(ghg_tgt_abs`i'_bound_all, "Partial"+)
replace ghg_tgt_abs`i'_bound_all="5" if regexm(ghg_tgt_abs`i'_bound_all, "Administrative"+)
replace ghg_tgt_abs`i'_bound_all="5" if regexm(ghg_tgt_abs`i'_bound_all, "Local Government Operations"+)
}
forval i=1/20{
destring ghg_tgt_abs`i'_bound_all, replace
}

********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound = missing(ghg_tgt_abs`i'_bound_all)
   local next = `i' + 1
   qui replace ghg_tgt_abs`i'_bound_all = ghg_tgt_abs`next'_bound_all if imiss_bound
   qui replace ghg_tgt_abs`next'_bound_all = . if imiss_bound
}
}

********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr = missing(ghg_tgt_abs`i'_tgtyr_all)
   local next = `i' + 1
   qui replace ghg_tgt_abs`i'_tgtyr_all = ghg_tgt_abs`next'_tgtyr_all if imiss_tgtyr
   qui replace ghg_tgt_abs`next'_tgtyr_all = . if imiss_tgtyr
}
}

*clean-up
drop imiss_bound
drop imiss_tgtyr



*****************ORGANISING "TRANSPORT" TARGETS*********************************
****bound****
forval i=1/20{
tostring ghg_tgt_abs`i'_bound_trans, replace
}

forval i=1/20{
replace ghg_tgt_abs`i'_bound_tra="1" if regexm(ghg_tgt_abs`i'_bound_tra, "Same"+)
replace ghg_tgt_abs`i'_bound_tra="2" if regexm(ghg_tgt_abs`i'_bound_tra, "Larger"+)
replace ghg_tgt_abs`i'_bound_tra="3" if regexm(ghg_tgt_abs`i'_bound_tra, "Smaller"+)
replace ghg_tgt_abs`i'_bound_tra="4" if regexm(ghg_tgt_abs`i'_bound_tra, "Local Government Operations - covers only emission sources owned and operated by local government")
replace ghg_tgt_abs`i'_bound_tra="4" if regexm(ghg_tgt_abs`i'_bound_tra, "Administrative - covers only emission sources owned and operated by city administration")
replace ghg_tgt_abs`i'_bound_tra="5" if regexm(ghg_tgt_abs`i'_bound_tra, "Partial"+)
}

forval i=1/20{
destring ghg_tgt_abs`i'_bound_trans, replace
}

********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound_trans = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound_tra = missing(ghg_tgt_abs`i'_bound_tra)
   local next = `i' + 1
   qui replace ghg_tgt_abs`i'_bound_tra = ghg_tgt_abs`next'_bound_tra if imiss_bound_tra
   qui replace ghg_tgt_abs`next'_bound_tra = . if imiss_bound_tra
}
}

********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr_trans=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr_trans = missing(ghg_tgt_abs`i'_tgtyr_trans)
   local next = `i' + 1
   qui replace ghg_tgt_abs`i'_tgtyr_trans = ghg_tgt_abs`next'_tgtyr_trans if imiss_tgtyr_trans
   qui replace ghg_tgt_abs`next'_tgtyr_trans = . if imiss_tgtyr_trans
}
}

*clean-up
drop imiss_bound_trans
drop imiss_tgtyr_trans



*****************ORGANISING "ENERGY" TARGETS***********************************
****bound****
forval i=1/20{
tostring ghg_tgt_abs`i'_bound_ener, replace
}

forval i=1/20{
replace ghg_tgt_abs`i'_bound_ene="1" if regexm(ghg_tgt_abs`i'_bound_ene, "Same"+)
replace ghg_tgt_abs`i'_bound_ene="2" if regexm(ghg_tgt_abs`i'_bound_ene, "Larger"+)
replace ghg_tgt_abs`i'_bound_ene="3" if regexm(ghg_tgt_abs`i'_bound_ene, "Smaller"+)
replace ghg_tgt_abs`i'_bound_ene="4" if regexm(ghg_tgt_abs`i'_bound_ene, "Local Government Operations - covers only emission sources owned and operated by local government")
replace ghg_tgt_abs`i'_bound_ene="4" if regexm(ghg_tgt_abs`i'_bound_ene, "Administrative - covers only emission sources owned and operated by city administration")
replace ghg_tgt_abs`i'_bound_ene="5" if regexm(ghg_tgt_abs`i'_bound_ene, "Partial"+)
}

forval i=1/20{
destring ghg_tgt_abs`i'_bound_ene, replace
}

********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound_ener = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound_ene = missing(ghg_tgt_abs`i'_bound_ene)
   local next = `i' + 1
   qui replace ghg_tgt_abs`i'_bound_ene = ghg_tgt_abs`next'_bound_ene if imiss_bound_ene
   qui replace ghg_tgt_abs`next'_bound_ene = . if imiss_bound_ener
}
}

********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr_ener=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr_ener = missing(ghg_tgt_abs`i'_tgtyr_ener)
   local next = `i' + 1
   qui replace ghg_tgt_abs`i'_tgtyr_ener = ghg_tgt_abs`next'_tgtyr_ener if imiss_tgtyr_ener
   qui replace ghg_tgt_abs`next'_tgtyr_ener = . if imiss_tgtyr_ener
}
}

*clean-up
drop imiss_bound_ener
drop imiss_tgtyr_ener




***********REORGANISING "WASTE" TARGETS***********************************
****bound****
forval i=1/20{
tostring ghg_tgt_abs`i'_bound_wast, replace
}
forval i=1/20{
replace ghg_tgt_abs`i'_bound_was="1" if regexm(ghg_tgt_abs`i'_bound_was, "Same"+)
replace ghg_tgt_abs`i'_bound_was="2" if regexm(ghg_tgt_abs`i'_bound_was, "Larger"+)
replace ghg_tgt_abs`i'_bound_was="3" if regexm(ghg_tgt_abs`i'_bound_was, "Smaller"+)
replace ghg_tgt_abs`i'_bound_was="4" if regexm(ghg_tgt_abs`i'_bound_was, "Local Government Operations - covers only emission sources owned and operated by local government")
replace ghg_tgt_abs`i'_bound_was="4" if regexm(ghg_tgt_abs`i'_bound_was, "Administrative - covers only emission sources owned and operated by city administration")
replace ghg_tgt_abs`i'_bound_was="5" if regexm(ghg_tgt_abs`i'_bound_was, "Partial"+)
}

forval i=1/20{
destring ghg_tgt_abs`i'_bound_was, replace
}

********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound_wast = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound_was = missing(ghg_tgt_abs`i'_bound_was)
   local next = `i' + 1
   qui replace ghg_tgt_abs`i'_bound_was = ghg_tgt_abs`next'_bound_was if imiss_bound_was
   qui replace ghg_tgt_abs`next'_bound_was = . if imiss_bound_was
}
}

********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr_wast=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr_wast = missing(ghg_tgt_abs`i'_tgtyr_wast)
   local next = `i' + 1
   qui replace ghg_tgt_abs`i'_tgtyr_wast = ghg_tgt_abs`next'_tgtyr_wast if imiss_tgtyr_wast
   qui replace ghg_tgt_abs`next'_tgtyr_wast = . if imiss_tgtyr_wast
}
}

*clean-up
drop imiss_bound_wast
drop imiss_tgtyr_wast

*****************************************************************************************************************************************
*****COUNT OF BASELINE YEAR ABSOLUTE EMISSIONS EMISSIONS TARGETS BY CITY****************************** 
egen ghg_tgt_abs_all_total=rownonmiss( ghg_tgt_abs1_tgtyr_all- ghg_tgt_abs20_tgtyr_all)

*****************************************************************************************************************************************



*****************************************************************************************************************************************
********EMISSIONS REDUCTIONS - FIXED LEVEL TARGETS - organising ghg_tgt_fxd_sect******** 
*re-organising the 'other' category
forval i=1/20{
tostring ghg_tgt_fxd`i'_sect, replace
}

forval i=1/20{
gen ghg_tgt_fxd`i'_sect_org =ghg_tgt_fxd`i'_sect
replace ghg_tgt_fxd`i'_sect_org="Other" if regexm(ghg_tgt_fxd`i'_sect_org, "Other:"+)
replace ghg_tgt_fxd`i'_sect_org="Other" if regexm(ghg_tgt_fxd`i'_sect_org, "Other, please specify"+)
replace ghg_tgt_fxd`i'_sect_org="Other" if regexm(ghg_tgt_fxd`i'_sect_org, "Other")
replace ghg_tgt_fxd`i'_sect_org="Other" if regexm(ghg_tgt_fxd`i'_sect_org, "other"+)
}

forval i=1/20{
order ghg_tgt_fxd`i'_sect_org, after(ghg_tgt_fxd`i'_sect)
}

*********Creating variables: emissions reduction targets for "All EMISSIONS"
forval i=1/20{
gen ghg_tgt_fxd`i'_bound_all=ghg_tgt_fxd`i'_bound if inlist(ghg_tgt_fxd`i'_sect_org, "All emissions sources included in city inventory")
}
forval i=1/20{
gen ghg_tgt_fxd`i'_tgtyr_all=ghg_tgt_fxd`i'_tgtyr if inlist(ghg_tgt_fxd`i'_sect_org, "All emissions sources included in city inventory")
}


*********Creating variables: emissions reduction targets for "TRANSPORT"
forval i=1/20{
gen ghg_tgt_fxd`i'_bound_trans=ghg_tgt_fxd`i'_bound if inlist(ghg_tgt_fxd`i'_sect_org, "Transport")
}
forval i=1/20{
gen ghg_tgt_fxd`i'_tgtyr_trans=ghg_tgt_fxd`i'_tgtyr if inlist(ghg_tgt_fxd`i'_sect_org, "Transport")
}


*********Creating variables: emissions reduction targets for "ENERGY"
forval i=1/20{
gen ghg_tgt_fxd`i'_bound_ener=ghg_tgt_fxd`i'_bound if inlist(ghg_tgt_fxd`i'_sect_org, "Energy")
}
forval i=1/20{
gen ghg_tgt_fxd`i'_tgtyr_ener=ghg_tgt_fxd`i'_tgtyr if inlist(ghg_tgt_fxd`i'_sect_org, "Energy")
}


*********Creating variables: emissions reduction targets for "WASTE"
forval i=1/20{
gen ghg_tgt_fxd`i'_bound_wast=ghg_tgt_fxd`i'_bound if inlist(ghg_tgt_fxd`i'_sect_org, "Waste")
}
forval i=1/20{
gen ghg_tgt_fxd`i'_tgtyr_wast=ghg_tgt_fxd`i'_tgtyr if inlist(ghg_tgt_fxd`i'_sect_org, "Waste")
}



***********REORGANISING "ALL EMISSIONS" TARGETS*********************************
*****bound*****
forval i=1/20{
tostring ghg_tgt_fxd`i'_bound_all, replace
}

forval i=1/20{
replace ghg_tgt_fxd`i'_bound_all="1" if regexm(ghg_tgt_fxd`i'_bound_all, "Same"+)
replace ghg_tgt_fxd`i'_bound_all="2" if regexm(ghg_tgt_fxd`i'_bound_all, "Smaller"+)
replace ghg_tgt_fxd`i'_bound_all="3" if regexm(ghg_tgt_fxd`i'_bound_all, "Larger"+)
replace ghg_tgt_fxd`i'_bound_all="4" if regexm(ghg_tgt_fxd`i'_bound_all, "Partial"+)
replace ghg_tgt_fxd`i'_bound_all="5" if regexm(ghg_tgt_fxd`i'_bound_all, "Administrative"+)
replace ghg_tgt_fxd`i'_bound_all="5" if regexm(ghg_tgt_fxd`i'_bound_all, "Local Government Operations"+)
}
forval i=1/20{
destring ghg_tgt_fxd`i'_bound_all, replace
}
********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound = missing(ghg_tgt_fxd`i'_bound_all)
   local next = `i' + 1
   qui replace ghg_tgt_fxd`i'_bound_all = ghg_tgt_fxd`next'_bound_all if imiss_bound
   qui replace ghg_tgt_fxd`next'_bound_all = . if imiss_bound
}
}

********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr = missing(ghg_tgt_fxd`i'_tgtyr_all)
   local next = `i' + 1
   qui replace ghg_tgt_fxd`i'_tgtyr_all = ghg_tgt_fxd`next'_tgtyr_all if imiss_tgtyr
   qui replace ghg_tgt_fxd`next'_tgtyr_all = . if imiss_tgtyr
}
}

*clean-up
drop imiss_bound
drop imiss_tgtyr


***********REORGANISING "TRANSPORT" TARGETS***********************************
****bound****
forval i=1/20{
tostring ghg_tgt_fxd`i'_bound_trans, replace
}

forval i=1/20{
replace ghg_tgt_fxd`i'_bound_tra="1" if regexm(ghg_tgt_fxd`i'_bound_tra, "Same"+)
replace ghg_tgt_fxd`i'_bound_tra="2" if regexm(ghg_tgt_fxd`i'_bound_tra, "Larger"+)
replace ghg_tgt_fxd`i'_bound_tra="3" if regexm(ghg_tgt_fxd`i'_bound_tra, "Smaller"+)
replace ghg_tgt_fxd`i'_bound_tra="4" if regexm(ghg_tgt_fxd`i'_bound_tra, "Local Government Operations"+)
replace ghg_tgt_fxd`i'_bound_tra="4" if regexm(ghg_tgt_fxd`i'_bound_tra, "Administrative"+)
replace ghg_tgt_fxd`i'_bound_tra="5" if regexm(ghg_tgt_fxd`i'_bound_tra, "Partial"+)
}

forval i=1/20{
destring ghg_tgt_fxd`i'_bound_trans, replace
}

********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound_trans = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound_tra = missing(ghg_tgt_fxd`i'_bound_tra)
   local next = `i' + 1
   qui replace ghg_tgt_fxd`i'_bound_tra = ghg_tgt_fxd`next'_bound_tra if imiss_bound_tra
   qui replace ghg_tgt_fxd`next'_bound_tra = . if imiss_bound_tra
}
}

********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr_trans=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr_trans = missing(ghg_tgt_fxd`i'_tgtyr_trans)
   local next = `i' + 1
   qui replace ghg_tgt_fxd`i'_tgtyr_trans = ghg_tgt_fxd`next'_tgtyr_trans if imiss_tgtyr_trans
   qui replace ghg_tgt_fxd`next'_tgtyr_trans = . if imiss_tgtyr_trans
}
}

*clean-up
drop imiss_bound_trans
drop imiss_tgtyr_trans




***********REORGANISING "ENERGY" TARGETS*****************************
****bound****
forval i=1/20{
tostring ghg_tgt_fxd`i'_bound_ener, replace
}
*forval i=1/20{
*gen ghg_tgt_fxd`i'_bound_ene=ghg_tgt_fxd`i'_bound_ener
*}
forval i=1/20{
replace ghg_tgt_fxd`i'_bound_ene="1" if regexm(ghg_tgt_fxd`i'_bound_ene, "Same"+)
replace ghg_tgt_fxd`i'_bound_ene="2" if regexm(ghg_tgt_fxd`i'_bound_ene, "Larger"+)
replace ghg_tgt_fxd`i'_bound_ene="3" if regexm(ghg_tgt_fxd`i'_bound_ene, "Smaller"+)
replace ghg_tgt_fxd`i'_bound_ene="4" if regexm(ghg_tgt_fxd`i'_bound_ene, "Local Government Operations"+)
replace ghg_tgt_fxd`i'_bound_ene="4" if regexm(ghg_tgt_fxd`i'_bound_ene, "Administrative"+)
replace ghg_tgt_fxd`i'_bound_ene="5" if regexm(ghg_tgt_fxd`i'_bound_ene, "Partial"+)
}
forval i=1/20{
destring ghg_tgt_fxd`i'_bound_ene, replace
}

********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound_ener = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound_ene = missing(ghg_tgt_fxd`i'_bound_ene)
   local next = `i' + 1
   qui replace ghg_tgt_fxd`i'_bound_ene = ghg_tgt_fxd`next'_bound_ene if imiss_bound_ene
   qui replace ghg_tgt_fxd`next'_bound_ene = . if imiss_bound_ener
}
}


********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr_ener=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr_ener = missing(ghg_tgt_fxd`i'_tgtyr_ener)
   local next = `i' + 1
   qui replace ghg_tgt_fxd`i'_tgtyr_ener = ghg_tgt_fxd`next'_tgtyr_ener if imiss_tgtyr_ener
   qui replace ghg_tgt_fxd`next'_tgtyr_ener = . if imiss_tgtyr_ener
}
}

*clean-up
drop imiss_bound_ener
drop imiss_tgtyr_ener



***********REORGANISING "WASTE" TARGETS*******************************
****bound****
forval i=1/20{
tostring ghg_tgt_fxd`i'_bound_wast, replace
}

forval i=1/20{
replace ghg_tgt_fxd`i'_bound_was="1" if regexm(ghg_tgt_fxd`i'_bound_was, "Same"+)
replace ghg_tgt_fxd`i'_bound_was="2" if regexm(ghg_tgt_fxd`i'_bound_was, "Larger"+)
replace ghg_tgt_fxd`i'_bound_was="3" if regexm(ghg_tgt_fxd`i'_bound_was, "Smaller"+)
replace ghg_tgt_fxd`i'_bound_was="4" if regexm(ghg_tgt_fxd`i'_bound_was, "Local Government Operations"+)
replace ghg_tgt_fxd`i'_bound_was="4" if regexm(ghg_tgt_fxd`i'_bound_was, "Administrative"+)
replace ghg_tgt_fxd`i'_bound_was="5" if regexm(ghg_tgt_fxd`i'_bound_was, "Partial"+)
}

forval i=1/20{
destring ghg_tgt_fxd`i'_bound_was, replace
}

********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound_wast = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound_was = missing(ghg_tgt_fxd`i'_bound_was)
   local next = `i' + 1
   qui replace ghg_tgt_fxd`i'_bound_was = ghg_tgt_fxd`next'_bound_was if imiss_bound_was
   qui replace ghg_tgt_fxd`next'_bound_was = . if imiss_bound_was
}
}

********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr_wast=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr_wast = missing(ghg_tgt_fxd`i'_tgtyr_wast)
   local next = `i' + 1
   qui replace ghg_tgt_fxd`i'_tgtyr_wast = ghg_tgt_fxd`next'_tgtyr_wast if imiss_tgtyr_wast
   qui replace ghg_tgt_fxd`next'_tgtyr_wast = . if imiss_tgtyr_wast
}
}

*clean-up
drop imiss_bound_wast
drop imiss_tgtyr_wast



*****************************************************************************************************************************************
*****COUNT OF FIXED LEVEL EMISSIONS TARGETS BY CITY ("ALL EMISSIONS")****************************** 
egen ghg_tgt_fxd_all_total=rownonmiss( ghg_tgt_fxd1_tgtyr_all- ghg_tgt_fxd20_tgtyr_all )

*************************************************************************************************************************************


*************************************************************************************************************************************
********EMISSIONS REDUCTIONS - BASE YEAR INTENSITY TARGETS - organising ghg_tgt_int_sect******** 
*re-organising the 'other' category
forval i=1/20{
tostring ghg_tgt_int`i'_sect, replace 
}

forval i=1/20{
gen ghg_tgt_int`i'_sect_org =ghg_tgt_int`i'_sect
replace ghg_tgt_int`i'_sect_org="Other" if regexm(ghg_tgt_int`i'_sect_org, "Other:"+)
replace ghg_tgt_int`i'_sect_org="Other" if regexm(ghg_tgt_int`i'_sect_org, "Other, please specify"+)
replace ghg_tgt_int`i'_sect_org="Other" if regexm(ghg_tgt_int`i'_sect_org, "Other")
replace ghg_tgt_int`i'_sect_org="Other" if regexm(ghg_tgt_int`i'_sect_org, "other"+)
}
forval i=1/20{
order ghg_tgt_int`i'_sect_org, after(ghg_tgt_int`i'_sect)
}


*********Creating variables: emissions reduction targets for "All EMISSIONS"
forval i=1/20{
gen ghg_tgt_int`i'_bound_all=ghg_tgt_int`i'_bound if inlist(ghg_tgt_int`i'_sect_org, "All emissions sources included in city inventory")
}

forval i=1/20{
gen ghg_tgt_int`i'_tgtyr_all=ghg_tgt_int`i'_tgtyr if inlist(ghg_tgt_int`i'_sect_org, "All emissions sources included in city inventory")
}


*********Creating variables: emissions reduction targets for "TRANSPORT"
forval i=1/20{
gen ghg_tgt_int`i'_bound_trans=ghg_tgt_int`i'_bound if inlist(ghg_tgt_int`i'_sect_org, "Transport")
}

forval i=1/20{
gen ghg_tgt_int`i'_tgtyr_trans=ghg_tgt_int`i'_tgtyr if inlist(ghg_tgt_int`i'_sect_org, "Transport")
}


*********Creating variables: emissions reduction targets for "ENERGY"
forval i=1/20{
gen ghg_tgt_int`i'_bound_ener=ghg_tgt_int`i'_bound if inlist(ghg_tgt_int`i'_sect_org, "Energy")
}

forval i=1/20{
gen ghg_tgt_int`i'_tgtyr_ener=ghg_tgt_int`i'_tgtyr if inlist(ghg_tgt_int`i'_sect_org, "Energy")
}



*********Creating variables: emissions reduction targets for "WASTE"
forval i=1/20{
gen ghg_tgt_int`i'_bound_wast=ghg_tgt_int`i'_bound if inlist(ghg_tgt_int`i'_sect_org, "Waste")
}

forval i=1/20{
gen ghg_tgt_int`i'_tgtyr_wast=ghg_tgt_int`i'_tgtyr if inlist(ghg_tgt_int`i'_sect_org, "Waste")
}



***********REORGANISING "ALL EMISSIONS" TARGETS***********************************
*****bound*****
forval i=1/20{
tostring ghg_tgt_int`i'_bound_all, replace
}

forval i=1/20{
replace ghg_tgt_int`i'_bound_all="1" if regexm(ghg_tgt_int`i'_bound_all, "Same"+)
replace ghg_tgt_int`i'_bound_all="2" if regexm(ghg_tgt_int`i'_bound_all, "Smaller"+)
replace ghg_tgt_int`i'_bound_all="3" if regexm(ghg_tgt_int`i'_bound_all, "Larger"+)
replace ghg_tgt_int`i'_bound_all="4" if regexm(ghg_tgt_int`i'_bound_all, "Partial"+)
replace ghg_tgt_int`i'_bound_all="5" if regexm(ghg_tgt_int`i'_bound_all, "Administrative"+)
replace ghg_tgt_int`i'_bound_all="5" if regexm(ghg_tgt_int`i'_bound_all, "Local Government Operations"+)
}
forval i=1/20{
destring ghg_tgt_int`i'_bound_all, replace
}


********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound = missing(ghg_tgt_int`i'_bound_all)
   local next = `i' + 1
   qui replace ghg_tgt_int`i'_bound_all = ghg_tgt_int`next'_bound_all if imiss_bound
   qui replace ghg_tgt_int`next'_bound_all = . if imiss_bound
}
}

********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr = missing(ghg_tgt_int`i'_tgtyr_all)
   local next = `i' + 1
   qui replace ghg_tgt_int`i'_tgtyr_all = ghg_tgt_int`next'_tgtyr_all if imiss_tgtyr
   qui replace ghg_tgt_int`next'_tgtyr_all = . if imiss_tgtyr
}
}

*clean-up
drop imiss_bound
drop imiss_tgtyr





***********REORGANISING "TRANSPORT" TARGETS***********************************
****bound****
forval i=1/20{
tostring ghg_tgt_int`i'_bound_trans, replace
}

forval i=1/20{
replace ghg_tgt_int`i'_bound_tra="1" if regexm(ghg_tgt_int`i'_bound_tra, "Same"+)
replace ghg_tgt_int`i'_bound_tra="2" if regexm(ghg_tgt_int`i'_bound_tra, "Larger"+)
replace ghg_tgt_int`i'_bound_tra="3" if regexm(ghg_tgt_int`i'_bound_tra, "Smaller"+)
replace ghg_tgt_int`i'_bound_tra="4" if regexm(ghg_tgt_int`i'_bound_tra, "Local Government Operations"+)
replace ghg_tgt_int`i'_bound_tra="4" if regexm(ghg_tgt_int`i'_bound_tra, "Administrative"+)
replace ghg_tgt_int`i'_bound_tra="5" if regexm(ghg_tgt_int`i'_bound_tra, "Partial"+)
}

forval i=1/20{
destring ghg_tgt_int`i'_bound_trans, replace
}

********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound_trans = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound_tra = missing(ghg_tgt_int`i'_bound_tra)
   local next = `i' + 1
   qui replace ghg_tgt_int`i'_bound_tra = ghg_tgt_int`next'_bound_tra if imiss_bound_tra
   qui replace ghg_tgt_int`next'_bound_tra = . if imiss_bound_tra
}
}

********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr_trans=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr_trans = missing(ghg_tgt_int`i'_tgtyr_trans)
   local next = `i' + 1
   qui replace ghg_tgt_int`i'_tgtyr_trans = ghg_tgt_int`next'_tgtyr_trans if imiss_tgtyr_trans
   qui replace ghg_tgt_int`next'_tgtyr_trans = . if imiss_tgtyr_trans
}
}

*clean-up
drop imiss_bound_trans
drop imiss_tgtyr_trans



***********REORGANISING "ENERGY" TARGETS*******************************
****bound****
forval i=1/20{
tostring ghg_tgt_int`i'_bound_ener, replace
}
*forval i=1/20{
*gen ghg_tgt_int`i'_bound_ene=ghg_tgt_int`i'_bound_ener
*}
forval i=1/20{
replace ghg_tgt_int`i'_bound_ene="1" if regexm(ghg_tgt_int`i'_bound_ene, "Same"+)
replace ghg_tgt_int`i'_bound_ene="2" if regexm(ghg_tgt_int`i'_bound_ene, "Larger"+)
replace ghg_tgt_int`i'_bound_ene="3" if regexm(ghg_tgt_int`i'_bound_ene, "Smaller"+)
replace ghg_tgt_int`i'_bound_ene="4" if regexm(ghg_tgt_int`i'_bound_ene, "Local Government Operations"+)
replace ghg_tgt_int`i'_bound_ene="4" if regexm(ghg_tgt_int`i'_bound_ene, "Administrative"+)
replace ghg_tgt_int`i'_bound_ene="5" if regexm(ghg_tgt_int`i'_bound_ene, "Partial"+)
}

forval i=1/20{
destring ghg_tgt_int`i'_bound_ene, replace
}

********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound_ener = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound_ene = missing(ghg_tgt_int`i'_bound_ene)
   local next = `i' + 1
   qui replace ghg_tgt_int`i'_bound_ene = ghg_tgt_int`next'_bound_ene if imiss_bound_ene
   qui replace ghg_tgt_int`next'_bound_ene = . if imiss_bound_ener
}
}

********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr_ener=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr_ener = missing(ghg_tgt_int`i'_tgtyr_ener)
   local next = `i' + 1
   qui replace ghg_tgt_int`i'_tgtyr_ener = ghg_tgt_int`next'_tgtyr_ener if imiss_tgtyr_ener
   qui replace ghg_tgt_int`next'_tgtyr_ener = . if imiss_tgtyr_ener
}
}

*clean-up
drop imiss_bound_ener
drop imiss_tgtyr_ener




***********REORGANISING "WASTE" TARGETS*******************************
****bound****
forval i=1/20{
tostring ghg_tgt_int`i'_bound_wast, replace
}
*forval i=1/20{
*gen ghg_tgt_int`i'_bound_was=ghg_tgt_int`i'_bound_wast
*}

forval i=1/20{
replace ghg_tgt_int`i'_bound_was="1" if regexm(ghg_tgt_int`i'_bound_was, "Same"+)
replace ghg_tgt_int`i'_bound_was="2" if regexm(ghg_tgt_int`i'_bound_was, "Larger"+)
replace ghg_tgt_int`i'_bound_was="3" if regexm(ghg_tgt_int`i'_bound_was, "Smaller"+)
replace ghg_tgt_int`i'_bound_was="4" if regexm(ghg_tgt_int`i'_bound_was, "Local Government Operations"+)
replace ghg_tgt_int`i'_bound_was="4" if regexm(ghg_tgt_int`i'_bound_was, "Administrative"+)
replace ghg_tgt_int`i'_bound_was="5" if regexm(ghg_tgt_int`i'_bound_was, "Partial"+)
}

forval i=1/20{
destring ghg_tgt_int`i'_bound_was, replace
}
********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound_wast = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound_was = missing(ghg_tgt_int`i'_bound_was)
   local next = `i' + 1
   qui replace ghg_tgt_int`i'_bound_was = ghg_tgt_int`next'_bound_was if imiss_bound_was
   qui replace ghg_tgt_int`next'_bound_was = . if imiss_bound_was
}
}

********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr_wast=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr_wast = missing(ghg_tgt_int`i'_tgtyr_wast)
   local next = `i' + 1
   qui replace ghg_tgt_int`i'_tgtyr_wast = ghg_tgt_int`next'_tgtyr_wast if imiss_tgtyr_wast
   qui replace ghg_tgt_int`next'_tgtyr_wast = . if imiss_tgtyr_wast
}
}

*clean-up
drop imiss_bound_wast
drop imiss_tgtyr_wast


*******************************************************************************************************************************
*****COUNT OF BASELINE YEAR INTENSITY EMISSIONS EMISSIONS TARGETS BY CITY****************************** 
egen ghg_tgt_int_all_total=rownonmiss( ghg_tgt_int1_tgtyr_all- ghg_tgt_int20_tgtyr_all)

*******************************************************************************************************************************



*******************************************************************************************************************************
***************EMISSIONS TARGETS - BASE YEAR SCENARIO (BUSINESS AS USUAL (BAU)) TARGETS ********************** 
*re-organising the 'other' category
forval i=1/20{
tostring ghg_tgt_bau`i'_sect, replace 
}

forval i=1/20{
gen ghg_tgt_bau`i'_sect_org =ghg_tgt_bau`i'_sect
replace ghg_tgt_bau`i'_sect_org="Other" if regexm(ghg_tgt_bau`i'_sect_org, "Other:"+)
replace ghg_tgt_bau`i'_sect_org="Other" if regexm(ghg_tgt_bau`i'_sect_org, "Other, please specify"+)
replace ghg_tgt_bau`i'_sect_org="Other" if regexm(ghg_tgt_bau`i'_sect_org, "Other")
replace ghg_tgt_bau`i'_sect_org="Other" if regexm(ghg_tgt_bau`i'_sect_org, "other"+)
}
forval i=1/20{
order ghg_tgt_bau`i'_sect_org, after(ghg_tgt_bau`i'_sect)
}


*********Creating variables: emissions reduction targets for "All EMISSIONS"***************
forval i=1/20{
gen ghg_tgt_bau`i'_bound_all=ghg_tgt_bau`i'_bound if inlist(ghg_tgt_bau`i'_sect_org, "All emissions sources included in city inventory")
}

forval i=1/20{
gen ghg_tgt_bau`i'_tgtyr_all=ghg_tgt_bau`i'_tgtyr if inlist(ghg_tgt_bau`i'_sect_org, "All emissions sources included in city inventory")
}



*********Creating variables: emissions reduction targets for "TRANSPORT"***************
forval i=1/20{
gen ghg_tgt_bau`i'_bound_trans=ghg_tgt_bau`i'_bound if inlist(ghg_tgt_bau`i'_sect_org, "Transport")
}

forval i=1/20{
gen ghg_tgt_bau`i'_tgtyr_trans=ghg_tgt_bau`i'_tgtyr if inlist(ghg_tgt_bau`i'_sect_org, "Transport")
}



*********Creating variables: emissions reduction targets for "ENERGY"***************
forval i=1/20{
gen ghg_tgt_bau`i'_bound_ener=ghg_tgt_bau`i'_bound if inlist(ghg_tgt_bau`i'_sect_org, "Energy")
}

forval i=1/20{
gen ghg_tgt_bau`i'_tgtyr_ener=ghg_tgt_bau`i'_tgtyr if inlist(ghg_tgt_bau`i'_sect_org, "Energy")
}


*********Creating variables: emissions reduction targets for "WASTE"***************
forval i=1/20{
gen ghg_tgt_bau`i'_bound_wast=ghg_tgt_bau`i'_bound if inlist(ghg_tgt_bau`i'_sect_org, "Waste")
}

forval i=1/20{
gen ghg_tgt_bau`i'_tgtyr_wast=ghg_tgt_bau`i'_tgtyr if inlist(ghg_tgt_bau`i'_sect_org, "Waste")
}




***********REORGANISING "ALL EMISSIONS" TARGETS***********************************
*****bound*****
forval i=1/20{
tostring ghg_tgt_bau`i'_bound_all, replace
}


forval i=1/20{
replace ghg_tgt_bau`i'_bound_all="1" if regexm(ghg_tgt_bau`i'_bound_all, "Same"+)
replace ghg_tgt_bau`i'_bound_all="2" if regexm(ghg_tgt_bau`i'_bound_all, "Smaller"+)
replace ghg_tgt_bau`i'_bound_all="3" if regexm(ghg_tgt_bau`i'_bound_all, "Larger"+)
replace ghg_tgt_bau`i'_bound_all="4" if regexm(ghg_tgt_bau`i'_bound_all, "Partial"+)
replace ghg_tgt_bau`i'_bound_all="5" if regexm(ghg_tgt_bau`i'_bound_all, "Administrative"+)
replace ghg_tgt_bau`i'_bound_all="5" if regexm(ghg_tgt_bau`i'_bound_all, "Local Government Operations"+)
}
forval i=1/20{
destring ghg_tgt_bau`i'_bound_all, replace
}

********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound = missing(ghg_tgt_bau`i'_bound_all)
   local next = `i' + 1
   qui replace ghg_tgt_bau`i'_bound_all = ghg_tgt_bau`next'_bound_all if imiss_bound
   qui replace ghg_tgt_bau`next'_bound_all = . if imiss_bound
}
}

********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr = missing(ghg_tgt_bau`i'_tgtyr_all)
   local next = `i' + 1
   qui replace ghg_tgt_bau`i'_tgtyr_all = ghg_tgt_bau`next'_tgtyr_all if imiss_tgtyr
   qui replace ghg_tgt_bau`next'_tgtyr_all = . if imiss_tgtyr
}
}

*clean-up
drop imiss_bound
drop imiss_tgtyr



***********REORGANISING "TRANSPORT" TARGETS***********************************
*****bound*****
forval i=1/20{
tostring ghg_tgt_bau`i'_bound_trans, replace
}


forval i=1/20{
replace ghg_tgt_bau`i'_bound_trans="1" if regexm(ghg_tgt_bau`i'_bound_trans, "Same"+)
replace ghg_tgt_bau`i'_bound_trans="2" if regexm(ghg_tgt_bau`i'_bound_trans, "Larger"+)
replace ghg_tgt_bau`i'_bound_trans="3" if regexm(ghg_tgt_bau`i'_bound_trans, "Smaller"+)
replace ghg_tgt_bau`i'_bound_trans="4" if regexm(ghg_tgt_bau`i'_bound_trans, "Local Government Operations"+)
replace ghg_tgt_bau`i'_bound_trans="4" if regexm(ghg_tgt_bau`i'_bound_trans, "Administrative"+)
replace ghg_tgt_bau`i'_bound_trans="5" if regexm(ghg_tgt_bau`i'_bound_trans, "Partial"+)
}
forval i=1/20{
destring ghg_tgt_bau`i'_bound_trans, replace
}


********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound_trans = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound = missing(ghg_tgt_bau`i'_bound_trans)
   local next = `i' + 1
   qui replace ghg_tgt_bau`i'_bound_trans = ghg_tgt_bau`next'_bound_trans if imiss_bound
   qui replace ghg_tgt_bau`next'_bound_trans = . if imiss_bound
}
}


********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr_trans=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr = missing(ghg_tgt_bau`i'_tgtyr_trans)
   local next = `i' + 1
   qui replace ghg_tgt_bau`i'_tgtyr_trans = ghg_tgt_bau`next'_tgtyr_trans if imiss_tgtyr
   qui replace ghg_tgt_bau`next'_tgtyr_trans = . if imiss_tgtyr
}
}

*clean-up
drop imiss_bound_trans
drop imiss_tgtyr_trans





***********REORGANISING "ENERGY" TARGETS***********************************
*****bound*****
forval i=1/20{
tostring ghg_tgt_bau`i'_bound_ener, replace
}


forval i=1/20{
replace ghg_tgt_bau`i'_bound_ener="1" if regexm(ghg_tgt_bau`i'_bound_ener, "Same"+)
replace ghg_tgt_bau`i'_bound_ener="2" if regexm(ghg_tgt_bau`i'_bound_ener, "Larger"+)
replace ghg_tgt_bau`i'_bound_ener="3" if regexm(ghg_tgt_bau`i'_bound_ener, "Smaller"+)
replace ghg_tgt_bau`i'_bound_ener="4" if regexm(ghg_tgt_bau`i'_bound_ener, "Local Government Operations"+)
replace ghg_tgt_bau`i'_bound_ener="4" if regexm(ghg_tgt_bau`i'_bound_ener, "Administrative"+)
replace ghg_tgt_bau`i'_bound_ener="5" if regexm(ghg_tgt_bau`i'_bound_ener, "Partial"+)
}
forval i=1/20{
destring ghg_tgt_bau`i'_bound_ener, replace
}

********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound_ener = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound = missing(ghg_tgt_bau`i'_bound_ener)
   local next = `i' + 1
   qui replace ghg_tgt_bau`i'_bound_ener = ghg_tgt_bau`next'_bound_ener if imiss_bound
   qui replace ghg_tgt_bau`next'_bound_ener = . if imiss_bound
}
}

********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr_ener=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr = missing(ghg_tgt_bau`i'_tgtyr_ener)
   local next = `i' + 1
   qui replace ghg_tgt_bau`i'_tgtyr_ener = ghg_tgt_bau`next'_tgtyr_ener if imiss_tgtyr
   qui replace ghg_tgt_bau`next'_tgtyr_ener = . if imiss_tgtyr
}
}

*clean-up
drop imiss_bound_ener
drop imiss_tgtyr_ener




***********REORGANISING "WASTE" TARGETS***********************************
*****bound*****
forval i=1/20{
tostring ghg_tgt_bau`i'_bound_wast, replace
}

forval i=1/20{
replace ghg_tgt_bau`i'_bound_wast="1" if regexm(ghg_tgt_bau`i'_bound_wast, "Same"+)
replace ghg_tgt_bau`i'_bound_wast="2" if regexm(ghg_tgt_bau`i'_bound_wast, "Larger"+)
replace ghg_tgt_bau`i'_bound_wast="3" if regexm(ghg_tgt_bau`i'_bound_wast, "Smaller"+)
replace ghg_tgt_bau`i'_bound_wast="4" if regexm(ghg_tgt_bau`i'_bound_wast, "Local Government Operations"+)
replace ghg_tgt_bau`i'_bound_wast="4" if regexm(ghg_tgt_bau`i'_bound_wast, "Administrative"+)
replace ghg_tgt_bau`i'_bound_wast="5" if regexm(ghg_tgt_bau`i'_bound_wast, "Partial"+)
}
forval i=1/20{
destring ghg_tgt_bau`i'_bound_wast, replace
}

********bound - shifting values to the left-most empty columns********
qui gen byte imiss_bound_wast = .
local bound=20
forval  j = 1/`bound'  {  
local bound1 = `bound' - 1
forval i = 1/`bound1' {
   qui replace imiss_bound = missing(ghg_tgt_bau`i'_bound_wast)
   local next = `i' + 1
   qui replace ghg_tgt_bau`i'_bound_wast = ghg_tgt_bau`next'_bound_wast if imiss_bound
   qui replace ghg_tgt_bau`next'_bound_wast = . if imiss_bound
}
}

********tgtyr - shifting values to the left-most empty columns********
qui gen byte imiss_tgtyr_wast=.
local tgtyr=20
forval  j = 1/`tgtyr'  {  
local tgtyr1 = `tgtyr' - 1
forval i = 1/`tgtyr1' {
   qui replace imiss_tgtyr = missing(ghg_tgt_bau`i'_tgtyr_wast)
   local next = `i' + 1
   qui replace ghg_tgt_bau`i'_tgtyr_wast = ghg_tgt_bau`next'_tgtyr_wast if imiss_tgtyr
   qui replace ghg_tgt_bau`next'_tgtyr_wast = . if imiss_tgtyr
}
}

*clean-up
drop imiss_bound_wast
drop imiss_tgtyr_wast



*******************************************************************************************************************************
*****COUNT OF BASE YEAR SCENARIO (BUSINESS AS USUAL (BAU) TARGETS TARGETS BY CITY****************************** 
egen ghg_tgt_bau_all_total=rownonmiss( ghg_tgt_bau1_tgtyr_all- ghg_tgt_bau20_tgtyr_all)
*******************************************************************************************************************************


*Order all summary GHG targets*
order ghg_tgt_abs_all_total ghg_tgt_fxd_all_total ghg_tgt_int_all_total ghg_tgt_bau_all_total, last


*****INSTALL DROPMISS (dm89_1) - and must only use at end to cleabn up dataset****** PORBABLY DON'T NEED AS SUS_TGTS NOT USED
*Clean-up the columns with no responses (all missing) from all created ghg_tgt_ variables*
*dropmiss ghg_tgt_abs1_bound_all - ghg_tgt_bau_all_total , force





********************************************************************************
*****OPPORTUNITIES (Section 6, CDP questionnaire, all years)********************
********************************************************************************


******Opportunities your city has identified as a result of addressing cc
forval i=1/39{
tostring opp_`i', replace 
}

gen opp_ener_clean=0
gen opp_ener_effic=0
gen opp_energy=0
gen opp_sustrans=0
gen opp_agri=0
gen opp_incre_oppor=0
gen opp_dev_wast=0
gen opp_dev_circular=0
gen opp_dev_sus_food=0
gen opp_dev_clim_change=0
gen opp_dev_tourism=0
gen opp_add_fund=0
gen opp_dev_water=0
gen opp_dev_sus_constr=0
gen opp_inc_partner=0
gen opp_inc_invest=0
gen opp_inc_water_secur=0
gen opp_impr_flood=0
gen opp_ext_agri=0
gen opp_dev_res_manage=0
gen opp_incr_food_secur=0
gen opp_no_oppor=0
gen opp_carb_tax=0
gen opp_carbon_markt=0
gen opp_red_risk_hlth=0
gen opp_red_risk_capital=0
gen opp_municip=0
gen opp_other=0

egen opp_missing=rowmiss(opp_1)

forval i=1/39{
replace opp_ener_clean=1 if regexm(opp_`i', "Development of clean technology businesses")
replace opp_ener_clean=. if opp_missing==1
replace opp_sustrans=1 if regexm(opp_`i', "Development of sustainable transport sector")
replace opp_sustrans=. if opp_missing==1
replace opp_energy=1 if regexm(opp_`i', "Increased energy security")
replace opp_energy=. if opp_missing==1
replace opp_agri=1 if regexm(opp_`i', "Extended agricultural seasons")
replace opp_agri=. if opp_missing==1
replace opp_incre_oppor=1 if regexm(opp_`i', "Increase opportunities for trade (nationally or internationally)")
replace opp_incre_oppor=. if opp_missing==1
replace opp_dev_wast=1 if regexm(opp_`i', "Development of waste management-sector")
replace opp_dev_wast=. if opp_missing==1
replace opp_dev_circular=1 if regexm(opp_`i', "Development of circular economy models and businesses")
replace opp_dev_circular=. if opp_missing==1
replace opp_dev_sus_food=1 if regexm(opp_`i', "Development of local/sustainable food businesses")
replace opp_dev_sus_food=. if opp_missing==1
replace opp_dev_clim_change=1 if regexm(opp_`i', "Development of climate change resiliency projects")
replace opp_dev_clim_change=. if opp_missing==1
replace opp_dev_tourism=1 if regexm(opp_`i', "Development of tourism and eco-tourism sector")
replace opp_dev_tourism=. if opp_missing==1
replace opp_add_fund=1 if regexm(opp_`i', "Additional funding opportunities")
replace opp_add_fund=. if opp_missing==1
replace opp_dev_water=1 if regexm(opp_`i', "Development of water management sector")
replace opp_dev_water=. if opp_missing==1
replace opp_dev_sus_constr=1 if regexm(opp_`i', "Development of sustainable construction/real estate sector")
replace opp_dev_sus_constr=. if opp_missing==1
replace opp_inc_partner=1 if regexm(opp_`i', "Increase opportunities for partnerships")
replace opp_inc_partner=. if opp_missing==1
replace opp_inc_invest=1 if regexm(opp_`i', "Increased opportunities for investment in infrastructure projects")
replace opp_inc_invest=. if opp_missing==1
replace opp_inc_water_secur=1 if regexm(opp_`i', "Increased water security")
replace opp_inc_water_secur=. if opp_missing==1
replace opp_impr_flood=1 if regexm(opp_`i', "Improved flood risk mitigation") 
replace opp_impr_flood=. if opp_missing==1
replace opp_ext_agri=1 if regexm(opp_`i', "Extended agricultural seasons")
replace opp_ext_agri=. if opp_missing==1
replace opp_dev_res_manage=1 if regexm(opp_`i', "Development of resource conservation and management")
replace opp_dev_res_manage=. if opp_missing==1
replace opp_incr_food_secur=1 if regexm(opp_`i', "Increased food security")
replace opp_incr_food_secur=. if opp_missing==1
replace opp_no_oppor=1 if regexm(opp_`i', "No opportunities identified")
replace opp_no_oppor=. if opp_missing==1
replace opp_carb_tax=1 if regexm(opp_`i', "Carbon tax revenue")
replace opp_carb_tax=. if opp_missing==1
replace opp_carbon_markt=1 if regexm(opp_`i', "Creation/development of carbon markets")
replace opp_carbon_markt=. if opp_missing==1
replace opp_red_risk_hlth=1 if regexm(opp_`i', "Reduced risk to human health")
replace opp_red_risk_hlth=. if opp_missing==1
replace opp_red_risk_capital=1 if regexm(opp_`i', "Reduced risk to natural capital")
replace opp_red_risk_capital=. if opp_missing==1
replace opp_municip=1 if regexm(opp_`i', "Improved efficiency of municipal operations")
replace opp_municip=. if opp_missing==1
replace opp_other=1 if regexm(opp_`i', "Other, please specify"+)
replace opp_other=. if opp_missing==1
}
drop opp_missing



*********Collaborate with business in your city on sustainability project***************
label define oppcollab  1 "Yes"  2 "In progress" 3 "Intending to undertake in the next 2 years" 4 "Not intending to undertake"  999 "Do not know"
encode opp_collbz, label(oppcollab) generate( opp_collab_code )
order opp_collbz, before(opp_collab_code)
rename opp_collbz opp_collab




********************************************************************************
****************FINAL ORGANISATION, CLEANING, ORDERING**************************
********************************************************************************

*rename *_codes *
order accnum - i_city_bound, before( sus_tgt_emission )
keep accnum- opp_collab_code

save "`climcit'\cdp_2021_condensed", replace
clear







*********************************************************************************
*****Generate variables - CDP
*********************************************************************************


clear

*set directory (ADJUST AS NEEDED)
cd "C:\Users\Administrator\Desktop\CC_org" // ADJUST PATH NAME AS NEEDED

*local macro for path names
local climcit "C:\Users\Administrator\Desktop\CC_org" //ADJUST PATH NAME AS NEEDED

use "`climcit'\cdp_2021_condensed"


**Identify the sample for analysis
gen finalsample=.
recode finalsample (.=1) if covimpct_act_code!=. & covimpct_econ_code!=.
recode finalsample (.=0)


********************************MAIN VARIABLES***********************************

*DEPENDENT VARIABLES(all CDP variables)

**Impact of Covid-19 on climate actions (covimpct_act) - recoding "other" that should be classed as "increase"/"decrease"/"stay the same" (cdp 2021, q1.6)
generate covimpct_act_adj=covimpct_act_code
label define covcodes1 1 "Increased emphasis on climate action" 2 "Decreased emphasis on climate action" 3 "No change on emphasis on climate action" 4 "Other"
label values covimpct_act_adj covcodes1

replace covimpct_act_adj=1 if accnum==50383
replace covimpct_act_adj=1 if accnum==50560
replace covimpct_act_adj=1 if accnum==54109
replace covimpct_act_adj=1 if accnum==826446
replace covimpct_act_adj=2 if accnum==35905
replace covimpct_act_adj=3 if accnum==59572

label var   covimpct_act_adj  		"Impact of COVID on climate action in your city (adjusted)"

*Impact of Covid-19 on climate finance (covimpct_econ) - recoding "other" that should be classed as "increase"/"decrease"/"stay the same" (cdp 2021, q1.7)
generate covimpct_econ_adj=covimpct_econ_code
label define covcodes2 1 "Increased finance available for climate action" 2 "Reduced finance available for climate action" 3 "No change on finance available for climate action" 4 "Other"
label values covimpct_econ_adj covcodes2

replace covimpct_econ_adj=1 if accnum==50361
replace covimpct_econ_adj=2 if accnum==834157
replace covimpct_econ_adj=2 if accnum==62407

label var   covimpct_econ_adj  		"Impact of COVID on climate finance in your city (adjusted)"

**Synergies between covid recovery interventions and climate action ("green recovery") (cdp 2021, q1.7)
*count
generate cov_recov_TOTAL = covrecov_univers + covrecov_health + covrecov_wash + covrecov_employ + covrecov_greentrain + covrecov_justtrans + covrecov_sustfood + covrecov_susttransp + covrecov_internet + covrecov_tech + covrecov_greenspace + covrecov_other
label var   cov_recov_TOTAL  		"Total # of green recovery interventions in city"


*INDEPENDENT VARIABLES

**CDP - Climate-related health issues (cdp2021 q2.3a)
*count (adjusting for the fact that not everyone answered the filter question (q2.3))
egen ccimpct_hlth_iss_TOTAL = rowtotal( ccimpct_hlth_iss_heat- ccimpct_hlth_iss_other )
recode ccimpct_hlth_iss_TOTAL (0=.) if ccimpct_hlth_codes==.
label var ccimpct_hlth_iss_TOTAL "Total # of climate-related health issues faced by the city"
*binary - created from count (as  created above) -not used
gen ccimpct_hlth_iss_yes=.
recode ccimpct_hlth_iss_yes (.=0) if  ccimpct_hlth_iss_TOTAL==0
recode ccimpct_hlth_iss_yes (.=1) if  ccimpct_hlth_iss_TOTAL>0
recode ccimpct_hlth_iss_yes (1=.) if  ccimpct_hlth_iss_TOTAL==.


**CDP - Climate change hazards (MAIN, medium-high to high-prob hazards)
*count
egen cc_hazd_prob_TOTAL=rowtotal( cc_hazd_prob_precip - cc_hazd_prob_bio)
label var cc_hazd_prob_TOTAL "Total # medium-high to high-prob hazards in city"
*binary -not used
egen cc_hazd_prob_yes=anymatch( cc_hazd_prob_precip - cc_hazd_prob_bio), values(1) 
label var cc_hazd_prob_yes "Whether city has medium-high to high-prob climate hazards"



*CDP -Pre-2021 climate targets - INDICATOR OF WHETHER CITY HAD SHORT-TERM (PRE-2021) CLIMATE TARGET - INDICATOR OF AMBITION
*coding for pre-2021 target
gen ghg_tgt_all_2020tgtyr=.
forval i=1/20 {
recode  ghg_tgt_all_2020tgtyr .=1 if ghg_tgt_abs`i'_tgtyr_all<2021
recode  ghg_tgt_all_2020tgtyr .=1 if ghg_tgt_fxd`i'_tgtyr_all<2021
recode  ghg_tgt_all_2020tgtyr .=1 if ghg_tgt_int`i'_tgtyr_all<2021
recode  ghg_tgt_all_2020tgtyr .=1 if ghg_tgt_bau`i'_tgtyr_all<2021
}
recode ghg_tgt_all_2020tgtyr .=0

gen ghg_tgt_ener_2020tgtyr=.
forval i=1/20 {
recode  ghg_tgt_ener_2020tgtyr .=1 if ghg_tgt_abs`i'_tgtyr_ener<2021
recode  ghg_tgt_ener_2020tgtyr .=1 if ghg_tgt_fxd`i'_tgtyr_ener<2021
recode  ghg_tgt_ener_2020tgtyr .=1 if ghg_tgt_int`i'_tgtyr_ener<2021
recode  ghg_tgt_ener_2020tgtyr .=1 if ghg_tgt_bau`i'_tgtyr_ener<2021
}
recode ghg_tgt_ener_2020tgtyr .=0

gen ghg_tgt_trans_2020tgtyr=.
forval i=1/20 {
recode  ghg_tgt_trans_2020tgtyr .=1 if ghg_tgt_abs`i'_tgtyr_trans<2021
recode  ghg_tgt_trans_2020tgtyr .=1 if ghg_tgt_fxd`i'_tgtyr_trans<2021
recode  ghg_tgt_trans_2020tgtyr .=1 if ghg_tgt_int`i'_tgtyr_trans<2021
recode  ghg_tgt_trans_2020tgtyr .=1 if ghg_tgt_bau`i'_tgtyr_trans<2021
}
recode ghg_tgt_trans_2020tgtyr .=0

gen ghg_tgt_wast_2020tgtyr=.
forval i=1/20 {
recode  ghg_tgt_wast_2020tgtyr .=1 if ghg_tgt_abs`i'_tgtyr_wast<2021
recode  ghg_tgt_wast_2020tgtyr .=1 if ghg_tgt_fxd`i'_tgtyr_wast<2021
recode  ghg_tgt_wast_2020tgtyr .=1 if ghg_tgt_int`i'_tgtyr_wast<2021
recode  ghg_tgt_wast_2020tgtyr .=1 if ghg_tgt_bau`i'_tgtyr_wast<2021
}
recode ghg_tgt_wast_2020tgtyr .=0

egen ghg_tgt_allplussect_2020tgtyr=rowmax( ghg_tgt_all_2020tgtyr ghg_tgt_ener_2020tgtyr ghg_tgt_trans_2020tgtyr ghg_tgt_wast_2020tgtyr )

label var ghg_tgt_allplussect_2020tgtyr "Whether city has 2020 GHG target (overall or by sector)"


*CDP - Sustainability opportunities
*count
egen opp_TOTAL =rowtotal( opp_ener_clean - opp_other )
label var opp_TOTAL "Total # opportunities identified from addressing climate change"
*binary -not used
egen opp_yes =anymatch( opp_ener_clean - opp_other ), values(1)
label var opp_yes "City identified at least one opportunity from addressing climate change"


*CDP - Collaboration with business
*binary
gen opp_collab_yes = . 
recode opp_collab_yes (.=1) if opp_collab_code==1
recode opp_collab_yes (.=0) if opp_collab_code>1 & opp_collab_code!=.
order opp_collab_code, before(opp_collab_yes)
label var opp_collab_yes "Whether city collaborates with business on sustainability issues"
*count -not used
egen opp_collab_TOTAL=rowtotal( opp_collab_area_ener - opp_collab_area_fish)
label var opp_collab_TOTAL "Total number (areas of) collaboration with business"



*********************EXTRA VARIABLES FOR TESTS & SENSITIVITY ANALYSES***************************


***NO2 - Sensitivity analysis: coding for 2030 target
gen ghg_tgt_all_2030tgtyr=.
forval i=1/20 {
recode  ghg_tgt_all_2030tgtyr .=1 if ghg_tgt_abs`i'_tgtyr_all<2031
recode  ghg_tgt_all_2030tgtyr .=1 if ghg_tgt_fxd`i'_tgtyr_all<2031
recode  ghg_tgt_all_2030tgtyr .=1 if ghg_tgt_int`i'_tgtyr_all<2031
recode  ghg_tgt_all_2030tgtyr .=1 if ghg_tgt_bau`i'_tgtyr_all<2031
}
recode ghg_tgt_all_2030tgtyr .=0

gen ghg_tgt_ener_2030tgtyr=.
forval i=1/20 {
recode  ghg_tgt_ener_2030tgtyr .=1 if ghg_tgt_abs`i'_tgtyr_ener<2031
recode  ghg_tgt_ener_2030tgtyr .=1 if ghg_tgt_fxd`i'_tgtyr_ener<2031
recode  ghg_tgt_ener_2030tgtyr .=1 if ghg_tgt_int`i'_tgtyr_ener<2031
recode  ghg_tgt_ener_2030tgtyr .=1 if ghg_tgt_bau`i'_tgtyr_ener<2031
}
recode ghg_tgt_ener_2030tgtyr .=0

gen ghg_tgt_trans_2030tgtyr=.
forval i=1/20 {
recode  ghg_tgt_trans_2030tgtyr .=1 if ghg_tgt_abs`i'_tgtyr_trans<2031
recode  ghg_tgt_trans_2030tgtyr .=1 if ghg_tgt_fxd`i'_tgtyr_trans<2031
recode  ghg_tgt_trans_2030tgtyr .=1 if ghg_tgt_int`i'_tgtyr_trans<2031
recode  ghg_tgt_trans_2030tgtyr .=1 if ghg_tgt_bau`i'_tgtyr_trans<2031
}
recode ghg_tgt_trans_2030tgtyr .=0

gen ghg_tgt_wast_2030tgtyr=.
forval i=1/20 {
recode  ghg_tgt_wast_2030tgtyr .=1 if ghg_tgt_abs`i'_tgtyr_wast<2031
recode  ghg_tgt_wast_2030tgtyr .=1 if ghg_tgt_fxd`i'_tgtyr_wast<2031
recode  ghg_tgt_wast_2030tgtyr .=1 if ghg_tgt_int`i'_tgtyr_wast<2031
recode  ghg_tgt_wast_2030tgtyr .=1 if ghg_tgt_bau`i'_tgtyr_wast<2031
}
recode ghg_tgt_wast_2030tgtyr .=0

egen ghg_tgt_allplussect_2030tgtyr=rowmax( ghg_tgt_all_2030tgtyr ghg_tgt_ener_2030tgtyr ghg_tgt_trans_2030tgtyr ghg_tgt_wast_2030tgtyr )

label var ghg_tgt_allplussect_2020tgtyr "TEST VAR - Whether city has 2030 GHG target (overall or by sector)"

/*
**CDP - OPTIONAL - Climate change hazards (ALTERNATIVE OPERATIONALISATION #1, medium-high to high-magnitude hazards)
*count
egen cc_hazd_magn_TOTAL=rowtotal( cc_hazd_magn_precip - cc_hazd_magn_bio)
label var cc_hazd_magn_TOTAL "Total number medium-high to high-magnitude hazards in city"
*binary 
egen cc_hazd_magn_yes=anymatch( cc_hazd_magn_precip - cc_hazd_magn_bio), values(1) 
label var cc_hazd_magn_yes "Whether city has medium-high to high-magnitude climate hazards"
*/

/*
**CDP - OPTIONAL - Climate change hazards (ALTERNATIVE OPERATIONALISATION #2, all listed hazards)
*count
egen cc_hazd_TOTAL=rowtotal( cc_hazd_precip - cc_hazd_bio)
label var cc_hazd_TOTAL "Total number of hazards in city"
*binary  
egen cc_hazd_yes=anymatch( cc_hazd_precip - cc_hazd_bio), values(1) 
label var cc_hazd_yes "Whether city has any (of selected) climate hazard"
*/

*********************************************************************************
*FINAL
*********************************************************************************

keep if finalsample==1
order accnum- i_city_bound sus_tgt_emission_2021- sus_tgt_otherTEXT_2021 covimpct_act_code- covimpct_econ_otherTEXT covimpct_act_adj- covimpct_econ_decrease_adj covrecov_univers- covrecov_otherTEXT cov_recov_TOTAL cc_hazd_prob_precip - cc_hazd_prob_bio cc_hazd_prob_TOTAL ccimpct_hlth_iss_heat - ccimpct_hlth_iss_other ccimpct_hlth_iss_TOTAL ghg_tgt_all_2020tgtyr- ghg_tgt_allplussect_2030tgtyr opp_TOTAL opp_collab_yes
keep accnum - opp_collab_yes

*DROP ALL VARIABLES NOT USED IN FINAL ANALYSIS (optional; can retain for info and further testing)
drop covimpct_act_code covimpct_act_otherTEXT covimpct_act_dtail covimpct_act_code 
drop covimpct_econ_code covimpct_econ_otherTEXT
drop cc_hazd_prob_precip cc_hazd_prob_storm cc_hazd_prob_cold cc_hazd_prob_hot cc_hazd_prob_water cc_hazd_prob_fire cc_hazd_prob_flood cc_hazd_prob_chemical cc_hazd_prob_mass cc_hazd_prob_bio cc_hazd_prob_yes
drop ccimpct_hlth_iss_heat ccimpct_hlth_iss_vect ccimpct_hlth_iss_water ccimpct_hlth_iss_air ccimpct_hlth_iss_noncomm ccimpct_hlth_iss_mental ccimpct_hlth_iss_phy_inj ccimpct_hlth_iss_food ccimpct_hlth_iss_dis_water ccimpct_hlth_iss_dis_hlth ccimpct_hlth_iss_over_hlth ccimpct_hlth_iss_lack_clim ccimpct_hlth_iss_dam_hlth_infra ccimpct_hlth_iss_dis_hlth_serv ccimpct_hlth_iss_other ccimpct_hlth_iss_yes
drop ghg_tgt_all_2020tgtyr ghg_tgt_ener_2020tgtyr ghg_tgt_trans_2020tgtyr ghg_tgt_wast_2020tgtyr ghg_tgt_all_2030tgtyr ghg_tgt_ener_2030tgtyr ghg_tgt_trans_2030tgtyr ghg_tgt_wast_2030tgtyr 
drop opp_yes opp_collab_TOTAL
 
*save as new file name
save "`climcit'\cdp_2021_clean", replace
clear

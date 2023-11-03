***************************************************************************************************************
*TITLE:		
*PURPOSE:	CLEANING UP DATA FOR CLIMCITIES IMPACT PAPER
*AUTHORS:	Viktoriya Kuz & Tanya O'Garra 
****************************************************************************************************************

clear

*set directory (ADJUST AS NEEDED)
cd "C:\Users\Administrator\Desktop\CC_org" // ADJUST PATH NAME AS NEEDED

*local macro for path names
local climcit "C:\Users\Administrator\Desktop\CC_org" //ADJUST PATH NAME AS NEEDED

use "`climcit'\inputs\noncdp data.dta"


**NO2

*NO2 indicator selected based on correlations between buffers and boundaries, keep no2_bf25_mea_2019
*Continuous NO2 indicator - rescaled to quadrillions (2019 10^15) (Main)
generate no2_bf25_mea_2019_qd=no2_bf25_mea_2019/1000000000000000

****NO2 robustness tests
*1a. version a (3 categories)-- use instead of the regular variable NO2
generate no2_bf25_mea_2019_qd_cat=no2_bf25_mea_2019_qd
*no confidence
replace no2_bf25_mea_2019_qd_cat=0 if no2_bf25_mea_2019_qd<.8
*some confudence, not high pollution
replace no2_bf25_mea_2019_qd_cat=1 if no2_bf25_mea_2019_qd>.8 & no2_bf25_mea_2019_qd<5
*confidence, higher end of pollution 
replace no2_bf25_mea_2019_qd_cat=2 if no2_bf25_mea_2019_qd>5 

**OPTIONAL (additional) - commented out
*1b. version 1b (4 categories)-- not used in main as highest category underpopulated
*generate no2_bf25_mea_2019_qd_cat=no2_bf25_mea_2019_qd
*no confidence
*replace no2_bf25_mea_2019_qd_cat=0 if no2_bf25_mea_2019_qd<.8
*some confudence, not high pollution
*replace no2_bf25_mea_2019_qd_cat=1 if no2_bf25_mea_2019_qd>.8 & no2_bf25_mea_2019_qd<5
*confidence, higher end of pollution 
*replace no2_bf25_mea_2019_qd_cat=2 if no2_bf25_mea_2019_qd>5 & no2_bf25_mea_2019_qd<10
*highly polluted
*replace no2_bf25_mea_2019_qd_cat=3 if no2_bf25_mea_2019_qd>10 


*2. quality flag version b - include alongside regular no2
generate no2_bf25_mea_2019_qd_quality=no2_bf25_mea_2019_qd
*//unreliable
replace no2_bf25_mea_2019_qd_quality=0 if no2_bf25_mea_2019_qd<.8 
*// reliable 
replace no2_bf25_mea_2019_qd_quality=1 if no2_bf25_mea_2019_qd>.8 




****CLIMATE NETWORKS (ClimActor) 
*Count - based on most recent date there is data for
generate networks_total_overyears = climatemayors2020 + eucovenantofmayors2021 + gcomharmonized2021 + racetozero2020 + under2coalition2020
*Binary (main variable)
gen networks_yes=networks_total_overyear!=0

*organise
order climatemayors2020 eucovenantofmayors2021 gcomharmonized2021 racetozero2020 under2coalition2020, before(networks_total_overyear)



**NTL CHANGE(impact of Covid19 on economic activity)
*Change in NTL compared to a trend (Main)

*start: clean-up
*ntl_25bf - one city has "0" recorded ntl (accnum 834277) - so gen new vars with 50km buffer data swapped in for this city for each year
forval i =2015/2021 {
gen ntl_bf25_mea_`i'v2= ntl_bf25_mea_`i'
replace ntl_bf25_mea_`i'v2=ntl_bf50_mea_`i' if ntl_bf25_mea_`i'v2==0
label var ntl_bf25_mea_`i'v2 "Swapped zeros for bf50_mea value"
}

*Generate vars representing % change in NTL from year to year
gen ntl_bf25_mea_pcnt_15to16 = (ntl_bf25_mea_2016v2- ntl_bf25_mea_2015v2)/ ntl_bf25_mea_2015v2
gen ntl_bf25_mea_pcnt_16to17 = (ntl_bf25_mea_2017v2- ntl_bf25_mea_2016v2)/ ntl_bf25_mea_2016v2
gen ntl_bf25_mea_pcnt_17to18 = (ntl_bf25_mea_2018v2- ntl_bf25_mea_2017v2)/ ntl_bf25_mea_2017v2
gen ntl_bf25_mea_pcnt_18to19 = (ntl_bf25_mea_2019v2- ntl_bf25_mea_2018v2)/ ntl_bf25_mea_2018v2
gen ntl_bf25_mea_pcnt_19to20 = (ntl_bf25_mea_2020v2- ntl_bf25_mea_2019v2)/ ntl_bf25_mea_2019v2
gen ntl_bf25_mea_pcnt_20to21 = (ntl_bf25_mea_2021v2- ntl_bf25_mea_2020v2)/ ntl_bf25_mea_2020v2

*check change in ntl over time - (visually, can copy mean values into excel and plot as scatter, joined)
*graph bar (mean) ntl_bf25_mea_2015v2 ntl_bf25_mea_2016v2 ntl_bf25_mea_2017v2 ntl_bf25_mea_2018v2 ntl_bf25_mea_2019v2 ntl_bf25_mea_2020v2 ntl_bf25_mea_2021v2, blabel(bar)


*****NTL - calculate impact of C19 on NTL using all NTL 2015-2021 data
***1: predict 2020 counterfactual value - based on trend from 2015-2019
*1a. Gen var - average % change in ntl per year (per city)
egen ave_bf25_mea_pcnt_15to19 = rowmean( ntl_bf25_mea_pcnt_15to16 ntl_bf25_mea_pcnt_16to17 ntl_bf25_mea_pcnt_17to18 ntl_bf25_mea_pcnt_18to19 )

*1b. Gen var - predicted value for 2020 NTL (using average % change calcluated above)
gen ntl_bf25_mea_2020_predicted= ntl_bf25_mea_2019v2* (ave_bf25_mea_pcnt_15to19+1)
*NOTE: another approach might be to adjust the impact timing for different parts of the world according to when COVID-19 impact
*occurred, but on average, a histogram of NTL (radiance) from 2015-2021, show that 2020 exhibited the biggest & most notable decline)*

***2. Quantify difference between actual and predicted (counterfactual) 2020 NTLs
*2a. Gen var - difference between actual and predicted 2020 NTLs
gen ntl_bf25_mea_2020_impct = (ntl_bf25_mea_2020v2 - ntl_bf25_mea_2020_predicted)

*2b. Gen var - diff between actual and predicted as proprtion  
gen ntl_bf25_mea_2020_impct_pcnt= ntl_bf25_mea_2020_impct/ ntl_bf25_mea_2020_predicted

*2c. Gen var - diff between actual and predicted as % (percentage points)
gen ntl_bf25_mea_2020_impct_ppt= (ntl_bf25_mea_2020_impct/ ntl_bf25_mea_2020_predicted)*100
*Result - Operationalisation #1 of NTL change (ntl_bf25_mea_2020_impct_ppt) (MAIN) - (negative and positive modelled together - assumes linear effects)


*NTL - generating variables for robustness tests
**Operationalisation #2 (create THREE categories for % ntl change, using median of negative values to generate 2 cats, and only one cat for positive values
tabstat ntl_bf25_mea_2020_impct_pcnt, s(min max range)
tabstat ntl_bf25_mea_2020_impct_pcnt if ntl_bf25_mea_2020_impct_pcnt<0, s(q)
*now use the median value to create the categories for negatve values
gen ntl_2020_impct_cat=.
recode ntl_2020_impct_cat (.=1) if ntl_bf25_mea_2020_impct_pcnt<-.066544
recode ntl_2020_impct_cat (.=2) if ntl_bf25_mea_2020_impct_pcnt<0
recode ntl_2020_impct_cat (.=3)



*NTL pre-COVID-19
**based on correlations (and fix noted above), final version to use is: ntl_bf25_mea_2019v2
***log transformation needed for right-skewed data
gen logntl_bf25_mea_2019v2=ln( ntl_bf25_mea_2019v2 )
order ntl_bf25_mea_2019v2, before(logntl_bf25_mea_2019v2)

*clean up
drop ntl_bf25_mea_2015v2- ntl_bf25_mea_2020_predicted



**COVID-19 deaths
order total_deaths_per_million_20_21, last
*****rescale (deaths per thousand)
generate total_deaths_20_21_pth = total_deaths_per_million_20_21/1000



**Government response to Covid (Oxford tracker)
order gvmt_response_index, last
rename gvmt_response_index gvmt_response_index_ppt
gen gvmt_response_index_pct = gvmt_response_index_ppt/100


**Population density
**based on correlations, final version to use is: popden_bf25_max
order popden_bf25_max, last
generate popden_bf25_max_div10000 = popden_bf25_max/10000



**National GDP (pre-COVID-19) - log transformation to reduce extreme right skew (or outlier issue)
order gdp_country_2019, last
gen loggdp_country_2019=ln( gdp_country_2019)


*****V2 lib dem
order v2x_libdem_new, last
rename v2x_libdem_new v2x_libdem_new_pct 
generate v2x_libdem_new_ppt = v2x_libdem_new_pct*100



***************************
*****FINAL
***************************
keep accnum- bound_admin_data no2_bf25_mea_2019_qd- v2x_libdem_new_ppt

*DROP ANY REDUCNDANT VARIABLES NOT SUED IN ANALYSIS
drop ntl_bf25_mea_2020_impct ntl_bf25_mea_2020_impct_pcnt ntl_bf25_mea_2019v2 total_deaths_per_million_20_21 gvmt_response_index_pct popden_bf25_max gdp_country_2019 v2x_libdem_new_pct

*save as new clean non-cdp file (to be merged with clean cdp file)
save "`climcit'\non-cdp_final",replace
clear

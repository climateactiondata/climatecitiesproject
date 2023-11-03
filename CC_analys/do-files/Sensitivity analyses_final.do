*********************************************************************
*Title		: Sensitivity Regressions and Tests
*Purpose	: Run regressions for sensitivity models
*Author		: Viktoriya Kuz and Tanya O'Garra
*********************************************************************

use "C:\Users\Administrator\Desktop\CLIMCITIES\ClimCitesData"

*set directory (ADJUST AS NEEDED)
cd "C:\Users\Administrator\Desktop\CLIMCITIES"


**MAIN REGS
local covimpct101 ccimpct_hlth_iss_TOTAL cc_hazd_prob_TOTAL no2_bf25_mea_2019_qd networks_yes ghg_tgt_allplussect_2020tgtyr opp_collab_yes opp_TOTAL ntl_bf25_mea_2020_impct_ppt total_deaths_20_21_pth gvmt_response_index_ppt popden_bf25_max_div10000 logntl_bf25_mea_2019v2 loggdp_country_2019 v2x_libdem_new_ppt

{
//ACT
gsem (1.covimpct_act_adj <- `covimpct101' M1[country]@1) (2.covimpct_act_adj <- `covimpct101' M1[country]@1) (4.covimpct_act_adj <- `covimpct101' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(1.covimpct_act_adj))
est sto gsemact_1
gsem (1.covimpct_act_adj <- `covimpct101' M1[country]@1) (2.covimpct_act_adj <- `covimpct101' M1[country]@1) (4.covimpct_act_adj <- `covimpct101' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_act_adj))
est sto gsemact_2
gsem (1.covimpct_act_adj <- `covimpct101' M1[country]@1) (2.covimpct_act_adj <- `covimpct101' M1[country]@1) (4.covimpct_act_adj <- `covimpct101' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_act_adj))
est sto gsemact_3
gsem (1.covimpct_act_adj <- `covimpct101' M1[country]@1) (2.covimpct_act_adj <- `covimpct101' M1[country]@1) (4.covimpct_act_adj <- `covimpct101' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_act_adj))
est sto gsemact_4
}

//ECON
{
gsem (1.covimpct_econ_adj <- `covimpct101' M1[country]@1) (2.covimpct_econ_adj <- `covimpct101' M1[country]@1) (4.covimpct_econ_adj <- `covimpct101' M1[country]@1), mlogit
estpost margins, dydx(*) predict(pr outcome(1.covimpct_econ_adj))
est sto gsemecon_1
gsem (1.covimpct_econ_adj <- `covimpct101' M1[country]@1) (2.covimpct_econ_adj <- `covimpct101' M1[country]@1) (4.covimpct_econ_adj <- `covimpct101' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_econ_adj))
est sto gsemecon_2
gsem (1.covimpct_econ_adj <- `covimpct101' M1[country]@1) (2.covimpct_econ_adj <- `covimpct101' M1[country]@1) (4.covimpct_econ_adj <- `covimpct101' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_econ_adj))
est sto gsemecon_3
gsem (1.covimpct_econ_adj <- `covimpct101' M1[country]@1) (2.covimpct_econ_adj <- `covimpct101' M1[country]@1) (4.covimpct_econ_adj <- `covimpct101' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_econ_adj))
est sto gsemecon_4
}

//GREEN RECOVERY
{
gsem (cov_recov_TOTAL <- `covimpct101' M1[country]@1), nbreg 
estpost margins, dydx(*) 
est sto gsemnbreg_covrecov1_marg
}

*********************************************************************
**** SUPPLEMENTARY REGRESSIONS, SENSITIVTY ANALYSES****
*********************************************************************
*Supplementary models variables
tabstat no2_bf25_mea_2019_qd_3cat no2_bf25_mea_2019_qd_quality climatemayors2020 eucovenantofmayors2021 gcomharmonized2021 racetozero2020 under2coalition2020 ntl_2020_impct_cat  ghg_tgt_allplussect_2030tgtyr policies_cat_rating_cat, stat(n min mean med max sd) col(stat) varwidth(35)


											
**** 1. NO2 - TWO TESTS
*1a. CATEGORICAL NO2 - 3 categories
local testcatno2 ccimpct_hlth_iss_TOTAL cc_hazd_prob_TOTAL i.no2_bf25_mea_2019_qd_3cat networks_yes ghg_tgt_allplussect_2020tgtyr opp_collab_yes opp_TOTAL ntl_bf25_mea_2020_impct_ppt total_deaths_20_21_pth gvmt_response_index_ppt popden_bf25_max_div10000 logntl_bf25_mea_2019v2 loggdp_country_2019 v2x_libdem_new_ppt

//ACT
{
gsem (1.covimpct_act_adj <- `testcatno2' M1[country]@1) (2.covimpct_act_adj <- `testcatno2' M1[country]@1) (4.covimpct_act_adj <- `testcatno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(1.covimpct_act_adj))
est sto gsemactcatno2_1
gsem (1.covimpct_act_adj <- `testcatno2' M1[country]@1) (2.covimpct_act_adj <- `testcatno2' M1[country]@1) (4.covimpct_act_adj <- `testcatno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_act_adj))
est sto gsemactcatno2_2
gsem (1.covimpct_act_adj <- `testcatno2' M1[country]@1) (2.covimpct_act_adj <- `testcatno2' M1[country]@1) (4.covimpct_act_adj <- `testcatno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_act_adj))
est sto gsemactcatno2_3
gsem (1.covimpct_act_adj <- `testcatno2' M1[country]@1) (2.covimpct_act_adj <- `testcatno2' M1[country]@1) (4.covimpct_act_adj <- `testcatno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_act_adj))
est sto gsemactcatno2_4
}

//ECON
{
gsem (1.covimpct_econ_adj <- `testcatno2' M1[country]@1) (2.covimpct_econ_adj <- `testcatno2' M1[country]@1) (4.covimpct_econ_adj <- `testcatno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(1.covimpct_econ_adj))
est sto gsemeconcatno2_1
gsem (1.covimpct_econ_adj <- `testcatno2' M1[country]@1) (2.covimpct_econ_adj <- `testcatno2' M1[country]@1) (4.covimpct_econ_adj <- `testcatno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_econ_adj))
est sto gsemeconcatno2_2
gsem (1.covimpct_econ_adj <- `testcatno2' M1[country]@1) (2.covimpct_econ_adj <- `testcatno2' M1[country]@1) (4.covimpct_econ_adj <- `testcatno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_econ_adj))
est sto gsemeconcatno2_3
gsem (1.covimpct_econ_adj <- `testcatno2' M1[country]@1) (2.covimpct_econ_adj <- `testcatno2' M1[country]@1) (4.covimpct_econ_adj <- `testcatno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_econ_adj))
est sto gsemeconcatno2_4
}

//GREEN RECOVERY
{
gsem (cov_recov_TOTAL <- `testcatno2' M1[country]@1) , nbreg 
estpost margins, dydx(*) 
est sto covrecov1_testcatno2
}

* 1b. NO2 QUALITY FLAG
local testqualno2 ccimpct_hlth_iss_TOTAL cc_hazd_prob_TOTAL no2_bf25_mea_2019_qd i.no2_bf25_mea_2019_qd_quality networks_yes ghg_tgt_allplussect_2020tgtyr opp_collab_yes opp_TOTAL ntl_bf25_mea_2020_impct_ppt total_deaths_20_21_pth gvmt_response_index_ppt popden_bf25_max_div10000 logntl_bf25_mea_2019v2 loggdp_country_2019 v2x_libdem_new_ppt

//ACT
{
gsem (1.covimpct_act_adj <- `testqualno2' M1[country]@1) (2.covimpct_act_adj <- `testqualno2' M1[country]@1) (4.covimpct_act_adj <- `testqualno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(1.covimpct_act_adj))
est sto gsemactqualno2_1
gsem (1.covimpct_act_adj <- `testqualno2' M1[country]@1) (2.covimpct_act_adj <- `testqualno2' M1[country]@1) (4.covimpct_act_adj <- `testqualno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_act_adj))
est sto gsemactqualno2_2
gsem (1.covimpct_act_adj <- `testqualno2' M1[country]@1) (2.covimpct_act_adj <- `testqualno2' M1[country]@1) (4.covimpct_act_adj <- `testqualno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_act_adj))
est sto gsemactqualno2_3
gsem (1.covimpct_act_adj <- `testqualno2' M1[country]@1) (2.covimpct_act_adj <- `testqualno2' M1[country]@1) (4.covimpct_act_adj <- `testqualno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_act_adj))
est sto gsemactqualno2_4
}

//ECON
{
gsem (1.covimpct_econ_adj <- `testqualno2' M1[country]@1) (2.covimpct_econ_adj <- `testqualno2' M1[country]@1) (4.covimpct_econ_adj <- `testqualno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(1.covimpct_econ_adj))
est sto gsemeconqualno2_1
gsem (1.covimpct_econ_adj <- `testqualno2' M1[country]@1) (2.covimpct_econ_adj <- `testqualno2' M1[country]@1) (4.covimpct_econ_adj <- `testqualno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_econ_adj))
est sto gsemeconqualno2_2
gsem (1.covimpct_econ_adj <- `testqualno2' M1[country]@1) (2.covimpct_econ_adj <- `testqualno2' M1[country]@1) (4.covimpct_econ_adj <- `testqualno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_econ_adj))
est sto gsemeconqualno2_3
gsem (1.covimpct_econ_adj <- `testqualno2' M1[country]@1) (2.covimpct_econ_adj <- `testqualno2' M1[country]@1) (4.covimpct_econ_adj <- `testqualno2' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_econ_adj))
est sto gsemeconqualno2_4
}

//GREEN RECOVERY
{
gsem (cov_recov_TOTAL <- `testqualno2' M1[country]@1) , nbreg 
estpost margins, dydx(*) 
est sto covrecov1_testqualno2
}




**** 2. NETWORKS - BINARY VERSUS CONTINUOUS

local testnetworks ccimpct_hlth_iss_TOTAL cc_hazd_prob_TOTAL no2_bf25_mea_2019_qd i.climatemayors2020 i.eucovenantofmayors2021 i.gcomharmonized2021 i.racetozero2020 i.under2coalition2020  ghg_tgt_allplussect_2020tgtyr opp_collab_yes opp_TOTAL ntl_bf25_mea_2020_impct_ppt total_deaths_20_21_pth gvmt_response_index_ppt popden_bf25_max_div10000 logntl_bf25_mea_2019v2 loggdp_country_2019 v2x_libdem_new_ppt

//ACT
{
gsem (1.covimpct_act_adj <- `testnetworks' M1[country]@1) (2.covimpct_act_adj <- `testnetworks' M1[country]@1) (4.covimpct_act_adj <- `testnetworks' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(1.covimpct_act_adj))
est sto gsemactnetworks_1
gsem (1.covimpct_act_adj <- `testnetworks' M1[country]@1) (2.covimpct_act_adj <- `testnetworks' M1[country]@1) (4.covimpct_act_adj <- `testnetworks' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_act_adj))
est sto gsemactnetworks_2
gsem (1.covimpct_act_adj <- `testnetworks' M1[country]@1) (2.covimpct_act_adj <- `testnetworks' M1[country]@1) (4.covimpct_act_adj <- `testnetworks' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_act_adj))
est sto gsemactnetworks_3
gsem (1.covimpct_act_adj <- `testnetworks' M1[country]@1) (2.covimpct_act_adj <- `testnetworks' M1[country]@1) (4.covimpct_act_adj <- `testnetworks' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_act_adj))
est sto gsemactnetworks_4
}

//ECON
{
gsem (1.covimpct_econ_adj <- `testnetworks' M1[country]@1) (2.covimpct_econ_adj <- `testnetworks' M1[country]@1) (4.covimpct_econ_adj <- `testnetworks' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(1.covimpct_econ_adj))
est sto gsemeconnetworks_1
gsem (1.covimpct_econ_adj <- `testnetworks' M1[country]@1) (2.covimpct_econ_adj <- `testnetworks' M1[country]@1) (4.covimpct_econ_adj <- `testnetworks' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_econ_adj))
est sto gsemeconnetworks_2
gsem (1.covimpct_econ_adj <- `testnetworks' M1[country]@1) (2.covimpct_econ_adj <- `testnetworks' M1[country]@1) (4.covimpct_econ_adj <- `testnetworks' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_econ_adj))
est sto gsemeconnetworks_3
gsem (1.covimpct_econ_adj <- `testnetworks' M1[country]@1) (2.covimpct_econ_adj <- `testnetworks' M1[country]@1) (4.covimpct_econ_adj <- `testnetworks' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_econ_adj))
est sto gsemeconnetworks_4
}

//GREEN RECOVERY
{
gsem (cov_recov_TOTAL <- `testnetworks' M1[country]@1) , nbreg 
estpost margins, dydx(*) 
est sto covrecov1_testnetworks
}




**** 3. NTL - 
*NTL 3 cats: 2 categories for negative values, based on median of Neg values, 1 cat for positive values) 
local testntlv1 ccimpct_hlth_iss_TOTAL cc_hazd_prob_TOTAL no2_bf25_mea_2019_qd networks_yes ghg_tgt_allplussect_2020tgtyr opp_collab_yes opp_TOTAL ib1.ntl_2020_impct_cat total_deaths_20_21_pth gvmt_response_index_ppt popden_bf25_max_div10000 logntl_bf25_mea_2019v2 loggdp_country_2019 v2x_libdem_new_ppt

//ACT
{
gsem (1.covimpct_act_adj <- `testntlv1' M1[country]@1) (2.covimpct_act_adj <- `testntlv1' M1[country]@1) (4.covimpct_act_adj <- `testntlv1' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(1.covimpct_act_adj))
est sto gsemactntlv1_1
gsem (1.covimpct_act_adj <- `testntlv1' M1[country]@1) (2.covimpct_act_adj <- `testntlv1' M1[country]@1) (4.covimpct_act_adj <- `testntlv1' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_act_adj))
est sto gsemactntlv1_2
gsem (1.covimpct_act_adj <- `testntlv1' M1[country]@1) (2.covimpct_act_adj <- `testntlv1' M1[country]@1) (4.covimpct_act_adj <- `testntlv1' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_act_adj))
est sto gsemactntlv1_3
gsem (1.covimpct_act_adj <- `testntlv1' M1[country]@1) (2.covimpct_act_adj <- `testntlv1' M1[country]@1) (4.covimpct_act_adj <- `testntlv1' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_act_adj))
est sto gsemactntlv1_4
}

//ECON
{
gsem (1.covimpct_econ_adj <- `testntlv1' M1[country]@1) (2.covimpct_econ_adj <- `testntlv1' M1[country]@1) (4.covimpct_econ_adj <- `testntlv1' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(1.covimpct_econ_adj))
est sto gsemeconntlv1_1
gsem (1.covimpct_econ_adj <- `testntlv1' M1[country]@1) (2.covimpct_econ_adj <- `testntlv1' M1[country]@1) (4.covimpct_econ_adj <- `testntlv1' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_econ_adj))
est sto gsemeconntlv1_2
gsem (1.covimpct_econ_adj <- `testntlv1' M1[country]@1) (2.covimpct_econ_adj <- `testntlv1' M1[country]@1) (4.covimpct_econ_adj <- `testCAT'v1 M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_econ_adj))
est sto gsemeconntlv1_3
gsem (1.covimpct_econ_adj <- `testntlv1' M1[country]@1) (2.covimpct_econ_adj <- `testntlv1' M1[country]@1) (4.covimpct_econ_adj <- `testntlv1' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_econ_adj))
est sto gsemeconntlv1_4
}

//GREEN RECOVERY
{
gsem (cov_recov_TOTAL <- `testntlv1' M1[country]@1) , nbreg 
estpost margins, dydx(*) 
est sto covrecov1_testntlv1
}


**** 4. SUSTAINABILITY TARGETS 
* using 2030 cut-off date (ghg_tgt_allplussect_2030tgtyr)

local testsustgt30 ccimpct_hlth_iss_TOTAL cc_hazd_prob_TOTAL no2_bf25_mea_2019_qd networks_yes ghg_tgt_allplussect_2030tgtyr opp_collab_yes opp_TOTAL ntl_bf25_mea_2020_impct_ppt total_deaths_20_21_pth gvmt_response_index_ppt popden_bf25_max_div10000 logntl_bf25_mea_2019v2 loggdp_country_2019 v2x_libdem_new_ppt

//ACT
{
gsem (1.covimpct_act_adj <- `testsustgt30' M1[country]@1) (2.covimpct_act_adj <- `testsustgt30' M1[country]@1) (4.covimpct_act_adj <- `testsustgt30' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(1.covimpct_act_adj))
est sto gsemactsustgt30_1
gsem (1.covimpct_act_adj <- `testsustgt30' M1[country]@1) (2.covimpct_act_adj <- `testsustgt30' M1[country]@1) (4.covimpct_act_adj <- `testsustgt30' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_act_adj))
est sto gsemactsustgt30_2
gsem (1.covimpct_act_adj <- `testsustgt30' M1[country]@1) (2.covimpct_act_adj <- `testsustgt30' M1[country]@1) (4.covimpct_act_adj <- `testsustgt30' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_act_adj))
est sto gsemactsustgt30_3
gsem (1.covimpct_act_adj <- `testsustgt30' M1[country]@1) (2.covimpct_act_adj <- `testsustgt30' M1[country]@1) (4.covimpct_act_adj <- `testsustgt30' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_act_adj))
est sto gsemactsustgt30_4
}

//ECON
{
gsem (1.covimpct_econ_adj <- `testsustgt30' M1[country]@1) (2.covimpct_econ_adj <- `testsustgt30' M1[country]@1) (4.covimpct_econ_adj <- `testsustgt30' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(1.covimpct_econ_adj))
est sto gsemeconsustgt30_1
gsem (1.covimpct_econ_adj <- `testsustgt30' M1[country]@1) (2.covimpct_econ_adj <- `testsustgt30' M1[country]@1) (4.covimpct_econ_adj <- `testsustgt30' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_econ_adj))
est sto gsemeconsustgt30_2
gsem (1.covimpct_econ_adj <- `testsustgt30' M1[country]@1) (2.covimpct_econ_adj <- `testsustgt30' M1[country]@1) (4.covimpct_econ_adj <- `testsustgt30' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_econ_adj))
est sto gsemeconsustgt30_3
gsem (1.covimpct_econ_adj <- `testsustgt30' M1[country]@1) (2.covimpct_econ_adj <- `testsustgt30' M1[country]@1) (4.covimpct_econ_adj <- `testsustgt30' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_econ_adj))
est sto gsemeconsustgt30_4
}

//GREEN RECOVERY
{
gsem (cov_recov_TOTAL <- `testsustgt30' M1[country]@1) , nbreg 
estpost margins, dydx(*) 
est sto covrecov1_testsustgt30
}


**** 5. CAT - include climate policy rating
local testCAT ccimpct_hlth_iss_TOTAL cc_hazd_prob_TOTAL no2_bf25_mea_2019_qd networks_yes ghg_tgt_allplussect_2020tgtyr opp_collab_yes opp_TOTAL ntl_bf25_mea_2020_impct_ppt total_deaths_20_21_pth gvmt_response_index_ppt popden_bf25_max_div10000 logntl_bf25_mea_2019v2 loggdp_country_2019 v2x_libdem_new_ppt ib3.policies_cat_rating_cat

//ACT
{
gsem (1.covimpct_act_adj <- `testCAT' M1[country]@1) (2.covimpct_act_adj <- `testCAT' M1[country]@1) (4.covimpct_act_adj <- `testCAT' M1[country]@1), mlogit 
* to create a variable that identifies the observations used in the testCAT sensitivity for the next sensitivity (main regression using only n=538 observations that have a value for the CAT rating), run the line below
gen byte usedcat=e(sample)

estpost margins, dydx(*) predict(pr outcome(1.covimpct_act_adj))
est sto gsemactCAT_1
gsem (1.covimpct_act_adj <- `testCAT' M1[country]@1) (2.covimpct_act_adj <- `testCAT' M1[country]@1) (4.covimpct_act_adj <- `testCAT' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_act_adj))
est sto gsemactCAT_2
gsem (1.covimpct_act_adj <- `testCAT' M1[country]@1) (2.covimpct_act_adj <- `testCAT' M1[country]@1) (4.covimpct_act_adj <- `testCAT' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_act_adj))
est sto gsemactCAT_3
gsem (1.covimpct_act_adj <- `testCAT' M1[country]@1) (2.covimpct_act_adj <- `testCAT' M1[country]@1) (4.covimpct_act_adj <- `testCAT' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_act_adj))
est sto gsemactCAT_4
}

//ECON --- after each gsem regression run below, you will likely see the error "convergence not achieved, r(430);". Continue to run the "estpost margins" code under each, you will still obtain results.
{
gsem (1.covimpct_econ_adj <- `testCAT' M1[country]@1) (2.covimpct_econ_adj <- `testCAT' M1[country]@1) (4.covimpct_econ_adj <- `testCAT' M1[country]@1), mlogit
estpost margins, dydx(*) predict(pr outcome(1.covimpct_econ_adj))
est sto gsemeconCAT_1
gsem (1.covimpct_econ_adj <- `testCAT' M1[country]@1) (2.covimpct_econ_adj <- `testCAT' M1[country]@1) (4.covimpct_econ_adj <- `testCAT' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_econ_adj))
est sto gsemeconCAT_2
gsem (1.covimpct_econ_adj <- `testCAT' M1[country]@1) (2.covimpct_econ_adj <- `testCAT' M1[country]@1) (4.covimpct_econ_adj <- `testCAT' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_econ_adj))
est sto gsemeconCAT_3
gsem (1.covimpct_econ_adj <- `testCAT' M1[country]@1) (2.covimpct_econ_adj <- `testCAT' M1[country]@1) (4.covimpct_econ_adj <- `testCAT' M1[country]@1), mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_econ_adj))
est sto gsemeconCAT_4
}

//GREEN RECOVERY
{
gsem (cov_recov_TOTAL <- `testCAT' M1[country]@1) , nbreg 
estpost margins, dydx(*) 
est sto covrecov1_testCAT
}

**** 6. Main regression sensitivity for CAT policies, n=538

local covimpct101 ccimpct_hlth_iss_TOTAL cc_hazd_prob_TOTAL no2_bf25_mea_2019_qd networks_yes ghg_tgt_allplussect_2020tgtyr opp_collab_yes opp_TOTAL ntl_bf25_mea_2020_impct_ppt total_deaths_20_21_pth gvmt_response_index_ppt popden_bf25_max_div10000 logntl_bf25_mea_2019v2 loggdp_country_2019 v2x_libdem_new_ppt

{
//ACT
gsem (1.covimpct_act_adj <- `covimpct101' M1[country]@1) (2.covimpct_act_adj <- `covimpct101' M1[country]@1) (4.covimpct_act_adj <- `covimpct101' M1[country]@1) if usedcat, mlogit 
estpost margins, dydx(*) predict(pr outcome(1.covimpct_act_adj))
est sto gsemact538_1
gsem (1.covimpct_act_adj <- `covimpct101' M1[country]@1) (2.covimpct_act_adj <- `covimpct101' M1[country]@1) (4.covimpct_act_adj <- `covimpct101' M1[country]@1) if usedcat, mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_act_adj))
est sto gsemact538_2
gsem (1.covimpct_act_adj <- `covimpct101' M1[country]@1) (2.covimpct_act_adj <- `covimpct101' M1[country]@1) (4.covimpct_act_adj <- `covimpct101' M1[country]@1) if usedcat, mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_act_adj))
est sto gsemact538_3
gsem (1.covimpct_act_adj <- `covimpct101' M1[country]@1) (2.covimpct_act_adj <- `covimpct101' M1[country]@1) (4.covimpct_act_adj <- `covimpct101' M1[country]@1) if usedcat, mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_act_adj))
est sto gsemact538_4
}

//ECON
{
gsem (1.covimpct_econ_adj <- `covimpct101' M1[country]@1) (2.covimpct_econ_adj <- `covimpct101' M1[country]@1) (4.covimpct_econ_adj <- `covimpct101' M1[country]@1) if usedcat, mlogit
estpost margins, dydx(*) predict(pr outcome(1.covimpct_econ_adj))
est sto gsemecon538_1
gsem (1.covimpct_econ_adj <- `covimpct101' M1[country]@1) (2.covimpct_econ_adj <- `covimpct101' M1[country]@1) (4.covimpct_econ_adj <- `covimpct101' M1[country]@1) if usedcat, mlogit 
estpost margins, dydx(*) predict(pr outcome(2.covimpct_econ_adj))
est sto gsemecon538_2
gsem (1.covimpct_econ_adj <- `covimpct101' M1[country]@1) (2.covimpct_econ_adj <- `covimpct101' M1[country]@1) (4.covimpct_econ_adj <- `covimpct101' M1[country]@1) if usedcat, mlogit 
estpost margins, dydx(*) predict(pr outcome(3.covimpct_econ_adj))
est sto gsemecon538_3
gsem (1.covimpct_econ_adj <- `covimpct101' M1[country]@1) (2.covimpct_econ_adj <- `covimpct101' M1[country]@1) (4.covimpct_econ_adj <- `covimpct101' M1[country]@1) if usedcat, mlogit 
estpost margins, dydx(*) predict(pr outcome(4.covimpct_econ_adj))
est sto gsemecon538_4
}

{
gsem (cov_recov_TOTAL <- `covimpct101' M1[country]@1) if usedcat, nbreg 
estpost margins, dydx(*) 
est sto covrecov1_538cat
}


***********************************END OF ROBUSTNESS TESTS***************************************



* MARGINS ESTTAB - output results

//with standard errors

esttab gsemact_1 	gsemactcatno2_1 	gsemactqualno2_1      gsemactnetworks_1		gsemactntlv1_1      gsemactsustgt30_1   	gsemactCAT_1 		gsemact538_1      using gsemACTsupplements.csv, replace eqlabels(none) nobaselevels nogap mlabel("gsemact" "gsemactcatno2" "gsemactqualno2" "gsemactnetworks" "gsemactntlv1" "gsemactsustgt30"  "gsemactCAT" "gsemact538", lhs("Outcome `i'")) b(3) se(3) compress nogap star(* 0.10 ** 0.05 *** 0.01)

forval i=2/4{
esttab gsemact_`i' 	gsemactcatno2_`i' 	gsemactqualno2_`i'		gsemactnetworks_`i' 	gsemactntlv1_`i'	gsemactsustgt30_`i'		gsemactCAT_`i' 	gsemact538_`i' 	using gsemACTsupplements.csv ,append eqlabels(nolabel) b(3) se(3) compress nogap nobaselevels mlabel("gsemact" "gsemactcatno2" "gsemactqualno2" "gsemactnetworks" "gsemactntlv1" "gsemactsustgt30" "gsemactCAT" "gsemact538", lhs("Outcome `i'")) star(* 0.10 ** 0.05 *** 0.01)
}

esttab gsemecon_1 	gsemeconcatno2_1 	gsemeconqualno2_1      gsemeconnetworks_1		gsemeconntlv1_1      gsemeconsustgt30_1    		gsemeconCAT_1 		gsemecon538_1      using gsemECONsupplements.csv, replace eqlabels(none) nobaselevels nogap mlabel("gsemecon" "gsemeconcatno2" "gsemeconqualno2" "gsemeconnetworks" "gsemeconntlv1" "gsemeconsustgt30"  "gsemeconCAT" "gsemecon538", lhs("Outcome `i'")) b(3) se(3) compress nogap star(* 0.10 ** 0.05 *** 0.01)

forval i=2/4{
esttab gsemecon_`i' 	gsemeconcatno2_`i' 	gsemeconqualno2_`i'		gsemeconnetworks_`i' 	gsemeconntlv1_`i'	gsemeconsustgt30_`i' 	gsemeconCAT_`i' 	gsemecon538_`i' 	using gsemECONsupplements.csv ,append eqlabels(nolabel) b(3) se(3) compress nogap nobaselevels mlabel("gsemecon" "gsemeconcatno2" "gsemeconqualno2" "gsemeconnetworks" "gsemeconntlv1" "gsemeconsustgt30"   "gsemeconCAT" "gsemecon538", lhs("Outcome `i'")) star(* 0.10 ** 0.05 *** 0.01)
}

esttab gsemnbreg_covrecov1_marg 	covrecov1_testcatno2 	covrecov1_testqualno2      covrecov1_testnetworks		covrecov1_testntlv1      covrecov1_testsustgt30 	   		covrecov1_testCAT 		covrecov1_538cat    using gsemNBREGsupp.csv, replace eqlabels(none) nobaselevels nogap mlabel("gsemnbreg_covrecov1_marg" "covrecov1_testcatno2" "covrecov1_testqualno2" "covrecov1_testnetworks" "covrecov1_testntlv1" "covrecov1_testsustgt30" "covrecov1_testCAT" "covrecov1_538cat", lhs("Outcome `i'")) b(3) se(3) compress nogap star(* 0.10 ** 0.05 *** 0.01)

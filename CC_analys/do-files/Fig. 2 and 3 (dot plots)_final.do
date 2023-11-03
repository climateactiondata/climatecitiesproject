*********************************************************************
*Title		: Main Dot Plots (Fig. 2 and 3, main text)
*Purpose	: Produce Dot Plots for Main Models
*Author		: Tanya O'Garra & Viktoriya Kuz
*********************************************************************

*install coefplot
ssc install coefplot 

***if coefplot not producing @pval (command line, then install latest update properly like this:
ssc install coefplot, replace

*set local macro
local covimpct101 ccimpct_hlth_iss_TOTAL cc_hazd_prob_TOTAL no2_bf25_mea_2019_qd networks_yes ghg_tgt_allplussect_2020tgtyr opp_collab_yes opp_TOTAL ntl_bf25_mea_2020_impct_ppt total_deaths_20_21_pth gvmt_response_index_ppt popden_bf25_max_div10000 logntl_bf25_mea_2019v2 loggdp_country_2019 v2x_libdem_new_ppt


*LABEL VARIABLES
lab var  ccimpct_hlth_iss_TOTAL "Climate-related health issues"
lab var cc_hazd_prob_TOTAL "Climate change hazards"
lab var no2_bf25_mea_2019_qd "Air pollution (NO2, pre-C19)"
lab var networks_yes "Climate network membership"
lab var ghg_tgt_allplussect_2020tgtyr "Short-term GHG target"
lab var opp_collab_yes "Collaboration with business"
lab var opp_TOTAL "Sustainability opportunities"
lab var ntl_bf25_mea_2020_impct_ppt "Economic impact (NTL)"
lab var total_deaths_20_21_pth "Mortality rate (national)"
lab var gvmt_response_index_ppt "Government response (national)" 
lab var popden_bf25_max_div10000 "Population density"      
lab var logntl_bf25_mea_2019v2 "Pre-C19 economic activity (log NTL)"
lab var loggdp_country_2019 "Log of GDP (national)"
lab var v2x_libdem_new_ppt "Liberal democracy index (national)"

*Produce margins individually for each mlogit category - (only way to produce side-by-side subgraphs for each category of covimpct_act_adj)
gsem (1.covimpct_act_adj <- `covimpct101' M1[country]@1) (2.covimpct_act_adj <- `covimpct101' M1[country]@1) (4.covimpct_act_adj <- `covimpct101' M1[country]@1), mlogit
margins, dydx(*) predict(outcome(1.covimpct_act_adj)) post coeflegend
est sto gsemact1

quietly gsem (1.covimpct_act_adj <- `covimpct101' M1[country]@1) (2.covimpct_act_adj <- `covimpct101' M1[country]@1) (4.covimpct_act_adj <- `covimpct101' M1[country]@1), mlogit
margins, dydx(*) predict(outcome(2.covimpct_act_adj)) post coeflegend
est sto gsemact2

quietly gsem (1.covimpct_act_adj <- `covimpct101' M1[country]@1) (2.covimpct_act_adj <- `covimpct101' M1[country]@1) (4.covimpct_act_adj <- `covimpct101' M1[country]@1), mlogit
margins, dydx(*) predict(outcome(3.covimpct_act_adj)) post coeflegend
est sto gsemact3


quietly gsem (1.covimpct_act_adj <- `covimpct101' M1[country]@1) (2.covimpct_act_adj <- `covimpct101' M1[country]@1) (4.covimpct_act_adj <- `covimpct101' M1[country]@1), mlogit
margins, dydx(*) predict(outcome(4.covimpct_act_adj)) post coeflegend
est sto gsemact4

*REPEAT ABOVE FOR ECON: 
gsem (1.covimpct_econ_adj <- `covimpct101' M1[country]@1) (2.covimpct_econ_adj <- `covimpct101' M1[country]@1) (4.covimpct_econ_adj <- `covimpct101' M1[country]@1), mlogit
margins, dydx(*) predict(outcome(1.covimpct_econ_adj)) post coeflegend
est sto gsemecon1

quietly gsem (1.covimpct_econ_adj <- `covimpct101' M1[country]@1) (2.covimpct_econ_adj <- `covimpct101' M1[country]@1) (4.covimpct_econ_adj <- `covimpct101' M1[country]@1), mlogit
margins, dydx(*) predict(outcome(2.covimpct_econ_adj)) post coeflegend
est sto gsemecon2

quietly gsem (1.covimpct_econ_adj <- `covimpct101' M1[country]@1) (2.covimpct_econ_adj <- `covimpct101' M1[country]@1) (4.covimpct_econ_adj <- `covimpct101' M1[country]@1), mlogit
margins, dydx(*) predict(outcome(3.covimpct_econ_adj)) post coeflegend
est sto gsemecon3

quietly gsem (1.covimpct_econ_adj <- `covimpct101' M1[country]@1) (2.covimpct_econ_adj <- `covimpct101' M1[country]@1) (4.covimpct_econ_adj <- `covimpct101' M1[country]@1), mlogit
margins, dydx(*) predict(outcome(4.covimpct_econ_adj)) post coeflegend
est sto gsemecon4


*Produce dot plot, combine climate action and climate finance
coefplot ///
(gsemact1, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(navy)  	ciopt(color(navy)) 		if(@pval<.05) 			label(climate action)  ) ///
(gsemact1, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(ltblue) 	ciopt(color(navy)) 		if(@pval<.1 & @pval>.05) label(climate action)) ///
(gsemact1, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(white) 	ciopt(color(navy)) 		if(@pval>.1) 			label(climate action)) ///
(gsemecon1, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(cranberry) ciopt(color(cranberry)) if(@pval<.05) 		label(climate finance) ) ///
(gsemecon1, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(erose) 	ciopt(color(cranberry)) if(@pval<.1 & @pval>.05) label(climate finance)) ///
(gsemecon1, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(white) 	ciopt(color(cranberry)) if(@pval>.1) 			label(climate finance)) || ///
(gsemact2, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(navy) 	ciopt(color(navy)) 		if(@pval<.05) 			label(climate action)  ) ///
(gsemact2, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(ltblue) 	ciopt(color(navy)) 		if(@pval<.1 & @pval>.05) label(climate action)) ///
(gsemact2, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(white) 	ciopt(color(navy)) 		if(@pval>.1) 			label(climate action)) ///
(gsemecon2, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(cranberry) ciopt(color(cranberry)) if(@pval<.05) 		label(climate finance) ) ///
(gsemecon2, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(erose) 	ciopt(color(cranberry)) if(@pval<.1 & @pval>.05) label(climate finance)) ///
(gsemecon2, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(white) 	ciopt(color(cranberry)) if(@pval>.1) 			label(climate finance)) || ///
(gsemact3, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(navy) 	ciopt(color(navy)) 		if(@pval<.05) 			label(climate action)  ) ///
(gsemact3, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(ltblue) 	ciopt(color(navy)) 		if(@pval<.1 & @pval>.05) label(climate action)) ///
(gsemact3, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(white) 	ciopt(color(navy)) 		if(@pval>.1) 			label(climate action)) ///
(gsemecon3, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(cranberry) ciopt(color(cranberry)) if(@pval<.05) 		label(climate finance) ) ///
(gsemecon3, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(erose) 	ciopt(color(cranberry)) if(@pval<.1 & @pval>.05) label(climate finance)) ///
(gsemecon3, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(white) 	ciopt(color(cranberry)) if(@pval>.1) 			label(climate finance)) || ///
, drop(_cons M1[country]) xline(0,lcolor(gray)) byopts(row(1))  headings(ccimpct_hlth_iss_TOTAL = "{bf:Environmental}" networks_yes = "{bf:Engagement}" ntl_bf25_mea_2020_impct_ppt = "{bf:COVID-19}" popden_bf25_max_div10000 = "{bf:Controls}", labsize(small))  ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) nokey xsize(18cm)

*ONCE PRODUCED, change headings by manually.

**Command if cut-and-paste option needed (commented out)
*coefplot (gsemact1, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(navy)  	ciopt(color(navy)) if(@pval<.05) 			label(climate action)  ) (gsemact1, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(ltblue) 	ciopt(color(navy)) 		if(@pval<.1 & @pval>.05) label(climate action))  (gsemact1, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(white) 	ciopt(color(navy)) 		if(@pval>.1) 			label(climate action)) (gsemecon1, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(cranberry) ciopt(color(cranberry)) if(@pval<.05) 		label(climate finance) ) (gsemecon1, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(erose) 	ciopt(color(cranberry)) if(@pval<.1 & @pval>.05) label(climate finance)) (gsemecon1, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(white) 	ciopt(color(cranberry)) if(@pval>.1) 			label(climate finance)) || (gsemact2, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(navy) 	ciopt(color(navy)) 		if(@pval<.05) 			label(climate action)  )  (gsemact2, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(ltblue) 	ciopt(color(navy)) 		if(@pval<.1 & @pval>.05) label(climate action)) (gsemact2, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(white) 	ciopt(color(navy)) 		if(@pval>.1) 			label(climate action)) (gsemecon2, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(cranberry) ciopt(color(cranberry)) if(@pval<.05) 		label(climate finance) ) (gsemecon2, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(erose) 	ciopt(color(cranberry)) if(@pval<.1 & @pval>.05) label(climate finance)) (gsemecon2, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(white) 	ciopt(color(cranberry)) if(@pval>.1) 			label(climate finance)) || (gsemact3, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(navy) 	ciopt(color(navy)) 		if(@pval<.05) 			label(climate action)  ) (gsemact3, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(ltblue) 	ciopt(color(navy)) 		if(@pval<.1 & @pval>.05) label(climate action)) (gsemact3, offset(0.15)   mlcolor(navy) 	msize(small) 	mcolor(white) 	ciopt(color(navy)) 		if(@pval>.1) 			label(climate action)) (gsemecon3, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(cranberry) ciopt(color(cranberry)) if(@pval<.05) 		label(climate finance) ) (gsemecon3, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(erose) 	ciopt(color(cranberry)) if(@pval<.1 & @pval>.05) label(climate finance)) (gsemecon3, offset(-0.15) mlcolor(cranberry) msize(small) 	mcolor(white) 	ciopt(color(cranberry)) if(@pval>.1) 			label(climate finance)) || , drop(_cons M1[country]) xline(0,lcolor(gray)) byopts(row(1))  headings(ccimpct_hlth_iss_TOTAL = "{bf:Environmental}" networks_yes = "{bf:Engagement}" ntl_bf25_mea_2020_impct_ppt = "{bf:COVID-19}" popden_bf25_max_div10000 = "{bf:Controls}", labsize(small))  ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) nokey xsize(18cm) 


*****************GREEN RECOVERY COEFPLOT******************

gsem (cov_recov_TOTAL <- $covimpct101 M1[country]@1), nbreg 
estpost margins, dydx(*) 
est sto gsemnbreg

*Produce dot plot
coefplot (gsemnbreg, mlcolor(gs4) mcolor(gs4) msize(medium) ciopt(color(gs4)) if(@pval<.05) offset(0)) (gsemnbreg, mlcolor(gs4) mcolor(gs10) msize(medium) ciopt(color(gs4)) if(@pval<.1 & @pval>.05) offset(0)) (gsemnbreg, mlcolor(gs4) msize(medium) mcolor(white) ciopt(color(gs4)) if(@pval>.1) offset(0)) , drop(_cons M1[country]) xline(0,lcolor(gray)) byopts(row(1))  headings(ccimpct_hlth_iss_TOTAL = "{bf:Environmental}" networks_yes = "{bf:Engagement}" ntl_bf25_mea_2020_impct_ppt = "{bf:Covid19}" popden_bf25_max_div10000 = "{bf:Controls}", labsize(small))  ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) nokey xsize(8.8cm)

	
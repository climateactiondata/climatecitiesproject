*********************************************************************
*Title		: Main Regressions and Tests
*Purpose	: Run regressions and perform tests of assumptions
*Author		: Viktoriya Kuz and Tanya O'Garra
*********************************************************************

use "C:\Users\Administrator\Desktop\CLIMCITIES\ClimCitesData"

*set directory (ADJUST AS NEEDED)
cd "C:\Users\Administrator\Desktop\CLIMCITIES"

*set local macro
local covimpct101 ccimpct_hlth_iss_TOTAL cc_hazd_prob_TOTAL no2_bf25_mea_2019_qd networks_yes ghg_tgt_allplussect_2020tgtyr opp_collab_yes opp_TOTAL ntl_bf25_mea_2020_impct_ppt total_deaths_20_21_pth gvmt_response_index_ppt popden_bf25_max_div10000 logntl_bf25_mea_2019v2 loggdp_country_2019 v2x_libdem_new_ppt

*Summarise
sum `covimpct101'


*********************************************************************
**** CLIMATE ACTION REGRESSIONS & TESTS
*********************************************************************
**** MLOGIT
mlogit covimpct_act_adj `covimpct101', baseoutcome(3)

*** TESTING
*goodness of fit
mlogitgof

*IIA test
*gen unlabeled dep vars for IIA test
gen covimpct_act_adj_nolabel=covimpct_act_adj
*run test
mlogit covimpct_act_adj_nolabel `covimpct101', baseoutcome(3)
mlogtest, iia

*vif 
quietly regress covimpct_act_adj `covimpct101' 
vif

** Store estimates for tabulation (see below)
forval i=1/4{
mlogit covimpct_act_adj `covimpct101', baseoutcome(3)
estpost margins, dydx(*) predict(pr outcome(`i'))
est sto mlogitact_`i'
}

**** MLOGIT CLUSTERED
mlogit covimpct_act_adj `covimpct101', vce(cluster country) baseoutcome(3)

* TESTING
//goodness of fit
mlogitgof

*vif 
quietly regress covimpct_act_adj `covimpct101', vce(cluster country) 
vif

** Store estimates for tabulation (see below)
forval i=1/4{
mlogit covimpct_act_adj `covimpct101', vce(cluster country) baseoutcome(3)
estpost margins, dydx(*) predict(pr outcome(`i'))
est sto mlogitact_clus_`i'
}
			
**** GSEM 
gsem (1.covimpct_act_adj <- `covimpct101' M1[country]@1) (2.covimpct_act_adj <- `covimpct101' M1[country]@1) (4.covimpct_act_adj <- `covimpct101' M1[country]@1), mlogit

//var(M1[country])==.1258651

* MARGINS (and store estimates for tabulation)
estpost margins, dydx(*) predict(outcome(1.covimpct_act_adj)) predict(outcome(2.covimpct_act_adj)) predict(outcome(3.covimpct_act_adj)) predict(outcome(4.covimpct_act_adj))
estimates store gsemact

* LR TEST FOR GSEM
gsem (1.covimpct_act_adj <- `covimpct101') (2.covimpct_act_adj <- `covimpct101') (4.covimpct_act_adj <- `covimpct101'), mlogit // fit model w/o random intercept
estimates store actwithoutT2
gsem (1.covimpct_act_adj <- `covimpct101' M1[country]@1) (2.covimpct_act_adj <- `covimpct101' M1[country]@1) (4.covimpct_act_adj <- `covimpct101' M1[country]@1), mlogit // fit model w/ random intercept 
estimates store actwithT2
lrtest actwithoutT2 actwithT2



*********************************************************************
**** CLIMATE FINANCE REGRESSIONS & TESTS
*********************************************************************

**** MLOGIT
mlogit covimpct_econ_adj `covimpct101', baseoutcome(3)

*** TESTING
*goodness of fit
mlogitgof

*IIA test
*gen unlabeled dep vars for IIA test
gen covimpct_econ_adj_nolabel=covimpct_econ_adj
*run test
mlogit covimpct_econ_adj_nolabel `covimpct101', baseoutcome(3)
mlogtest, iia 

*vif
quietly regress covimpct_econ_adj `covimpct101'  
vif

** Store estimates for tabulation (see below)
forval i=1/4{
mlogit covimpct_econ_adj `covimpct101', baseoutcome(3)
estpost margins, dydx(*) predict(pr outcome(`i'))
est sto mlogitecon_`i'
}


**** MLOGIT CLUSTERED
mlogit covimpct_econ_adj `covimpct101', vce(cluster country) baseoutcome(3)

* TESTING
*goodness of fit
mlogitgof

*vif 
quietly regress covimpct_econ_adj `covimpct101', vce(cluster country) 
vif

****Store estimates for tabulation (see below)
forval i=1/4{
mlogit covimpct_econ_adj `covimpct101', vce(cluster country) baseoutcome(3)
estpost margins, dydx(*) predict(pr outcome(`i'))
est sto mlogitecon_clus_`i'
}


**** GSEM 
gsem (1.covimpct_econ_adj <- `covimpct101' M1[country]@1) (2.covimpct_econ_adj <- `covimpct101' M1[country]@1) (4.covimpct_econ_adj <- `covimpct101' M1[country]@1), mlogit

//var(M1[country])==.3066047

* MARGINS (and store estimates for tabulation)
estpost margins, dydx(*) predict(outcome(1.covimpct_econ_adj)) predict(outcome(2.covimpct_econ_adj)) predict(outcome(3.covimpct_econ_adj)) predict(outcome(4.covimpct_econ_adj))
est sto gsemecon

* LR TEST FOR GSEM
gsem (1.covimpct_econ_adj <- `covimpct101') (2.covimpct_econ_adj <- `covimpct101' ) (4.covimpct_econ_adj <- `covimpct101'), mlogit // fit model w/o random intercept
estimates store econwithoutT
gsem (1.covimpct_econ_adj <- `covimpct101' M1[country]@1) (2.covimpct_econ_adj <- `covimpct101' M1[country]@1) (4.covimpct_econ_adj <- `covimpct101' M1[country]@1), mlogit
// fit model w/ random intercept 
estimates store econwithT
lrtest econwithoutT econwithT


*********************************************************************
***** TABULATING CLIMATE ACTION & FINANCE RESULTS
*********************************************************************
* MARGINS ESTTAB - output results
*with standard errors
esttab gsemact gsemecon using gsemforplots.csv , nobaselevels noobs nonumbers mgroups("Increased" "Decreased" "No change" "Other") mlabel("gsemact" "gsemecon") compress nogap  onecell constant se star(* 0.10 ** 0.05 *** 0.01)

*with p-values
esttab gsemact gsemecon using gsemforplots.csv , nobaselevels noobs nonumbers mgroups("Increased" "Decreased" "No change" "Other") mlabel("gsemact" "gsemecon") compress nogap  onecell constant p star(* 0.10 ** 0.05 *** 0.01)

*with confidence intervals
esttab gsemact gsemecon using gsemforplots_CI.csv  , nobaselevels noobs nonumbers mgroups("Increased" "Decreased" "No change" "Other") mlabel("gsemact" "gsemecon") compress nogap  onecell constant ci star(* 0.10 ** 0.05 *** 0.01)

**** For easier viewing ,stacked
{
***ACT
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

***ECON
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

*with standard errors
esttab gsemact_1 gsemecon_1 using gsemALLmarg.csv, replace eqlabels(none) b(3) se(3) compress nogap mlabel("Marg.Eff. gsemact" "Marg.Eff. gsemecon", lhs("Outcome 1")) star(* 0.10 ** 0.05 *** 0.01)

forval i=2/4{
esttab gsemact_`i' gsemecon_`i' using gsemALLmarg.csv ,append eqlabels(nolabel) b(3) se(3) compress nogap mlabel("Marg.Eff. gsemact" "Marg.Eff. gsemecon", lhs("Outcome `i'")) star(* 0.10 ** 0.05 *** 0.01)
}

*with P-VALUES
esttab gsemact_1 gsemecon_1 using gsemALLmargPVALUES.csv, replace eqlabels(none) b(3) p(3) compress nogap mlabel("Marg.Eff. gsemact" "Marg.Eff. gsemecon", lhs("Outcome 1")) star(* 0.10 ** 0.05 *** 0.01)

forval i=2/4{
esttab gsemact_`i' gsemecon_`i' using gsemALLmargPVALUES.csv ,append eqlabels(nolabel) b(3) p(3) compress nogap mlabel("Marg.Eff. gsemact" "Marg.Eff. gsemecon", lhs("Outcome `i'")) star(* 0.10 ** 0.05 *** 0.01)
}

*with confidence intervals
esttab gsemact_1 gsemecon_1 using gsemALLmargCI.csv, replace eqlabels(none) b(3) ci(3) compress nogap mlabel("Marg.Eff. gsemact" "Marg.Eff. gsemecon", lhs("Outcome 1")) star(* 0.10 ** 0.05 *** 0.01)
forval i=2/4{
esttab gsemact_`i' gsemecon_`i' using gsemALLmargCI.csv ,append eqlabels(nolabel) b(3) ci(3) compress nogap mlabel("Marg.Eff. gsemact" "Marg.Eff.gsemecon", lhs("Outcome `i'")) star(* 0.10 ** 0.05 *** 0.01)
}

**MARGINS FOR MLOGITS
forval i=1/4{
mlogit covimpct_act_adj `covimpct101', baseoutcome(3)
estpost margins, dydx(*) predict(pr outcome(`i'))
est sto mlogitact_`i'
}
forval i=1/4{
mlogit covimpct_act_adj `covimpct101', vce(cluster country) baseoutcome(3)
estpost margins, dydx(*) predict(pr outcome(`i'))
est sto mlogitact_clus_`i'
}
forval i=1/4{
mlogit covimpct_econ_adj `covimpct101', baseoutcome(3)
estpost margins, dydx(*) predict(pr outcome(`i'))
est sto mlogitecon_`i'
}
forval i=1/4{
mlogit covimpct_econ_adj `covimpct101', vce(cluster country) baseoutcome(3)
estpost margins, dydx(*) predict(pr outcome(`i'))
est sto mlogitecon_clus_`i'
}


**** MARGINS ESTTAB - output results

*with standard errors
esttab mlogitact_1 mlogitact_clus_1 mlogitecon_1 mlogitecon_clus_1 using mlogits.csv, replace eqlabels(none) b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) mlabel("mlogitact_1" "mlogitact_clus_1" "mlogitecon_1" "mlogitecon_clus_1" , lhs("Outcome `1'"))

forval i=2/4{
esttab mlogitact_`i' mlogitact_clus_`i' mlogitecon_`i' mlogitecon_clus_`i'  using mlogits.csv ,append eqlabels(nolabel) b(3) se(3) nonumber nobaselevels nonotes star(* 0.10 ** 0.05 *** 0.01) mlabel("mlogitact_1" "mlogitact_clus_1" "mlogitecon_1" "mlogitecon_clus_1" , lhs("Outcome `i'"))
}

*with P-VALUES
esttab mlogitact_1 mlogitact_clus_1 mlogitecon_1 mlogitecon_clus_1 using mlogitsPVALUES.csv, replace eqlabels(none) b(3) p(3) star(* 0.10 ** 0.05 *** 0.01) mlabel("mlogitact_1" "mlogitact_clus_1" "mlogitecon_1" "mlogitecon_clus_1" , lhs("Outcome `1'"))

forval i=2/4{
esttab mlogitact_`i' mlogitact_clus_`i' mlogitecon_`i' mlogitecon_clus_`i'  using mlogitsPVALUES.csv ,append eqlabels(nolabel) b(3) p(3) nonumber nobaselevels nonotes star(* 0.10 ** 0.05 *** 0.01) mlabel("mlogitact_1" "mlogitact_clus_1" "mlogitecon_1" "mlogitecon_clus_1" , lhs("Outcome `i'"))
}


*with confidence intervals
esttab mlogitact_1 mlogitact_clus_1 mlogitecon_1 mlogitecon_clus_1 using mlogitsCI.csv, replace eqlabels(none) b(3) ci(3) star(* 0.10 ** 0.05 *** 0.01) mlabel("mlogitact_1" "mlogitact_clus_1" "mlogitecon_1" "mlogitecon_clus_1" , lhs("Outcome `1'"))

forval i=2/4{
esttab mlogitact_`i' mlogitact_clus_`i' mlogitecon_`i' mlogitecon_clus_`i'  using mlogitsCI.csv ,append eqlabels(nolabel) b(3) ci(3) nonumber nobaselevels nonotes star(* 0.10 ** 0.05 *** 0.01) mlabel("mlogitact_1" "mlogitact_clus_1" "mlogitecon_1" "mlogitecon_clus_1" , lhs("Outcome `i'"))
}

		
*********************************************************************
**** GREEN RECOVERY MAIN REGRESSIONS & TESTS
*********************************************************************								

*** COVID-19 recovery
table (cov_recov_TOTAL) (cdpregion)


* clustered poisson (testing overdispersion)
poisson cov_recov_TOTAL `covimpct101', vce(cluster country) 
estat gof

**** NBINOMIAL
*1. regular nbreg and clustered nbreg
nbreg cov_recov_TOTAL `covimpct101'
estpost margins, dydx(*) 
est sto regnbreg_covrecov1_marg

nbreg cov_recov_TOTAL `covimpct101', vce(cluster country)
estpost margins, dydx(*) 
est sto clusnbreg_covrecov1_marg


*2. gsem nbreg with marginal effects
gsem (cov_recov_TOTAL <- `covimpct101' M1[country]@1), nbreg 

///variance from gsem is var(M1[country]) =  .1088748

estpost margins, dydx(*) 
est sto gsemnbreg_covrecov1_marg

*2. lr test for multilevel vs no multilevel
gsem (cov_recov_TOTAL <- `covimpct101'), nbreg // fit model w/o random intercept
estimates store nbregwithoutT
gsem (cov_recov_TOTAL <- `covimpct101' M1[country]@1), nbreg // fit model w/ random intercept 
estimates store nbregwithT
lrtest nbregwithoutT nbregwithT


*********************************************************************
***** TABULATING GREEN RECOVERY RESULTS
*********************************************************************
* MARGINS ESTTAB - output results

*with standard errors
esttab gsemnbreg_covrecov1_marg  clusnbreg_covrecov1_marg regnbreg_covrecov1_marg using allnbinomial.csv, replace eqlabels(none) b(3) se(3) compress nogap star(* 0.10 ** 0.05 *** 0.01) mlabel("Marg.Eff. gsem nbreg" "Marg.Eff. clustered nbreg" "Marg.Eff. regular nbreg" )

*with P-VALUES
esttab gsemnbreg_covrecov1_marg  clusnbreg_covrecov1_marg regnbreg_covrecov1_marg using allnbinomialPVALUES.csv, replace eqlabels(none) b(3) p(3) compress nogap star(* 0.10 ** 0.05 *** 0.01) mlabel("Marg.Eff. gsem nbreg" "Marg.Eff. clustered nbreg" "Marg.Eff. regular nbreg")


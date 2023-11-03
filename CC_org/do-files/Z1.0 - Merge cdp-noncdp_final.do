*********************************************************************************
*****MERGING OTHER DATA
*********************************************************************************
clear

*set directory (ADJUST AS NEEDED)
cd "C:\Users\Administrator\Desktop\CC_org" // ADJUST PATH NAME AS NEEDED

*local macro for path names
local climcit "C:\Users\Administrator\Desktop\CC_org" //ADJUST PATH NAME AS NEEDED

*Use the clean CDP data file
use "`climcit'\cdp_2021_final"


*Merge with non-cdp final merged file
merge 1:1 accnum using "`climcit'\non-cdp_final"
drop _merge 


*save as anew file name
save "`climcit'\ClimCitiesData",replace
clear

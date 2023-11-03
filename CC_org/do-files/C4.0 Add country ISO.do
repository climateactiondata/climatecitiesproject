********************************************************************************
*TITLE:		Add country ISO
*PURPOSE:	Standardizing country names and adding ISO codes (using "kountry" command)
*AUTHORS:	Tanya O'Garra
********************************************************************************

clear

*set directory (ADJUST AS NEEDED)
cd "C:\Users\Administrator\Desktop\CC_org" // ADJUST PATH NAME AS NEEDED

*local macro for path names
local climcit "C:\Users\Administrator\Desktop\CC_org" //ADJUST PATH NAME AS NEEDED

use "`climcit'\cdp_2021_clean"


*Step 1: standardize country names
kountry country, from(other) marker

*Step 2: identify which ones could not be standardized
tab country if MARKER==0

*Step 3: identify how they are named in the "kountry" listing and fix them
help kountrynames

*fixing them:
replace NAMES_STD = "Bolivia" if regexm( NAMES_STD , "bolivia plurinational state of"+)
replace NAMES_STD = "United Kingdom" if regexm( NAMES_STD , "united kingdom of great britain"+)
replace NAMES_STD = "Cote d'Ivoire" if regexm( NAMES_STD , "d'ivoire"+)
replace NAMES_STD = "Palestine" if regexm( NAMES_STD , "palestine"+)
replace NAMES_STD = "Taiwan" if regexm( NAMES_STD , "taiwan"+)
replace NAMES_STD = "Venezuela" if regexm( NAMES_STD , "venezuela"+) 

*ESWATINI (ISO alpha-3: SWZ, numeric: 748) MISSING FROM KOUNTRYNAMES - add manually later - but first add capital letter
replace NAMES_STD ="Eswatini" if NAMES_STD =="eswatini"

*Step4: convert standardized country names to ISO numeric (internally referred to as _ISO3N_)
rename NAMES_STD country_std
drop MARKER
kountry country_std , from(other) stuck marker
rename _ISO3N_ iso3n

*Step 5: now convert to whatever you want
kountry iso3n, from(iso3n) to(iso3c)
rename _ISO3C_ iso3c

*Step 6: fix those that could not be standardized
recode iso3n .=748
replace iso3c="SWZ" if iso3c== ""

label var country_std "standardised country name as per kountry"
order country_std iso3n, after(country)

drop MARKER

save "`climcit'\cdp_2021_final", replace
clear

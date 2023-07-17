**************************************************
*************PROJECT JURNAL KESEHATAN************
**************************************************
*Step 1*
clear
set more off


				*creating macro directory*
*==========================================================*

*Original data*
global mia5 "E:\hh14_all_dta"

*Output*
global jurnalmia "D:\User\Downloads\IFLS\jurnalmia"

***********************************************
            *Status Kesehatan*
***********************************************

global mia5 "E:\hh14_all_dta"
global jurnalmia "E:\jurnalmia"
use $mia5\b3b_cd3, clear 
sort pid14 hhid14_9
use $mia5\b3b_kk2, clear

*TBC
keep if cdtype=="C"
keep pid14 hhid14_9 pid14 pidlink cdtype cd05
rename cd05 tbc
recode tbc (3=0)
recode tbc (8=.)
drop if tbc==.
label define tbc 0 "0: no", modify
label define tbc 1 "1: yes", modify
label values tbc tbc
save $jurnalmia\tbc.dta, replace

*hipertensi
keep if cdtype=="A"
keep pid14 hhid14_9 pid14 pidlink cdtype cd05
rename cd05 hipertensi
recode hipertensi (3=0)
recode hipertensi (8=.)
drop if hipertensi==.
label define hipertensi 0 "0: no", modify
label define hipertensi 1 "1: yes", modify
label values hipertensi
save $jurnalmia\hipertensi.dta, replace

*diabetes
keep if cdtype=="B"
keep pid14 hhid14_9 pid14 pidlink cdtype cd05
rename cd05 diabetes
recode diabetes (3=0)
recode diabetes (8=.)
drop if diabetes==.
label define diabetes 0 "0: no", modify
label define diabetes 1 "1: yes", modify
label values diabetes
save $jurnalmia\diabetes.dta, replace

*Asma
keep if cdtype=="D"
keep pid14 hhid14_9 pid14 pidlink cdtype cd05
rename cd05 Asma
recode Asma (3=0)
recode Asma (8=.)
drop if Asma==.
label define Asma 0 "0: no", modify
label define Asma 1 "1: yes", modify
label values Asma
save $jurnalmia\Asma.dta, replace

*serangan Jantung
keep if cdtype=="F"
keep pid14 hhid14_9 pid14 pidlink cdtype cd05
rename cd05 Jantung
recode Jantung (3=0)
recode Jantung (8=.)
drop if Jantung==.
label define Jantung 0 "0: no", modify
label define Jantung 1 "1: yes", modify
label values Jantung
save $jurnalmia\Jantung.dta, replace

*liver
keep if cdtype=="G"
keep pid14 hhid14_9 pid14 pidlink cdtype cd05
rename cd05 liver
recode liver (3=0)
recode liver (8=.)
drop if liver==.
label define liver 0 "0: no", modify
label define liver 1 "1: yes", modify
label values liver
save $jurnalmia\liver.dta, replace


*stroke
keep if cdtype=="H"
keep pid14 hhid14_9 pid14 pidlink cdtype cd05
rename cd05 stroke
recode stroke(3=0)
recode stroke (8=.)
drop if stroke==.
label define stroke 0 "0: no", modify
label define stroke 1 "1: yes", modify
label values stroke
save $jurnalmia\stroke.dta, replace

*Kanker
keep if cdtype=="I"
keep pid14 hhid14_9 pid14 pidlink cdtype cd05
rename cd05 Kanker
recode Kanker(3=0)
recode Kanker (8=.)
drop if Kanker==.
label define Kanker 0 "0: no", modify
label define Kanker 1 "1: yes", modify
label values Kanker
save $jurnalmia\Kanker.dta, replace

*arthritis
keep if cdtype=="J"
keep pid14 hhid14_9 pid14 pidlink cdtype cd05
rename cd05 arthritis
recode arthritis(3=0)
recode arthritis (8=.)
drop if arthritis==.
label define arthritis 0 "0: no", modify
label define arthritis 1 "1: yes", modify
label values arthritis
save $jurnalmia\arthritis.dta, replace

*penyakit ginjal
keep if cdtype=="O"
keep pid14 hhid14_9 pid14 pidlink cdtype cd05
rename cd05 ginjal
recode ginjal(3=0)
recode ginjal (8=.)
drop if ginjal==.
label define ginjal 0 "0: no", modify
label define ginjal 1 "1: yes", modify
label values ginjal
save $jurnalmia\ginjal.dta, replace

*penyakit pencernaan
keep if cdtype=="P"
keep pid14 hhid14_9 pid14 pidlink cdtype cd05
rename cd05 pencernaan
recode pencernaan(3=0)
recode pencernaan (8=.)
drop if pencernaan==.
label define pencernaan 0 "0: no", modify
label define pencernaan 1 "1: yes", modify
label values pencernaan
save $jurnalmia\pencernaan.dta, replace

*status gizi
use $mia5\bus_us, clear 
sort pid14 hhid14_9
keep hhid14_9 hhid14 pidlink pid14 us06 us04 us18aa us18ab us18ac us18ad us09a us09b us09c

recode us18aa (3=0)
recode us18ab (3=0)
recode us18ac (3=0)
recode us18ad (3=0)

rename us06 weight
rename us04 height

gen height1=height/100
gen bmi=weight/height1^2

format bmi %9.2fc

gen ideal=.

replace bmi=round(bmi, 0.1)

*below 18.5 – you're in the underweight range
*between 18.5 and 24.9 – you're in the healthy weight range
*between 25 and 29.9 – you're in the overweight range
*between 30 and 39.9 – you're in the obese range

replace ideal=1 if (bmi >=18.5 & bmi <=24.9)
replace ideal=2 if (bmi >=25 & bmi <=29.9)
replace ideal=3 if (bmi <18.5)
replace ideal=4 if (bmi >30)

label define ideal 1 "1. underweight", modify
label define ideal 2 "2. healthy", modify
label define ideal 3 "3. overweight", modify
label define ideal 4 "4. obese", modify

label values ideal ideal

label values ideal ideal
drop if ideal==.
gen status_gizi=ideal
recode status_gizi (1 3 4=0)
recode status_gizi (2=1)
label define status_gizi 0 "0: beresiko", modify
label define status_gizi 1 "1: tidak_beresiko", modify
label values status_gizi status_gizi
save $jurnalmia\statusgizi.dta, replace

*kolesterol
keep pid14 hhid14_9 us18ab us18ad
rename us18ad kolesterol
rename us18ab tekanandarah
recode kolesterol (3=0)
recode kolesterol (1=1)
label define kolesterol 1 "1. yes", modify
label define kolesterol 0 "0. no", modify
label values kolesterol kolesterol
save $jurnalmia\kolesterol, replace

*tekanandarah
recode tekanandarah (3=0)
recode tekanandarah (1=1)
label define tekanandarah 1 "1. yes", modify
label define tekanandarah 0 "0. no", modify
label values tekanandarah tekanandarah

*Batuk Berdarah*
use $mia5\b3b_ma2, clear 
sort pid14 hhid14_9
keep pid14 hhid14_9 pid14 pidlink matype ma01
gen dummy_morbidity=0
recode dummy (0=1) if substr(matype,1,1)=="C"
keep if matype=="Cc"

drop dummy_morbidity

recode ma01 (8=.)
recode ma01 (3=0)
drop if ma01==.

rename ma01 bloody_cough

label define bloody_cough 0 "0: no", modify
label define bloody_cough 1 "1: yes", modify
label values bloody_cough bloody_cough
save $jurnalmia\batukberdarah.dta, replace



*********************************************
        *Karakteristik Rumah Tangga*
********************************************

*water drinking
use $mia5\b2_kr, clear 
sort hhid14_9
keep hhid14 hhid14_9 kr11 kr13 kr13a kr13b kr14 kr16 kr15 kr20 kr22
rename kr13 water_drinking
gen type_waterdrinking= water_drinking
recode  type_waterdrinking (1 2 3 10=1)
recode  type_waterdrinking (4 5 6 8 95=0)

label define type_waterdrinking 0 "0: other", modify	 
label define type_waterdrinking 1 "1: well water", modify
label values type_waterdrinking type_waterdrinking 
save $jurnalmia\water.dta, replace

*Karakteristik Rumah*
use $mia5\bk_krk, clear
sort hhid14_9
keep hhid14 hhid14_9 krk01 krk02e krk06 krk08 krk09 krk10

gen sufficent_ventilation=krk02e
drop krk02e

recode sufficent_ventilation (3=0)

label define sufficent_ventilation 0 "0: no", modify
label define sufficent_ventilation 1 "1: yes", modify
label values sufficent_ventilation sufficent_ventilation

tab krk08, missing
drop if krk08==98

gen flooring_type=krk08
drop krk08
recode flooring_type (1 2=1)
recode flooring_type (3 4 5 6 95=0)

label define flooring_type 0 "0: other", modify
label define flooring_type 1 "1: keramik", modify
label values flooring_type flooring_type

tab krk09
gen material_wall=krk09
drop krk09
recode material_wall (95=4)

label define material_wall 1 "1: masonry", modify
label define material_wall 2 "2: lumber", modify
label define material_wall 3 "3: bamboo", modify
label define material_wall 4 "4: other", modify

label values material_wall material_wall

save $jurnalmia\buku_k.dta, replace

******************************************
       *Karakteristik Individu*
******************************************

*Rokok
use $mia5\b3b_km, clear 
sort pid14 hhid14_9
keep hhid14_9 pid14 hhid14 pidlink km01a km04 km08 km10 km11 km05aa

tab km04, missing
drop if km04==.
rename km04 smoking_habit
recode smoking_habit (3=0)
label define smoking_habit 0 "0: quit", modify
label define smoking_habit 1 "1: still", modify
label values smoking_habit smoking_habit

rename km08 konsumsi_rokok
rename km10 umurawal_merokok
save $jurnalmia\smoking.dta, replace

*kategori konsumsi rokok
gen rokok=.
replace rokok=1 if (konsumsi_rokok >=12)
replace rokok=0 if (konsumsi_rokok <12)

label define rokok 1 "1. konsumsi rokok diatas 12", modify
label define rokok 2 "2. konsumsi rokok dibawah 12", modify


*jenis pekerjaan ifls 5 (kategori)
use $mia5\b3a_tk2.dta, clear
keep pid14 hhid14_9 pidlink tk24a
gen pekerjaan = tk24a
recode pekerjaan (1 2 7 8 =0)
recode pekerjaan (3 4 5 =1)
recode pekerjaan (6 9 =.)
drop if pekerjaan==.
label define pekerjaan 0 "0. nonformal", modify
label define pekerjaan 1 "1. formal", modify 
label values pekerjaan pekerjaan
save $jurnalmia\worker.dta, replace


*Pengeluaran ifls 5
use $mia5\b1_ks1.dta, clear
collapse (sum) ks02, by(hhid14_9 hhid14)
save $jurnalmia\kemiskinanks02.dta, replace
use $mia5\b1_ks2.dta, clear
collapse (sum) ks06, by(hhid14_9 hhid14)
save $jurnalmia\kemiskinanks06.dta, replace
merge 1:1 hhid14_9 hhid14 using $jurnalmia\kemiskinanks02.dta
drop if _merge!= 3
drop _merge
gen expenditure = (ks06+ks02)*4
save $jurnalmia\poverty.dta, replace


*gender ifls 5
use $mia5\b3a_cov.dta, clear
keep pid14 hhid14_9 sex
recode sex (3=0)
recode sex (1=1)
label define sex 0 "0. female", modify
label define sex 1 "1. male", modify
label values sex sex
save $jurnalmia\sex.dta, replace


*tekanan Darah
use $mia5\bus_us, clear 
keep pid14 hhid14_9 us07ax us07bx us07cx 
rename us07ax darah1
rename us07bx darah2 
rename us07cx darah3

*age
use $mia5\b3a_cov.dta, clear
keep pid14 hhid14_9 age
drop if age < 15
drop if age > 65
save $jurnalmia\age.dta, replace

gen umur=.
replace umur=1 if (age >=15 & age <25)
replace umur=2 if (age >=25 & age <35)
replace umur=3 if (age >=35 & age <45)
replace umur=4 if (age >=45 & age <55)
replace umur=5 if (age >=55)


label define umur 1 "1. 15-24 years", modify
label define umur 2 "2. 25-34 years", modify
label define umur 3 "3. 35-44 years", modify
label define umur 4 "4. 45-54 years", modify
label define umur 5 "5. >55 years", modify
label values umur umur

gen umur1=.
replace umur1=1 if (age >=15 & age <=19)
replace umur1=2 if (age >=20 & age <=24)
replace umur1=3 if (age >=25)

label define umur1 1 "1. 15-19 years", modify
label define umur1 2 "2. 20-24 years", modify
label define umur1 3 "3. >24 years", modify




*income
use $mia5\b3a_tk2.dta, clear
keep pid14 hhid14_9 tk25a1 tk25a1a tk25a2 tk25a2a tk25a2b tk25a2c
*Upah sebulan yang lalu*
gen wage=tk25a1
gen upah=tk25a1a
recode upah (11 12=10000000)
recode upah (21 22=500000)
recode upah (28 99=.)
replace wage=upah if wage==.
*Upah 12 bulan terakhir*
gen wage2=tk25a2/12
gen upah2=tk25a2a
recode upah2 (11 12=80000000)
recode upah2 (21 22=6000000)
recode upah2 (18 28 99=.)
replace wage2=upah2 if wage==.
replace upah2=wage if wage==.
*Nilai tunjangan akhir tahun*
gen bonus=tk25a2b/12
gen tunjangan=tk25a2c
recode tunjangan (11 12=10000000)
recode tunjangan (21 22=500000)
recode tunjangan (28 99=.)
replace bonus=tunjangan if bonus==.
replace wage=bonus if wage==.
save $jurnalmia\income.dta, replace

*olahraga
encode (kktype), gen (olahraga)
keep if olahraga==3
keep pid14 hhid14_9 pid14 pidlink olahraga kk02o
rename kk02o kegiatanfisik
save $jurnalmia\kegiatanfisik, replace


*************************************************
********MERGING ALL DATA, READY TO PROCESS*******
*************************************************

set more off
use $jurnalmia\poverty.dta, clear
merge 1:m hhid14_9 using $jurnalmia\sex.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\educ.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\marital.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\worker.dta
drop if _merge! = 3
drop _merge


merge 1:1 hhid14_9 pid14 using $jurnalmia\age.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\diabetes.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\hipertensi.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\tbc.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\Asma.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\Jantung.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\liver.dta
drop if _merge! = 3
drop _merge


merge 1:1 hhid14_9 pid14 using $jurnalmia\stroke.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\Kanker.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\arthritis.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\ginjal.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\pencernaan.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\smoking.dta
drop if _merge! = 3
drop _merge

merge m:1 hhid14_9 using $jurnalmia\water.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\statusgizi.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\income.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\kolesterol
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\kegiatanfisik
drop if _merge! = 3
drop _merge


*Poverty Calculations*
gen id=1
egen id_count = total(pid14), by (hhid14_9)
gen poor=(expenditure/id_count)
gen poor_line=0
replace poor_line=1 if poor<=326853


*************************************************
******************PROCESSING*********************
*************************************************
keep hhid14_9 hhid14 tekanandarah pendidikan pekerjaan umur tbc Jantung konsumsi_rokok status_gizi poor_line total_income kolesterol liver stroke Kanker ginjal pencernaan Asma hipertensi diabetes nikah sex smoking_habit water_drinking age

logit Jantung poor_line tekanandarah i.pendidikan i.pekerjaan age rokok status_gizi
margins,dydx(*)

logit Jantung poor_line tekanandarah i.pendidikan i.pekerjaan i.umur konsumsi_rokok status_gizi kegiatanfisik
margins,dydx(*) post

logit tbc poor_line tekanandarah kolesterol i.pendidikan i.pekerjaan agesq1 konsumsi_rokok status_gizi

logit tbc poor_line tekanandarah i.pendidikan i.pekerjaan age rokok status_gizi
margins,dydx(*) post
logit tbc poor_line tekanandarah i.pendidikan i.pekerjaan i.umur konsumsi_rokok status_gizi 

outreg2 using margins.doc, replace ctitle(Jantung)
outreg2 using margins.doc, append ctitle(tbc)

save $jurnalmia\dataset_kesehatan, replace


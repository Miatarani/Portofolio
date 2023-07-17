**************************************************
*************PROJECT JURNAL WELL-BEING************
**************************************************
clear
set more off

				*creating macro directory*
*==========================================================*

*Original data*
global mia5 "E:\hh14_all_dta"

*Output*
global jurnalmia "E:\jurnalmia"

******************************************
       *Karakteristik Individu*
******************************************

*gender ifls 5 (kategori)
use $mia5\b3a_cov.dta, clear
keep pid14 hhid14_9 sex
recode sex (1=0)
recode sex (3=1)
label define sex 1 "1. female", modify
label define sex 0 "0. male", modify
label values sex sex
save $jurnalmia\sex.dta, replace


*income(nominal)
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
gen lwage =ln(wage)
save $jurnalmia\income.dta, replace

*pendidikan ifls 5 (kategori)
use $mia5\b3a_dl1.dta, clear
keep pid14 hhid14_9 dl06 
gen pendidikan = dl06
recode pendidikan (2 11 72 17 =1)
recode pendidikan (3 4 12 14 73 =2)
recode pendidikan (5 6 15 74 =3)
recode pendidikan (60 61 62 63 13 =4)
recode pendidikan (90 98 95 99 =.)
drop if pendidikan==.
label define pendidikan 1 "1. SD", modify
label define pendidikan 2 "2. SMP", modify 
label define pendidikan 3 "3. SMA", modify
label define pendidikan 4 "4. Kuliah", modify
label values pendidikan pendidikan
save $jurnalmia\educ.dta, replace


*marital Ifls 5 (kategori)
use $mia5\b3a_cov.dta, clear
keep pid14 hhid14_9 marstat
rename marstat nikah
recode nikah (3 4 5 6=0)
recode nikah (2=1)
drop if nikah==9
label define nikah 1 "1. Menikah", modify
label define nikah 0 "0. Tidak Menikah", modify
label values nikah nikah

save $jurnalmia\marital.dta, replace

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


*jumlah anak ifls 5 (nominal)
use $mia5\b4_br.dta, clear
keep pid14 hhid14_9 br03 br04
gen anak = br03+br04
gen children = anak 
replace children=1 if (anak >= 2)
replace children=0 if (anak < 2)
label define children 1 "1. children", modify
label define children 0 "0. child", modify

save $jurnalmia\child.dta, replace

*age ifls 5 (nominal)
use $mia5\b3a_cov.dta, clear
keep pid14 hhid14_9 age
save $jurnalmia\age.dta, replace

*kemiskinan ifls 5
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


*wellbeing ifls 5 (kategori)
use $mia5\b3a_sw.dta, clear 
keep pid14 hhid14_9 sw00
rename sw00 satisfied
recode satisfied (1 2 3=1)
recode satisfied (4 5=0)
drop if satisfied==9
label define happy 1 "1. satisfied", modify
label define happy 0 "0. unsatisfied", modify
label values satisfied satisfied
save $jurnalmia\wellbeing.dta, replace


***********************************************
            *Depression symptoms*
***********************************************

*depresi ifls 5 (nominal hasil winstep)
use $mia5\b3b_kp.dta, clear
gen mental = kp02
encode kptype, gen (type)
duplicates report pidlink
drop kptype kp02
tostring pid14, gen(pid)
replace  pid = "0"+ pid if pid14 < 10
replace  pid = hhid14_9 + pid
reshape wide mental , i(pid) j(type)

recode mental5 (1=5)
recode mental5(2=6)
recode mental5 (3=7)
recode mental5 (4=8)

recode mental5 (5=3)
recode mental5 (6=2)
recode mental5 (7=1)
recode mental5 (8=0)


recode mental8 (1=5)
recode mental8(2=6)
recode mental8 (3=7)
recode mental8 (4=8)

recode mental8 (5=3)
recode mental8 (6=2)
recode mental8 (7=1)
recode mental8 (8=0)


recode mental1(1=0)
recode mental1(2=1)
recode mental1 (3=2)
recode mental1 (4=3)


recode mental2 (1=0)
recode mental2(2=1)
recode mental2 (3=2)
recode mental2 (4=3)


recode mental3 (1=0)
recode mental3(2=1)
recode mental3 (3=2)
recode mental3 (4=3)



recode mental4 (1=0)
recode mental4(2=1)
recode mental4 (3=2)
recode mental4 (4=3)


recode mental6 (1=0)
recode mental6(2=1)
recode mental6 (3=2)
recode mental6 (4=3)


recode mental7 (1=0)
recode mental7(2=1)
recode mental7 (3=2)
recode mental7 (4=3)




recode mental9 (1=0)
recode mental9(2=1)
recode mental9 (3=2)
recode mental9 (4=3)


recode mental10 (1=0)
recode mental10 (2=1)
recode mental10(3=2)
recode mental10(4=3)
save $jurnalmia\depresi.dta, replace

sum measure
gen depressed2=measure
replace depressed2=0 if (measure >=-3.5)
replace depressed2=1 if (measure <=2.0)
label define measure 1 "1. depresi", modify
label define measure 0 "0. nodepresi", modify
save $jurnalmia\depresi.dta, replace


*************************************************
********MERGING ALL DATA, READY TO PROCESS*******
*************************************************
use $jurnalmia\wellbeing.dta, clear
merge 1:1 hhid14_9 pid14 using $jurnalmia\sex.dta
drop if _merge! = 3
drop _merge

merge m:1 hhid14_9 pid14 using $jurnalmia\depresi_2014.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\income.dta
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

merge m:1 hhid14_9 using $jurnalmia\poverty.dta
drop if _merge! = 3
drop _merge

merge 1:1 hhid14_9 pid14 using $jurnalmia\child.dta
drop if _merge! = 3
drop _merge

destring hhid14_9, replace


gen marstat = (sex*nikah) 
gen age2 = age^2
save $jurnalmia\jurnalsatu3.dta


gen satiswoman = (sex*satisfied)
gen marstat = (sex*nikah) 
gen marital = (poverty*nikah)
gen povchild = (anak*poverty)


logit satiswoman i.pendidikan i.pekerjaan exp children i.nikah depressed2
margins,dydx(*) post

logit satiswoman i.pendidikan i.pekerjaan exp children i.marstat

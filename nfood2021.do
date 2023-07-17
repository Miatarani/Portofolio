/* NONFOOD Consumption Data [NEWEST VERSION]
Skripsi mia
*/


** working directory [for DELL] **

global raw "E:\Skripsi\Data"
global coded "E:\Skripsi\Coded"
global output "E:\Skripsi\Output"


** CLEANING DATA **

*1. Non-food consumption

use "$raw/susenas21march_42.dta", clear


*1.a. Kesehatan

*keeping all the important variables


keep if inlist(kode, 189, 231, 270, 279, 297, 301, 304) | inrange(kode,232,269)

keep urut sebulan kode b42k3a b42k3b b42k3c b42k3d b42k3e

foreach var of varlist sebulan b42k3a b42k3b b42k3c b42k3d b42k3e {
recode `var' (.=0)
}

reshape wide sebulan b42k3a b42k3b b42k3c b42k3d b42k3e, i(urut) j(kode)

egen pengobatan = rowtotal(b42k3a239 b42k3b239 b42k3a240 b42k3b240 b42k3a241 b42k3b241 ///
b42k3c241 b42k3d241 b42k3e241 b42k3a242 b42k3a243 b42k3a244)

label variable pengobatan "Biaya pelayanan pengobatan/kuratif termasuk pengobatan tradisional (OOP)"

gen persalinan = b42k3a245

label variable persalinan "Biaya berobat ke penolong persalinan (OOP)"

egen obat = rowtotal(b42k3a246 b42k3a247 b42k3a248)

label variable obat "Biaya obat (OOP)"

gen device = b42k3a249

label variable device "Kacamata, kaki/tangan palsu, dan kursi roda (OOP)"

egen pencegahan = rowtotal(b42k3a250 b42k3a251 b42k3a252 b42k3a253 b42k3a254)

label variable pencegahan "Biaya pelayanan pencegahan (OOP)"

gen kehamilan = b42k3a250 

gen imunisasi = b42k3a251

gen kbiaya = b42k3a253

egen preventif = rowtotal(b42k3a252 b42k3a254)

label variable preventif "Tes kesehatan dan pemeliharaan kesehatan lainnya"

egen oop = rowtotal(b42k3a239 b42k3b239 b42k3a240 b42k3b240 b42k3a241 b42k3b241 ///
b42k3c241 b42k3d241 b42k3e241 b42k3a242 b42k3a243 b42k3a244 b42k3a245 b42k3a246 ///
b42k3a247 b42k3a248 b42k3a249 b42k3a250 b42k3a251 b42k3a252 b42k3a253 b42k3a254)

label variable oop "Out of Pocket"

egen trans = rowtotal(b42k3a261 b42k3b261 b42k3a262 b42k3a263)

label variable trans "Health transportation"

gen ambulan = b42k3b261

egen health_ooptrans = rowtotal(oop trans)

label variable health_ooptrans "Health: OOP & transportasi"

gen hinsurance = sebulan301

replace oop = oop/12
replace trans = trans/12
replace health_ooptrans = health_ooptrans/12
replace pengobatan = pengobatan/12
replace obat = obat/12
replace pencegahan = pencegahan/12
replace ambulan = ambulan/12
replace persalinan = persalinan/12
replace kbiaya = kbiaya/12 
replace preventif = preventif/12
replace imunisasi = imunisasi/12
replace kehamilan = kehamilan/12
replace device = device/12

gen trans_noamb = trans-ambulan

gen health_ins = health_ooptrans + hinsurance
label variable health_ins "Health: OOP, transportasi & insurance"

*1.b. others

* rename and labeling

rename sebulan189 housing
label variable housing "Perumahan & Fasilitas RT"

rename sebulan231 goods 
label variable goods "Aneka barang & jasa"

rename sebulan270 clothing
label variable clothing "Pakaian, alas kaki & penutup kepala"

rename sebulan279 durable
label variable durable "Barang tahan lama"

rename sebulan297 tax
label variable tax "Pajak, pungutan & asuransi"

rename sebulan304 party
label variable party "Keperluan pesta & upacara"

*1.c. educ
egen educ = rowtotal(sebulan255 sebulan256 sebulan257 sebulan258 sebulan259 sebulan260)

label variable educ "Biaya sekolah/kursus"




egen health = rowtotal(sebulan239 sebulan240 sebulan241 sebulan242 sebulan243 ///
sebulan244 sebulan245 sebulan246 sebulan247 sebulan248 sebulan249 sebulan250 ///
sebulan251 sebulan252 sebulan253 sebulan254)


label variable health "Biaya pengobatan, obat & preventif (Not OOP)"


egen transport = rowtotal(sebulan261 sebulan262 sebulan263 sebulan264 sebulan265 ///
sebulan266 sebulan267 sebulan268 sebulan269)

egen others = rowtotal(sebulan232 sebulan233 sebulan234 sebulan235 sebulan236 sebulan237 sebulan238)


label variable others "Barang lainnya"

label variable transport "Biaya transportasi, akomodasi & jasa"

format housing goods clothing durable tax party %9.0g

recode party durable tax (.=0)

rename imunisasi imun_bi

keep persalinan kbiaya imun_bi preventif pencegahan kehamilan party oop trans hinsurance ambulan ///
health_ooptrans health_ins educ health transport pencegahan pengobatan obat device ///
others tax durable clothing goods housing urut

rename renum urut


save "$coded/nfood2021_cons.dta", replace

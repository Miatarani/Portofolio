*PENELITIAN TUGAS MEKANISME TRANSMISI KEBIJAKAN MONETER JALUR NILAI TUKAR TERHADAP INFLASI*
                                *Tahun 2006-2019*
*===================================================================================*
clear
set more off


**************
*IMPORT DATA*
**************
import excel "E:\Bank Indonesia\Portofolio Pengolahan Data\test.xlsx", sheet("Sheet2") firstrow 

******************
*Transformasi Data
******************
gen lnInf = ln( ihk)

gen lnER = ln( exchangerate )

gen lnBI = ln( BIRate )

gen lnGDP = ln( GDP )

gen lnTotEx = ln( Totalekspor )

gen lnFDI = ln( FDI )


*************
*Time Series
*************
gen date = tq(2006q1)+_n-1
format %tq date
tsset date

********************
*1.Uji Stasioneritas 
********************

dfuller lnInf
dfuller d.lnInf
dfuller lnER
dfuller d.lnER
dfuller lnBI
dfuller d.lnBI
dfuller lnGDP
dfuller d.lnGDP
dfuller lnTotEx
dfuller lnFDI
dfuller d.lnFDI

gen dlninf = d.lnInf
gen dlnBI = d.lnBI




****************
*2.Lag Optimum // cari bintang terbanyak untuk rekomendasi lag optimal
****************
var d.lnGDP d.lnInf d.lnBI d.lnER lnTotEx d.lnFDI, lags(1/5)
varsoc

var d.lnGDP d.lnInf d.lnBI d.lnER lnTotEx d.lnFDI, lags(5)
**********************
*3. Uji Stabilitas VAR // nilai modulus harus dibawah 1
**********************
varstable

**********************
*4. Uji Granger
***********************
var dlnGDP dlnInf dlnBI dlnER lnTotEx dlnFDI, lags(1/5)
outreg2 using margin1.doc, word replace ctitle(2019)
quietly var d.lnGDP d.lnInf d.lnBI d.lnER lnTotEx d.lnFDI, lags(1/5)
vargranger


gen dlnInf = d.lnInf

gen dlnER = d.lnER

gen dlnBI = d.lnBI

gen dlnGDP = d.lnGDP

gen dlnFDI = d.lnFDI

************************
*5.Impulse Respone graph
************************
irf create irf, set (irf, replace)
irf graph oirf, irf( irf) response( D.lnInf)
irf table oirf, irf( irf) response( D.lnInf)

*************************
*6. Variance Decomposition
*************************
irf ograph (irf D.lnGDP D.lnInf fevd) (irf D.lnBI D.lnInf fevd) (irf D.lnER D.lnInf fevd) (irf lnTotEx D.lnInf fevd) (irf D.lnFDI D.lnInf fevd)
irf table fevd, irf(irf)







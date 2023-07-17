
************************************
****REGRESI PROYEK TERINTEGRASI*****
************************************

************************************
        *Uji Asumsi Klasik*
************************************

*1. Uji Normalitas*
predict e, residuals
swilk e
pnorm e
swilk RES
predict 

*2. Uji Multikoleniaritas*
estat vif   
*Nilai VIF < 10


*3. Uji Heteroskedastis*
hettest
* prob>chi2 harus lebih besar dari alpha = bebas heteros*

***************************************
         *Regresi Time Series*
***************************************
generate date = tq(2012q1)+_n-1
format %tq date
tsset date
gen lngdp = ln( gdpkonstan2010)
gen ln_consume = ln( konsumsirumahtangga )
gen ln_pmtb = ln( pmtb )
*gen lngov = ln( pengeluaranpemerintah )
gen lninflasi = ln(inflasi)
gen ln_eks = ln(totalekspor)
gen lnsukubunga = ln(sukubunga)
gen lnpmtb = d.ln_pmtb
gen lnconsume = d.ln_consume
gen ln_sukubunga = d.lnsukubunga
gen lneks = d.ln_eks
gen lgdp =d.lngdp
gen drate = d.sukubunga
*gen persentase_TK =d.persentasetenagakerja
gen inflasi2 = d.lninflasi
rename inflasi2 ln_inflasi
*gen lntk = ln(persentasetenagakerja)
*gen ln_ER = ln(er)
*gen lntenagakerja = d.lntk
*Uji Stasioner*
tsset date
dfuller lngdp
dfuller lnconsume
dfuller lngov
dfuller lnpmtb
*dfuller lninflasi
dfuller ln_sukubunga

reg lngdp lnconsume lnpmtb lnsukubunga lngov
asdoc reg lngdp lnconsume lngov ln_pmtb lnsukubunga
reg lngdp lnsukubunga lnpmtb ln_eks ln_consume
asdoc reg lngdp ln_consume sukubunga lneks lnpmtb ln_inflasi
lvr2plot, mlabel(lngdp)
asdoc rreg lngdp ln_consume sukubunga lneks lnpmtb ln_inflasi, nolog

*Uji Autokorelasi*
wntestq e, lags(1)
predict r, resid
wntestq r, lags(1)

*************************************************
                  *Forecasting*
*************************************************

**Arima**
generate date = tq(2012q1)+_n-1
format %tq date
tsset date
arima gdpkonstan2010, ar(4) nolog
arima gdpkonstan2010, ar(3) nolog
arima gdpkonstan2010, ar(1) nolog
arima gdpkonstan2010, ar(1 4) nolog
arima gdpkonstan2010, ar(1 3) nolog
arima gdpkonstan2010, ar(1 3 4) nolog
estat ic
arima gdpkonstan2010, ma(4) nolog
arima gdpkonstan2010, ma(3) nolog
arima gdpkonstan2010, ma(1) nolog
arima gdpkonstan2010, ma(1 4) nolog
arima gdpkonstan2010, ma(1 3) nolog
arima gdpkonstan2010, ma(3 4) nolog
arima gdpkonstan2010, ma(1 3 4) nolog
arima gdpkonstan2010, ma(1 4) ma(1 4) nolog
estat ic
arima gdpkonstan2010, ar(1 3 4) ma(1 3 4) nolog
estat ic
asdoc arima gdpkonstan2010, ar(4) nolog


**ARCH**
predict r, resid
reg r
estat archlm
arch gdpkonstan2010, arch(1) garch(1) ar(4) nolog
asdoc arch gdpkonstan2010, arch(1) ar(4) nolog
tsappend, add(23)
predict dgdpf2, y dynamic (tq(2022q2))


arima gdp,ar(1) nolog
estat ic
arima d.gdp,ar(3) nolog
estat ic
arima d.gdp,ar(4) nolog
estat ic
arima d.gdp,ar(1 3) nolog
estat ic
arima d.gdp,ar(1 4) nolog
estat ic
arima d.gdp,ar(3 4) nolog
estat ic
arima d.gdp,ar(1 3 4) nolog
estat ic

arima d.gdp,ma(1) nolog
estat ic
arima d.gdp,ma(3) nolog
estat ic
arima d.gdp,ma(4) nolog
estat ic
arima d.gdp,ma(1 3) nolog
estat ic
arima d.gdp,ma(1 4) nolog
estat ic
arima d.gdp,ma(3 4) nolog
estat ic
arima d.gdp,ma(1 3 4) nolog
estat ic

arima d_gdp,ma(2) nolog
estat ic
predict r, resid
reg r
estat archlm

tsappend, add(23)
predict dgdpf2, y dynamic (tq(2022q2))


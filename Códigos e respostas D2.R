> remove.packages("readxl")
Removing package from 'C:/Users/lucas/Documents/R/win-library/3.5'
(as 'lib' is unspecified)
> install.packages("readxl", dependencies = T)
Installing package into 'C:/Users/lucas/Documents/R/win-library/3.5'
(as 'lib' is unspecified)
trying URL 'https://cran.rstudio.com/bin/windows/contrib/3.5/readxl_1.1.0.zip'
Content type 'application/zip' length 1499869 bytes (1.4 MB)
downloaded 1.4 MB

package 'readxl' successfully unpacked and MD5 sums checked

The downloaded binary packages are in
C:\Users\lucas\AppData\Local\Temp\RtmpOQezN5\downloaded_packages
> install.packages("strucchange")
Installing package into 'C:/Users/lucas/Documents/R/win-library/3.5'
(as 'lib' is unspecified)
trying URL 'https://cran.rstudio.com/bin/windows/contrib/3.5/strucchange_1.5-1.zip'
Content type 'application/zip' length 951119 bytes (928 KB)
downloaded 928 KB

package 'strucchange' successfully unpacked and MD5 sums checked

The downloaded binary packages are in
C:\Users\lucas\AppData\Local\Temp\RtmpOQezN5\downloaded_packages
> remove.packages("aTSA")
Removing package from 'C:/Users/lucas/Documents/R/win-library/3.5'
(as 'lib' is unspecified)
Error in remove.packages : there is no package called 'aTSA'
> install.packages("aTSA", dependencies = T)
Installing package into 'C:/Users/lucas/Documents/R/win-library/3.5'
(as 'lib' is unspecified)
trying URL 'https://cran.rstudio.com/bin/windows/contrib/3.5/aTSA_3.1.2.zip'
Content type 'application/zip' length 181302 bytes (177 KB)
downloaded 177 KB

package 'aTSA' successfully unpacked and MD5 sums checked

The downloaded binary packages are in
C:\Users\lucas\AppData\Local\Temp\RtmpOQezN5\downloaded_packages
> library(strucchange)
Carregando pacotes exigidos: zoo

Attaching package: 'zoo'

The following objects are masked from 'package:base':
  
  as.Date, as.Date.numeric

Carregando pacotes exigidos: sandwich
> library(readxl)
> library(aTSA)

Attaching package: 'aTSA'

The following object is masked from 'package:graphics':
  
  identify

> library(tseries)

'tseries' version: 0.10-45

'tseries' is a package for time series analysis and computational finance.

See 'library(help="tseries")' for details.


Attaching package: 'tseries'

The following objects are masked from 'package:aTSA':
  
  adf.test, kpss.test, pp.test

> library("urca")
> NEO <- na.omit(read_excel("C:/Econometria/Neo.xls"))
> Neo <-  ts(NEO$Close, start = 2017, frequency = 365)
> plot(Neo)
> acf(NEO$Close,lend = 2, lwd = 5,col = "darkblue", main = "Função Autocorrelação - FAC")
> axis(1,tck = 1, col = "lightgrey", lty = "dotted")
> pacf(NEO$Close,lend = 60, lwd = 5,col = "darkblue", main = "Função Autocorrelação Parcial - FACP")
> axis(1, tck = 1, col = "lightgrey", lty = "dotted")
> ADF1 <- ur.df(Neo, "none", lags = 1)
> summary (ADF1)

############################################### 
# Augmented Dickey-Fuller Test Unit Root Test # 
############################################### 

Test regression none 


Call:
lm(formula = z.diff ~ z.lag.1 - 1 + z.diff.lag)

Residuals:
Min      1Q  Median      3Q     Max 
-41.510  -0.888   0.001   0.871  30.209 

Coefficients:
Estimate Std. Error t value Pr(>|t|)
z.lag.1    -0.004038   0.003539  -1.141    0.254
z.diff.lag  0.009824   0.039194   0.251    0.802

Residual standard error: 4.695 on 651 degrees of freedom
Multiple R-squared:  0.002056,	Adjusted R-squared:  -0.00101 
F-statistic: 0.6707 on 2 and 651 DF,  p-value: 0.5117


Value of test-statistic is: -1.141 

Critical values for test statistics: 
1pct  5pct 10pct
tau1 -2.58 -1.95 -1.62

> pp.test(Neo)

Phillips-Perron Unit Root Test

data:  Neo
Dickey-Fuller Z(alpha) = -5.0859, Truncation lag parameter = 6, p-value
= 0.826
alternative hypothesis: stationary

> kpss.test(Neo)

KPSS Test for Level Stationarity

data:  Neo
KPSS Level = 4.0016, Truncation lag parameter = 5, p-value = 0.01

Warning message:
In kpss.test(Neo) : p-value smaller than printed p-value
> Ordem1 <- diff(NEO$Close)
> Neo1 <- ts(Ordem1, start = 2017, frequency = 365)
> plot(Neo1)
> acf(Ordem1,lend = 2, lwd = 5,col = "darkblue",main = "Função Autocorrelação - FAC")
> axis(1, tck = 1, col = "lightgrey", lty = "dotted")
> pacf(Ordem1,lend = 60, lwd = 5,col = "darkblue", main = "Função Autocorrelação Parcial - FACP")
> axis(1, tck = 1, col = "lightgrey", lty = "dotted")
> ADF2 <- ur.df(Neo1, "none", lags = 1)
> summary (ADF2)

############################################### 
# Augmented Dickey-Fuller Test Unit Root Test # 
############################################### 

Test regression none 


Call:
lm(formula = z.diff ~ z.lag.1 - 1 + z.diff.lag)

Residuals:
Min      1Q  Median      3Q     Max 
-39.632  -1.090  -0.001   0.773  31.081 

Coefficients:
Estimate Std. Error t value Pr(>|t|)    
z.lag.1    -1.07917    0.05504 -19.606   <2e-16 ***
z.diff.lag  0.08762    0.03907   2.242   0.0253 *  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 4.685 on 650 degrees of freedom
Multiple R-squared:    0.5,	Adjusted R-squared:  0.4984 
F-statistic:   325 on 2 and 650 DF,  p-value: < 2.2e-16


Value of test-statistic is: -19.6063 

Critical values for test statistics: 
1pct  5pct 10pct
tau1 -2.58 -1.95 -1.62

> pp.test(Neo1)

Phillips-Perron Unit Root Test

data:  Neo1
Dickey-Fuller Z(alpha) = -623.88, Truncation lag parameter = 6, p-value
= 0.01
alternative hypothesis: stationary

Warning message:
In pp.test(Neo1) : p-value smaller than printed p-value
> kpss.test(Neo1)

KPSS Test for Level Stationarity

data:  Neo1
KPSS Level = 0.15782, Truncation lag parameter = 5, p-value = 0.1

Warning message:
In kpss.test(Neo1) : p-value greater than printed p-value
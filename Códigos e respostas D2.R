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

> bp_ts <- breakpoints(Neo ~ 1)
> bp_ts

Optimal 5-segment partition: 
  
  Call:
  breakpoints.formula(formula = Neo ~ 1)

Breakpoints at observation number:
  218 350 448 546 

Corresponding to breakdates:
  2017(218) 2017(350) 2018(83) 2018(181) 
> summary(bp_ts)

Optimal (m+1)-segment partition: 
  
  Call:
  breakpoints.formula(formula = Neo ~ 1)

Breakpoints at observation number:
  
  m = 1           320        
m = 2           350 448    
m = 3       218 350 448    
m = 4       218 350 448 546
m = 5   120 218 350 448 546

Corresponding to breakdates:
  
  m = 1                       2017(320)                   
m = 2                       2017(350) 2018(83)          
m = 3             2017(218) 2017(350) 2018(83)          
m = 4             2017(218) 2017(350) 2018(83) 2018(181)
m = 5   2017(120) 2017(218) 2017(350) 2018(83) 2018(181)

Fit:
  
  m   0      1      2      3      4      5     
RSS 934466 550191 254893 183606 125284 124296
BIC   6629   6295   5804   5602   5365   5373
> ci_ts <- confint(bp_ts)
> ci_ts

Confidence intervals for breakpoints
of optimal 5-segment partition: 
  
  Call:
  confint.breakpointsfull(object = bp_ts)

Breakpoints at observation number:
  2.5 % breakpoints 97.5 %
1   217         218    219
2   348         350    351
3   447         448    453
4   545         546    549

Corresponding to breakdates:
  2.5 %     breakpoints 97.5 %   
1 2017(217) 2017(218)   2017(219)
2 2017(348) 2017(350)   2017(351)
3 2018(82)  2018(83)    2018(88) 
4 2018(180) 2018(181)   2018(184)
> plot(Neo)
> lines(bp_ts)
> fm0 <- lm(Neo ~ 1)
> fm1 <- lm(Neo ~ breakfactor(bp_ts, breaks = 1))
> fm2 <- lm(Neo ~ breakfactor(bp_ts, breaks = 2))
> fm3 <- lm(Neo ~ breakfactor(bp_ts, breaks = 3))
> fm4 <- lm(Neo ~ breakfactor(bp_ts, breaks = 4))
> plot(Neo, main = "Gráfico dos breakpoints")
> lines(ts(fitted(fm0), start = 2017, frequency=365), col = 3)
> lines(ts(fitted(fm1), start = 2017, frequency=365), col = 4)
> lines(ts(fitted(fm2), start = 2017, frequency=365), col = 1)
> lines(ts(fitted(fm3), start = 2017, frequency=365), col = 2)
> lines(ts(fitted(fm4), start = 2017, frequency=365), col = 5)
> lines(bp_ts)

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

> ARMA01 <- arima(Neo1, order = c(0,0,1))
> ARMA02 <- arima(Neo1, order = c(0,0,2))
> ARMA03 <- arima(Neo1, order = c(0,0,3))
> ARMA04 <- arima(Neo1, order = c(0,0,4))
> ARMA05 <- arima(Neo1, order = c(0,0,5))
> ARMA06 <- arima(Neo1, order = c(0,0,6))
> ARMA07 <- arima(Neo1, order = c(0,0,7))
> ARMA08 <- arima(Neo1, order = c(0,0,8))
> ARMA09 <- arima(Neo1, order = c(0,0,9))
> ARMA010 <- arima(Neo1, order = c(0,0,10))
> ARMA011 <- arima(Neo1, order = c(0,0,11))
> ARMA012 <- arima(Neo1, order = c(0,0,12))
> ARMA013 <- arima(Neo1, order = c(0,0,13))
> ARMA014 <- arima(Neo1, order = c(0,0,14))
> ARMA015 <- arima(Neo1, order = c(0,0,15))
> ARMA016 <- arima(Neo1, order = c(0,0,16))
> ARMA017 <- arima(Neo1, order = c(0,0,17))
> ARMA018 <- arima(Neo1, order = c(0,0,18))
> ARMA019 <- arima(Neo1, order = c(0,0,19))
> ARMA020 <- arima(Neo1, order = c(0,0,20))
> ARMA021 <- arima(Neo1, order = c(0,0,21))
> ARMA022 <- arima(Neo1, order = c(0,0,22))
> ARIMA011 <- arima(Neo1, order = c(0,1,1))
> ARIMA012 <- arima(Neo1, order = c(0,1,2))
> ARIMA013 <- arima(Neo1, order = c(0,1,3))
> ARIMA014 <- arima(Neo1, order = c(0,1,4))
> ARIMA015 <- arima(Neo1, order = c(0,1,5))
> ARIMA016 <- arima(Neo1, order = c(0,1,6))
> ARIMA017 <- arima(Neo1, order = c(0,1,7))
> ARIMA018 <- arima(Neo1, order = c(0,1,8))
> ARIMA019 <- arima(Neo1, order = c(0,1,9))
> ARIMA0110 <- arima(Neo1, order = c(0,1,10))
> ARIMA0111 <- arima(Neo1, order = c(0,1,11))
> ARIMA0112 <- arima(Neo1, order = c(0,1,12))
> ARIMA0113 <- arima(Neo1, order = c(0,1,13))
> ARIMA0114 <- arima(Neo1, order = c(0,1,14))
> ARIMA0115 <- arima(Neo1, order = c(0,1,15))
> ARIMA0116 <- arima(Neo1, order = c(0,1,16))
> ARIMA0117 <- arima(Neo1, order = c(0,1,17))
> ARIMA0118 <- arima(Neo1, order = c(0,1,18))
> ARIMA0119 <- arima(Neo1, order = c(0,1,19))
> ARIMA0120 <- arima(Neo1, order = c(0,1,20))
> ARIMA0121 <- arima(Neo1, order = c(0,1,21))
> ARIMA0122 <- arima(Neo1, order = c(0,1,22))
> estimacoes <- list(ARMA01, ARMA02, ARMA03, ARMA04, ARMA05, ARMA06, ARMA07, ARMA08, ARMA09, ARMA010, ARMA011, ARMA012, ARMA013, ARMA014, ARMA015, ARMA016, ARMA017, ARMA018, ARMA019, ARMA020, ARMA021, ARMA022,
                     +                    ARIMA011, ARIMA012, ARIMA013, ARIMA014, ARIMA015, ARIMA016, ARIMA017, ARIMA018, ARIMA019, ARIMA0110, ARIMA0111, ARIMA0112, ARIMA0113, ARIMA0114, ARIMA0115, ARIMA0116, ARIMA0117, ARIMA0118, ARIMA0119, ARIMA0120, ARIMA0121, ARIMA0122)
> sapply(estimacoes, AIC)
[1] 3883.088 3879.143 3880.677 3879.983 3873.394 3865.537 3845.975 3840.807
[9] 3838.846 3840.482 3839.877 3840.874 3841.755 3842.653 3844.611 3845.721
[17] 3839.231 3819.499 3821.056 3821.596 3820.168 3814.409 3882.689 3884.621
[25] 3880.887 3882.375 3881.804 3874.997 3866.877 3847.676 3842.629 3840.598
[33] 3842.205 3841.495 3842.394 3843.189 3843.982 3845.918 3846.940 3840.154
[41] 3820.889 3822.369 3822.728 3821.517
> sapply(estimacoes, BIC)
[1] 3896.537 3897.076 3903.092 3906.882 3904.776 3901.402 3886.323 3885.639
[9] 3888.161 3894.279 3898.157 3903.638 3909.001 3914.383 3920.823 3926.417
[17] 3924.410 3909.161 3915.201 3920.224 3923.279 3922.004 3891.652 3898.066
[25] 3898.813 3904.783 3908.693 3906.368 3902.729 3888.011 3887.445 3889.896
[33] 3895.984 3899.756 3905.136 3910.413 3915.688 3922.105 3927.608 3925.304
[41] 3910.520 3916.483 3921.322 3924.593
> AIC <- sapply(estimacoes, AIC)
> BIC <- sapply(estimacoes, BIC)
> Modelo <- c("ARMA01", "ARMA02", "ARMA03", "ARMA04", "ARMA05", "ARMA06", "ARMA07", "ARMA08", "ARMA09", "ARMA010", "ARMA011", "ARMA012", "ARMA013", "ARMA014", "ARMA015", "ARMA016", "ARMA017", "ARMA018", "ARMA019", "ARMA020", "ARMA021", "ARMA022",
              +             "ARIMA011", "ARIMA012", "ARIMA013", "ARIMA014", "ARIMA015", "ARIMA016", "ARIMA017", "ARIMA018", "ARIMA019", "ARIMA0110", "ARIMA0111", "ARIMA0112", "ARIMA0113", "ARIMA0114", "ARIMA0115", "ARIMA0116", "ARIMA0117", "ARIMA0118", "ARIMA0119", "ARIMA0120", "ARIMA0121", "ARIMA0122")
> Resultados <- data.frame(Modelo, AIC, BIC)
> View(Resultados)
> colnames(Resultados) <- c("Modelo","AIC","BIC")
> write.csv(Resultados, file = "c:/Econometria/Resultados.csv")
> ARMA08

Call:
  arima(x = Neo1, order = c(0, 0, 8))

Coefficients:
  ma1      ma2     ma3      ma4     ma5     ma6      ma7      ma8
0.0238  -0.0251  0.0174  -0.0792  0.1139  0.1388  -0.1863  -0.1027
s.e.  0.0398   0.0381  0.0382   0.0382  0.0370  0.0375   0.0387   0.0385
intercept
0.0263
s.e.     0.1584

sigma^2 estimated as 20.16:  log likelihood = -1910.4,  aic = 3840.81
> predict(ARMA08,15)
$`pred`
Time Series:
  Start = c(2018, 290) 
End = c(2018, 304) 
Frequency = 365 
[1]  0.64380240  0.19077370  0.01681514  0.15349664  0.06819718 -0.05533008
[7] -0.11784912 -0.02436226  0.02625854  0.02625854  0.02625854  0.02625854
[13]  0.02625854  0.02625854  0.02625854

$se
Time Series:
  Start = c(2018, 290) 
End = c(2018, 304) 
Frequency = 365 
[1] 4.489490 4.490765 4.492183 4.492860 4.506909 4.535803 4.578423 4.654228 4.677019
[10] 4.677019 4.677019 4.677019 4.677019 4.677019 4.677019

There were 50 or more warnings (use warnings() to see the first 50)
> library(forecast)

Attaching package: 'forecast'

The following object is masked from 'package:aTSA':
  
  forecast

> forecast(ARMA08,15)
Point Forecast     Lo 80    Hi 80     Lo 95    Hi 95
2018.7918     0.64380240 -5.109711 6.397316 -8.155437 9.443042
2018.7945     0.19077370 -5.564373 5.945920 -8.610963 8.992511
2018.7973     0.01681514 -5.740149 5.773779 -8.787701 8.821331
2018.8000     0.15349664 -5.604336 5.911329 -8.652348 8.959341
2018.8027     0.06819718 -5.707639 5.844033 -8.765182 8.901576
2018.8055    -0.05533008 -5.868196 5.757536 -8.945341 8.834681
2018.8082    -0.11784912 -5.985334 5.749635 -9.091392 8.855694
2018.8110    -0.02436226 -5.988996 5.940271 -9.146482 9.097758
2018.8137     0.02625854 -5.967583 6.020100 -9.140531 9.193048
2018.8164     0.02625854 -5.967583 6.020100 -9.140531 9.193048
2018.8192     0.02625854 -5.967583 6.020100 -9.140531 9.193048
2018.8219     0.02625854 -5.967583 6.020100 -9.140531 9.193048
2018.8247     0.02625854 -5.967583 6.020100 -9.140531 9.193048
2018.8274     0.02625854 -5.967583 6.020100 -9.140531 9.193048
2018.8301     0.02625854 -5.967583 6.020100 -9.140531 9.193048
> plot(forecast(ARMA08,5), type="o", xlim=c(2018.75,2018.85), ylim=c(-0.03,0.06))
> grid(col = "black", lty = "dotted")
> estimacoes2 <- list(ARIMA011, ARIMA012, ARIMA013, ARIMA014, ARIMA015, ARIMA016, ARIMA017, ARIMA018, ARIMA019, ARIMA0110, ARIMA0111, ARIMA0112, ARIMA0113, ARIMA0114, ARIMA0115, ARIMA0116, ARIMA0117, ARIMA0118, ARIMA0119, ARIMA0120, ARIMA0121, ARIMA0122)
> sapply(estimacoes2, AIC)
[1] 3882.689 3884.621 3880.887 3882.375 3881.804 3874.997 3866.877 3847.676 3842.629
[10] 3840.598 3842.205 3841.495 3842.394 3843.189 3843.982 3845.918 3846.940 3840.154
[19] 3820.889 3822.369 3822.728 3821.517
> sapply(estimacoes2, BIC)
[1] 3891.652 3898.066 3898.813 3904.783 3908.693 3906.368 3902.729 3888.011 3887.445
[10] 3889.896 3895.984 3899.756 3905.136 3910.413 3915.688 3922.105 3927.608 3925.304
[19] 3910.520 3916.483 3921.322 3924.593
> Modelo2 <- c("ARIMA011", "ARIMA012", "ARIMA013", "ARIMA014", "ARIMA015", "ARIMA016", "ARIMA017", "ARIMA018", "ARIMA019", "ARIMA0110", "ARIMA0111", "ARIMA0112", "ARIMA0113", "ARIMA0114", "ARIMA0115", "ARIMA0116", "ARIMA0117", "ARIMA0118", "ARIMA0119", "ARIMA0120", "ARIMA0121", "ARIMA0122")
> Resultados2 <- data.frame(Modelo2, AIC, BIC)
> View(Resultados2)
> write.csv(Resultados2, file = "c:/Econometria/Resultados2.csv")
> ARMA018

Call:
  arima(x = Neo1, order = c(0, 0, 18))

Coefficients:
  ma1      ma2      ma3      ma4     ma5     ma6      ma7      ma8      ma9
0.0376  -0.0382  -0.0335  -0.1069  0.1287  0.1226  -0.1182  -0.1171  -0.0123
s.e.  0.0381   0.0383   0.0388   0.0394  0.0389  0.0394   0.0409   0.0434   0.0429
ma10    ma11    ma12     ma13    ma14    ma15     ma16    ma17     ma18
0.1024  0.1030  0.0685  -0.0031  0.0189  0.0502  -0.0133  0.1864  -0.2157
s.e.  0.0395  0.0469  0.0453   0.0407  0.0405  0.0410   0.0449  0.0473   0.0422
intercept
0.0254
s.e.     0.1965

sigma^2 estimated as 18.87:  log likelihood = -1889.75,  aic = 3819.5
> predict(ARMA018,15)
$`pred`
Time Series:
  Start = c(2018, 290) 
End = c(2018, 304) 
Frequency = 365 
[1]  0.21143193  0.24833139 -0.06530251  0.03513917 -0.01905077 -0.34760388
[7]  0.02005168 -0.09321384 -0.08430359  0.24432982 -0.36830291  0.67233161
[13] -0.02511240  0.06052527  0.16094585

$se
Time Series:
  Start = c(2018, 290) 
End = c(2018, 304) 
Frequency = 365 
[1] 4.344044 4.347120 4.350285 4.352713 4.377407 4.412982 4.444980 4.474553 4.503371
[10] 4.503689 4.525588 4.547668 4.557398 4.557418 4.558158

> forecast(ARMA018,15)
Point Forecast     Lo 80    Hi 80     Lo 95    Hi 95
2018.7918     0.21143193 -5.355685 5.778549 -8.302738 8.725602
2018.7945     0.24833139 -5.322727 5.819390 -8.271867 8.768530
2018.7973    -0.06530251 -5.640417 5.509812 -8.591705 8.461100
2018.8000     0.03513917 -5.543087 5.613365 -8.496021 8.566299
2018.8027    -0.01905077 -5.628923 5.590822 -8.598610 8.560509
2018.8055    -0.34760388 -6.003068 5.307860 -8.996890 8.301682
2018.8082     0.02005168 -5.676419 5.716523 -8.691949 8.732052
2018.8110    -0.09321384 -5.827584 5.641157 -8.863177 8.676749
2018.8137    -0.08430359 -5.855605 5.686998 -8.910748 8.742141
2018.8164     0.24432982 -5.527379 6.016039 -8.582737 9.071397
2018.8192    -0.36830291 -6.168077 5.431471 -9.238292 8.501687
2018.8219     0.67233161 -5.155740 6.500403 -8.240934 9.585598
2018.8247    -0.02511240 -5.865653 5.815428 -8.957448 8.907224
2018.8274     0.06052527 -5.780041 5.901092 -8.871851 8.992901
2018.8301     0.16094585 -5.680569 6.002461 -8.772880 9.094772
> plot(forecast(ARMA018,5), type="o", xlim=c(2018.75,2018.85), ylim=c(-0.03,0.06))
> grid(col = "black", lty = "dotted")
> plot(forecast(ARIMA018,5), type="o", xlim=c(2018.75,2018.85), ylim=c(-0.03,0.06))
> grid(col = "black", lty = "dotted")
> ARIMA018

Call:
  arima(x = Neo1, order = c(0, 1, 8))

Coefficients:
  ma1      ma2     ma3      ma4     ma5     ma6      ma7     ma8
-1.0074  -0.0114  0.0464  -0.1199  0.2034  0.0261  -0.3255  0.1883
s.e.   0.0418   0.0556  0.0552   0.0575  0.0596  0.0527   0.0567  0.0402

sigma^2 estimated as 20.41:  log likelihood = -1914.84,  aic = 3847.68
> predict(ARIMA018,15)
$`pred`
Time Series:
  Start = c(2018, 290) 
End = c(2018, 304) 
Frequency = 365 
[1]  0.56214329 -0.07157611  0.04797049  0.11605148  0.05601014  0.01045521
[7] -0.07078915  0.02598267  0.02598267  0.02598267  0.02598267  0.02598267
[13]  0.02598267  0.02598267  0.02598267

$se
Time Series:
  Start = c(2018, 290) 
End = c(2018, 304) 
Frequency = 365 
[1] 4.521413 4.521485 4.522156 4.524060 4.542626 4.571023 4.613888 4.690333 4.690333
[10] 4.690333 4.690333 4.690333 4.690333 4.690333 4.690333

> forecast(ARIMA018,15)
Point Forecast     Lo 80    Hi 80     Lo 95    Hi 95
2018.7918     0.56214329 -5.232280 6.356567 -8.299663 9.423950
2018.7945    -0.07157611 -5.866093 5.722940 -8.933524 8.790372
2018.7973     0.04797049 -5.747406 5.843347 -8.815293 8.911234
2018.8000     0.11605148 -5.681765 5.913868 -8.750943 8.983046
2018.8027     0.05601014 -5.765600 5.877620 -8.847374 8.959394
2018.8055     0.01045521 -5.847546 5.868457 -8.948585 8.969495
2018.8082    -0.07078915 -5.983725 5.842147 -9.113844 8.972266
2018.8110     0.02598267 -5.984921 6.036886 -9.166901 9.218867
2018.8137     0.02598267 -5.984921 6.036886 -9.166901 9.218867
2018.8164     0.02598267 -5.984921 6.036886 -9.166901 9.218867
2018.8192     0.02598267 -5.984921 6.036886 -9.166901 9.218867
2018.8219     0.02598267 -5.984921 6.036886 -9.166901 9.218867
2018.8247     0.02598267 -5.984921 6.036886 -9.166901 9.218867
2018.8274     0.02598267 -5.984921 6.036886 -9.166901 9.218867
2018.8301     0.02598267 -5.984921 6.036886 -9.166901 9.218867
> plot(forecast(ARIMA018,5), type="o", xlim=c(2018.75,2018.85), ylim=c(-0.03,0.06))
> grid(col = "black", lty = "dotted")
> predict(ARIMA018,15)
$`pred`
Time Series:
  Start = c(2018, 290) 
End = c(2018, 304) 
Frequency = 365 
[1]  0.56214329 -0.07157611  0.04797049  0.11605148  0.05601014  0.01045521
[7] -0.07078915  0.02598267  0.02598267  0.02598267  0.02598267  0.02598267
[13]  0.02598267  0.02598267  0.02598267

$se
Time Series:
  Start = c(2018, 290) 
End = c(2018, 304) 
Frequency = 365 
[1] 4.521413 4.521485 4.522156 4.524060 4.542626 4.571023 4.613888 4.690333 4.690333
[10] 4.690333 4.690333 4.690333 4.690333 4.690333 4.690333

> forecast(ARIMA018,15)
Point Forecast     Lo 80    Hi 80     Lo 95    Hi 95
2018.7918     0.56214329 -5.232280 6.356567 -8.299663 9.423950
2018.7945    -0.07157611 -5.866093 5.722940 -8.933524 8.790372
2018.7973     0.04797049 -5.747406 5.843347 -8.815293 8.911234
2018.8000     0.11605148 -5.681765 5.913868 -8.750943 8.983046
2018.8027     0.05601014 -5.765600 5.877620 -8.847374 8.959394
2018.8055     0.01045521 -5.847546 5.868457 -8.948585 8.969495
2018.8082    -0.07078915 -5.983725 5.842147 -9.113844 8.972266
2018.8110     0.02598267 -5.984921 6.036886 -9.166901 9.218867
2018.8137     0.02598267 -5.984921 6.036886 -9.166901 9.218867
2018.8164     0.02598267 -5.984921 6.036886 -9.166901 9.218867
2018.8192     0.02598267 -5.984921 6.036886 -9.166901 9.218867
2018.8219     0.02598267 -5.984921 6.036886 -9.166901 9.218867
2018.8247     0.02598267 -5.984921 6.036886 -9.166901 9.218867
2018.8274     0.02598267 -5.984921 6.036886 -9.166901 9.218867
2018.8301     0.02598267 -5.984921 6.036886 -9.166901 9.218867
> plot(forecast(ARIMA018,5), type="o", xlim=c(2018.75,2018.85), ylim=c(-0.03,0.06))
> grid(col = "black", lty = "dotted")
> plot(forecast(ARIMA018,5), type="o", xlim=c(2018.75,2018.85), ylim=c(-2,2))
> grid(col = "black", lty = "dotted")
> plot(forecast(ARIMA018,10), type="o", xlim=c(2018.75,2018.85), ylim=c(-2,2))
> grid(col = "black", lty = "dotted")
> plot(forecast(ARIMA018,15), type="o", xlim=c(2018.75,2018.85), ylim=c(-2,2))
> grid(col = "black", lty = "dotted")
> predict(ARIMA018,8)
$`pred`
Time Series:
  Start = c(2018, 290) 
End = c(2018, 297) 
Frequency = 365 
[1]  0.56214329 -0.07157611  0.04797049  0.11605148  0.05601014  0.01045521
[7] -0.07078915  0.02598267

$se
Time Series:
  Start = c(2018, 290) 
End = c(2018, 297) 
Frequency = 365 
[1] 4.521413 4.521485 4.522156 4.524060 4.542626 4.571023 4.613888 4.690333

> ARIMA018

Call:
  arima(x = Neo1, order = c(0, 1, 8))

Coefficients:
  ma1      ma2     ma3      ma4     ma5     ma6      ma7     ma8
-1.0074  -0.0114  0.0464  -0.1199  0.2034  0.0261  -0.3255  0.1883
s.e.   0.0418   0.0556  0.0552   0.0575  0.0596  0.0527   0.0567  0.0402

sigma^2 estimated as 20.41:  log likelihood = -1914.84,  aic = 3847.68
> plot(forecast(ARIMA018,8), type="o", xlim=c(2018.75,2018.85), ylim=c(-2,2))
> grid(col = "black", lty = "dotted")
> plot(forecast(ARIMA018,8), type="o", xlim=c(2018.75,2018.85), ylim=c(-2,1))
> grid(col = "black", lty = "dotted")
> plot(forecast(ARIMA018,8), type="o", xlim=c(2017,2019), ylim=c(-2,2))
> grid(col = "black", lty = "dotted")
> plot(forecast(ARIMA018,8), type="o", xlim=c(2018.9,2019), ylim=c(-2,2))
> grid(col = "black", lty = "dotted")

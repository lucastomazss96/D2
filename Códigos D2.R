remove.packages("readxl")
install.packages("readxl", dependencies = T)
install.packages("strucchange")
remove.packages("aTSA")
install.packages("aTSA", dependencies = T)

library(strucchange)
library(readxl)
library(aTSA)
library(tseries)
library("urca")

NEO <- na.omit(read_excel("C:/Econometria/Neo.xls"))

Neo <-  ts(NEO$Close, start = 2017, frequency = 365)

plot(Neo)

#Verificar se a Série é Estacionária

#Criar FAC  e FACP

acf(NEO$Close,lend = 2, lwd = 5,col = "darkblue", main = "Função Autocorrelação - FAC")              #Melhorando aspecto da FAC
axis(1, tck = 1, col = "lightgrey", lty = "dotted")

pacf(NEO$Close,lend = 60, lwd = 5,col = "darkblue", main = "Função Autocorrelação Parcial - FACP")   #Melhorando aspecto da FACP
axis(1, tck = 1, col = "lightgrey", lty = "dotted")                                       #Nesse caso o professor vai considerar apenas a primeira ordem.

#Teste ADF (será estácionária se o t estatístico estiver "fora" da área de aceitação)

ADF1 <- ur.df(Neo, "none", lags = 1)
summary (ADF1)

#Teste Philips-Perron (será estácionária se o p-valor for "menor" que 0.05)

pp.test(Neo)

#Teste KPSS (será estacionária se o p-valor for "maior" que 0.05)

kpss.test(Neo)

#Teste Bai Perron

bp_ts <- breakpoints(Neo ~ 1)

bp_ts

summary(bp_ts)

#ci_ts <- confint(bp_ts)

plot(Neo)               
lines(bp_ts)            #Gráfico com os breakpoints


#Gráfico com as linhas de tendências para os três períodos

fm0 <- lm(Neo ~ 1)
fm1 <- lm(Neo ~ breakfactor(bp_ts, breaks = 1))
fm2 <- lm(Neo ~ breakfactor(bp_ts, breaks = 2))
fm3 <- lm(Neo ~ breakfactor(bp_ts, breaks = 3))
fm4 <- lm(Neo ~ breakfactor(bp_ts, breaks = 4))
plot(Neo, main = "Gráfico dos breakpoints")
lines(ts(fitted(fm0), start = 2017, frequency=365), col = 3)
lines(ts(fitted(fm1), start = 2017, frequency=365), col = 4)
lines(ts(fitted(fm2), start = 2017, frequency=365), col = 1)
lines(ts(fitted(fm3), start = 2017, frequency=365), col = 2)
lines(ts(fitted(fm4), start = 2017, frequency=365), col = 5)
lines(bp_ts)

#Como em nenhum dos casos deu estacionariedade, vamos diferenciar a série:

Ordem1 <- diff(NEO$Close)
Neo1 <- ts(Ordem1, start = 2017, frequency = 365)
plot(Neo1)

#Verificar se a Série se tornou Estacionária

#FAC e FACP

acf(Ordem1,lend = 2, lwd = 5,col = "darkblue",main = "Função Autocorrelação - FAC", lags = 50)              #Melhorando aspecto da FAC
axis(1, tck = 1, col = "lightgrey", lty = "dotted")

pacf(Ordem1,lend = 60, lwd = 5,col = "darkblue", main = "Função Autocorrelação Parcial - FACP")   #Melhorando aspecto da FACP
axis(1, tck = 1, col = "lightgrey", lty = "dotted")

#Teste ADF

ADF2 <- ur.df(Neo1, "none", lags = 1)
summary (ADF2)

#Teste Philips-Perron

pp.test(Neo1)

#Teste KPSS

kpss.test(Neo1)

#Verificar quais ordens são as melhores

#Estimando Regressões e Tabelando Resultados

ARMA01 <- arima(Neo1, order = c(0,0,1))
ARMA02 <- arima(Neo1, order = c(0,0,2))
ARMA03 <- arima(Neo1, order = c(0,0,3))
ARMA04 <- arima(Neo1, order = c(0,0,4))
ARMA05 <- arima(Neo1, order = c(0,0,5))
ARMA06 <- arima(Neo1, order = c(0,0,6))
ARMA07 <- arima(Neo1, order = c(0,0,7))
ARMA08 <- arima(Neo1, order = c(0,0,8))
ARMA09 <- arima(Neo1, order = c(0,0,9))
ARMA010 <- arima(Neo1, order = c(0,0,10))
ARMA011 <- arima(Neo1, order = c(0,0,11))
ARMA012 <- arima(Neo1, order = c(0,0,12))
ARMA013 <- arima(Neo1, order = c(0,0,13))
ARMA014 <- arima(Neo1, order = c(0,0,14))
ARMA015 <- arima(Neo1, order = c(0,0,15))
ARMA016 <- arima(Neo1, order = c(0,0,16))
ARMA017 <- arima(Neo1, order = c(0,0,17))
ARMA018 <- arima(Neo1, order = c(0,0,18))
ARMA019 <- arima(Neo1, order = c(0,0,19))
ARMA020 <- arima(Neo1, order = c(0,0,20))
ARMA021 <- arima(Neo1, order = c(0,0,21))
ARMA022 <- arima(Neo1, order = c(0,0,22))

ARIMA011 <- arima(Neo1, order = c(0,1,1))
ARIMA012 <- arima(Neo1, order = c(0,1,2))
ARIMA013 <- arima(Neo1, order = c(0,1,3))
ARIMA014 <- arima(Neo1, order = c(0,1,4))
ARIMA015 <- arima(Neo1, order = c(0,1,5))
ARIMA016 <- arima(Neo1, order = c(0,1,6))
ARIMA017 <- arima(Neo1, order = c(0,1,7))
ARIMA018 <- arima(Neo1, order = c(0,1,8))
ARIMA019 <- arima(Neo1, order = c(0,1,9))
ARIMA0110 <- arima(Neo1, order = c(0,1,10))
ARIMA0111 <- arima(Neo1, order = c(0,1,11))
ARIMA0112 <- arima(Neo1, order = c(0,1,12))
ARIMA0113 <- arima(Neo1, order = c(0,1,13))
ARIMA0114 <- arima(Neo1, order = c(0,1,14))
ARIMA0115 <- arima(Neo1, order = c(0,1,15))
ARIMA0116 <- arima(Neo1, order = c(0,1,16))
ARIMA0117 <- arima(Neo1, order = c(0,1,17))
ARIMA0118 <- arima(Neo1, order = c(0,1,18))
ARIMA0119 <- arima(Neo1, order = c(0,1,19))
ARIMA0120 <- arima(Neo1, order = c(0,1,20))
ARIMA0121 <- arima(Neo1, order = c(0,1,21))
ARIMA0122 <- arima(Neo1, order = c(0,1,22))

estimacoes <- list(ARMA01, ARMA02, ARMA03, ARMA04, ARMA05, ARMA06, ARMA07, ARMA08, ARMA09, ARMA010, ARMA011, ARMA012, ARMA013, ARMA014, ARMA015, ARMA016, ARMA017, ARMA018, ARMA019, ARMA020, ARMA021, ARMA022,
                   ARIMA011, ARIMA012, ARIMA013, ARIMA014, ARIMA015, ARIMA016, ARIMA017, ARIMA018, ARIMA019, ARIMA0110, ARIMA0111, ARIMA0112, ARIMA0113, ARIMA0114, ARIMA0115, ARIMA0116, ARIMA0117, ARIMA0118, ARIMA0119, ARIMA0120, ARIMA0121, ARIMA0122)      #Cria uma lista com os estimadores
sapply(estimacoes, AIC)                 #Aplica o comando AIC na lista
sapply(estimacoes, BIC)                 #Aplica o comando BIC na lista

#Criação de tabela com resultados - Extra
AIC <- sapply(estimacoes, AIC) 
BIC <- sapply(estimacoes, BIC)
Modelo <- c("ARMA01", "ARMA02", "ARMA03", "ARMA04", "ARMA05", "ARMA06", "ARMA07", "ARMA08", "ARMA09", "ARMA010", "ARMA011", "ARMA012", "ARMA013", "ARMA014", "ARMA015", "ARMA016", "ARMA017", "ARMA018", "ARMA019", "ARMA020", "ARMA021", "ARMA022",
            "ARIMA011", "ARIMA012", "ARIMA013", "ARIMA014", "ARIMA015", "ARIMA016", "ARIMA017", "ARIMA018", "ARIMA019", "ARIMA0110", "ARIMA0111", "ARIMA0112", "ARIMA0113", "ARIMA0114", "ARIMA0115", "ARIMA0116", "ARIMA0117", "ARIMA0118", "ARIMA0119", "ARIMA0120", "ARIMA0121", "ARIMA0122")

Resultados <- data.frame(Modelo, AIC, BIC)
View(Resultados)
colnames(Resultados) <- c("Modelo","AIC","BIC")

#Previsões

predict(ARIMA018,15)

library(forecast)
forecast(ARIMA018,15)

plot(forecast(ARIMA018,15), type="o", xlim=c(2018.75,2018.85), ylim=c(-2,2))
grid(col = "black", lty = "dotted")

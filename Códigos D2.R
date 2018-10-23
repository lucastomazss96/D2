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

#Como em nenhum dos casos deu estacionariedade, vamos diferenciar a série:

Ordem1 <- diff(NEO$Close)
Neo1 <- ts(Ordem1, start = 2017, frequency = 365)
plot(Neo1)

#Verificar se a Série se tornou Estacionária

#FAC e FACP

acf(Ordem1,lend = 2, lwd = 5,col = "darkblue",main = "Função Autocorrelação - FAC")              #Melhorando aspecto da FAC
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
##############
#Verificar quais ordens são as melhores

#Estimando Regressões e Tabelando Resultados - Exemplo

AR1 <- arima(Neo1, order = c(1,0,0))
AR2 <- arima(Neo1, order = c(2,0,0))
AR3 <- arima(Neo1, order = c(3,0,0))
AR4 <- arima(Neo1, order = c(4,0,0))
AR5 <- arima(Neo1, order = c(5,0,0))
AR6 <- arima(Neo1, order = c(6,0,0))
AR7 <- arima(Neo1, order = c(7,0,0))
AR8 <- arima(Neo1, order = c(8,0,0))
AR9 <- arima(Neo1, order = c(9,0,0))

MA1 <- arima(Neo1, order = c(0,0,1))
MA2 <- arima(Neo1, order = c(0,0,2))
MA3 <- arima(Neo1, order = c(0,0,3))
MA4 <- arima(Neo1, order = c(0,0,4))
MA5 <- arima(Neo1, order = c(0,0,5))
MA6 <- arima(Neo1, order = c(0,0,6))
MA7 <- arima(Neo1, order = c(0,0,7))
MA8 <- arima(Neo1, order = c(0,0,8))
MA9 <- arima(Neo1, order = c(0,0,9))

ARMA11 <- arima(Neo1, order = c(1,0,1))
ARMA12 <- arima(Neo1, order = c(1,0,2))
ARMA13 <- arima(Neo1, order = c(1,0,3))
ARMA14 <- arima(Neo1, order = c(1,0,4))
ARMA15 <- arima(Neo1, order = c(1,0,5))
ARMA16 <- arima(Neo1, order = c(1,0,6))
ARMA17 <- arima(Neo1, order = c(1,0,7))
ARMA18 <- arima(Neo1, order = c(1,0,8))
ARMA19 <- arima(Neo1, order = c(1,0,9))

ARMA21 <- arima(Neo1, order = c(2,0,1))
ARMA22 <- arima(Neo1, order = c(2,0,2))
ARMA23 <- arima(Neo1, order = c(2,0,3))
ARMA24 <- arima(Neo1, order = c(2,0,4))
ARMA25 <- arima(Neo1, order = c(2,0,5))
ARMA26 <- arima(Neo1, order = c(2,0,6))
ARMA27 <- arima(Neo1, order = c(2,0,7))
ARMA28 <- arima(Neo1, order = c(2,0,8))
ARMA29 <- arima(Neo1, order = c(2,0,9))

estimacoes <- list(AR1, AR2, MA1, MA2, MA3, MA4, MA5, MA6, MA7, MA8, MA9, 
                   ARMA11,ARMA12, ARMA13, ARMA14,ARMA15, ARMA16,ARMA17,ARMA18,ARMA19,
                   ARMA21,ARMA22,ARMA23,ARMA24,ARMA25,ARMA26,ARMA27,ARMA28,ARMA29)      #Cria uma lista com os estimadores
sapply(estimacoes, AIC)                 #Aplica o comando AIC na lista
sapply(estimacoes, BIC)                 #Aplica o comando BIC na lista

#Exemplo de criação de tabela com resultados - Extra
AIC <- sapply(estimacoes, AIC) 
BIC <- sapply(estimacoes, BIC)
Modelo <- c("AR1", "AR2", "MA1", "MA2", "MA3", "MA4", "MA5", "MA6", "MA7", "MA8", "MA9", "ARMA11","ARMA12", "ARMA13", "ARMA14","ARMA15", "ARMA16","ARMA17","ARMA18","ARMA19","ARMA21","ARMA22","ARMA23","ARMA24","ARMA25","ARMA26","ARMA27","ARMA28","ARMA29")

Resultados <- data.frame(Modelo, AIC, BIC)
View(Resultados)
colnames(Resultados) <- c("Modelo","AIC","BIC")
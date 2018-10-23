                    #Aula 14 - Quebra Estrural e Bolhas
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

acf(NEO$Close,lend=2, lwd=5,col="darkblue",main= "Função Autocorrelação - FAC")              #Melhorando aspecto da FAC
axis(1,tck = 1, col = "lightgrey", lty = "dotted")

pacf(NEO$Close,lend=60, lwd=5,col="darkblue",main= "Função Autocorrelação Parcial - FACP")   #Melhorando aspecto da FACP
axis(1,tck = 1, col = "lightgrey", lty = "dotted")                                           #Nesse caso o professor vai considerar apenas a primeira ordem.

#Teste ADF

L <- ur.df(Neo, "none", lags = 1)
summary (L)

#Teste Philips-Perron

pp.test(Neo)

#Teste KPSS

kpss.test(Neo)

#Se não for estacionária, diferenciar a série

IntOrdem1 <- diff(NEO$Close)
IntegradaOrdem1 <- ts(IntOrdem1, start = 2017, frequency = 365)
plot(IntegradaOrdem1)

#Verificar se a Série se tornou Estacionária

#FAC e FACP

acf(IntOrdem1,lend=2, lwd=5,col="darkblue",main= "Função Autocorrelação - FAC")              #Melhorando aspecto da FAC
axis(1,tck = 1, col = "lightgrey", lty = "dotted")

pacf(IntOrdem1,lend=60, lwd=5,col="darkblue",main= "Função Autocorrelação Parcial - FACP")   #Melhorando aspecto da PAC
axis(1,tck = 1, col = "lightgrey", lty = "dotted")

#Teste ADF
ll <- ur.df(IntegradaOrdem1, "none", lags = 1)
summary (ll)

#Teste Philips-Perron
pp.test(IntegradaOrdem1)

#Teste KPSS
kpss.test(IntegradaOrdem1)


#Verificar quais ordens são as melhores

#Estimando Regressões e Tabelando Resultados - Exemplo

AR2 <- arima(var_PIB, order = c(2,0,0))

MA2 <- arima(var_PIB, order = c(0,0,2))
MA3 <- arima(var_PIB, order = c(0,0,3))
MA4 <- arima(var_PIB, order = c(0,0,4))
MA5 <- arima(var_PIB, order = c(0,0,5))
MA6 <- arima(var_PIB, order = c(0,0,6))
MA7 <- arima(var_PIB, order = c(0,0,7))
MA8 <- arima(var_PIB, order = c(0,0,8))
MA9 <- arima(var_PIB, order = c(0,0,9))

ARMA12 <- arima(var_PIB, order = c(1,0,2))
ARMA13 <- arima(var_PIB, order = c(1,0,3))
ARMA14 <- arima(var_PIB, order = c(1,0,4))
ARMA15 <- arima(var_PIB, order = c(1,0,5))
ARMA16 <- arima(var_PIB, order = c(1,0,6))
ARMA17 <- arima(var_PIB, order = c(1,0,7))
ARMA18 <- arima(var_PIB, order = c(1,0,8))
ARMA19 <- arima(var_PIB, order = c(1,0,9))

ARMA21 <- arima(var_PIB, order = c(2,0,1))
ARMA22 <- arima(var_PIB, order = c(2,0,2))
ARMA23 <- arima(var_PIB, order = c(2,0,3))
ARMA24 <- arima(var_PIB, order = c(2,0,4))
ARMA25 <- arima(var_PIB, order = c(2,0,5))
ARMA26 <- arima(var_PIB, order = c(2,0,6))
ARMA27 <- arima(var_PIB, order = c(2,0,7))
ARMA28 <- arima(var_PIB, order = c(2,0,8))
ARMA29 <- arima(var_PIB, order = c(2,0,9))

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

#Efetuar teste ARCH-LM para o melhor modelo

arch.test(melhor_modelo)

#Modelando a Variância


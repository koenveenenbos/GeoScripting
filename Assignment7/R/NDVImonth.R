#Koen Veenenbos & Tim jak team JakVeenenbos
#January 2017

CalcNDVI <- function(LSData, month, MunData){
  extract(LSData[[month]]*0.0001, MunData, fun = mean, na.rm=TRUE, sp = TRUE)
}
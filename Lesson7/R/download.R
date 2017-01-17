#Koen Veenenbos & Tim jak team JakVeenenbos
#January 2017

down_unzip <- function(link, path){
  download.file(url = link, destfile = path, method = "auto")
  unzip(path, exdir = "Data")
}
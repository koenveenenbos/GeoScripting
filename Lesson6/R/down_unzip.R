# Koen Veenenbos & Tim Jak
# Team JakVeenenbos
# 16-01-2017

down_unzip = function(down_url, destname){
  download.file(url = down_url, destfile = destname, method="auto")
  unzip(destname, exdir = "data")
}


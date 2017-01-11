# Koen Veenenbos & Tim Jak
# January 2017

# Source functions
source('R/checkleapyear.R')

leap = function(year){
  checkleapyear(year)
}

# test year
leap(2004)

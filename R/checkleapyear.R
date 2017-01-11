
result = FALSE

# check if the given year is numeric
checkleapyear = function(year) {
  if (!is.numeric(year))
    result = "Error: argument of class numeric expected"

# if it's numeric, check if the year is below 1582    
  else if (year < 1582)
    result = warning(paste(year, "is out of the valid range")) 

# if not check if it is a leapyear  
  else {
    if (year %% 4 == 0) 
    {result = TRUE } 
    
    if (year %% 100 == 0) 
    {result= FALSE}
    
    if (year %% 400 == 0) 
    {result = TRUE}
  }
  return(result)
}

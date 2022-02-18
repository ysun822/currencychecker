#' Get currency exchange rate of the base currency in a past time period input by the user.
#' 
#' 
#' @details This function need the user input a history time and the base currency,aim currency
#' for getting the currency exchange rate at that time.
#'
#' @param time String with the date. The format should be "yyyy-mm-dd", for example "2021-12-31"
#' 
#' @param base String with the code of the base currency. Defaults to CAD, the canadian dollars. 
#' @param aim String with the code of the aim currency. Defaults to CAD, the canadian dollars. 

#' @return It will return  values of the exchange rate
#' 
#' @examples \dontrun{
#' currency_time_series("2021-12-15", "USD","CHN")
#' }
#' @references \url{https://exchangerate.host/#/}



install.packages("jsonlite")
library(jsonlite)
currency_code_vector<-c('USD','JPY','BGN','CZK','DKK','GBP','HUF','PLN','RON','SEK','CHF','ISK','NOK','HRK','RUB','TRY','AUD','BRL','CAD','CNY','HKD','IDR','ILS','INR','KRW','MXN','MYR','NZD','PHP','SGD','THB','ZAR','EUR','AED','AFN','ALL','ARS','BAM','BBD','BDT','BHD','BIF','BMD','BND','BOB','BSD','BWP','BZD','CLP','COP','CRC','CUP','CVE','DJF','DOP','DZD','EGP','ETB','FJD','GHS','GNF','GTQ','HNL','HTG','IQD','JMD','JOD','KES','KHR','KWD','KYD','KZT','LAK','LBP','LKR','LSL','LYD','MAD','MDL','MGA','MKD','MMK','MOP','MUR','MVR','MWK','NAD','NGN','NIO','NPR','OMR','PAB','PEN','PGK','PKR','PYG','QAR','RSD','RWF','SAR','SCR','SDG','SOS','SVC','SZL','TND','TTD','TWD','TZS','UAH','UGX','UYU','UZS','VND','XAF','XOF','XPF','ZMW')

currency_time_history <- function(time,base="CAD",aim="CAD") {
  if(base %in% currency_code_vector == FALSE){
    warning("Invalid base currency name!")
    return ("Error")
  }
  if(aim %in% currency_code_vector == FALSE){
    warning("Invalid aim currency name!")
    return ("Error")
  }
  url<-paste('https://api.exchangerate.host/',time,'&base=',base,"&places=2",sep="")
  data <- fromJSON(url)
  
  if(data$success!=TRUE){
    warning("Error in connecting to the API!")
    return ("Error")
  }
  if(length(data$rates)==0){
    warning("Error in the parameter, please check!")
    return ("Error")
  }
  
  return (data$rate[[aim]])
}


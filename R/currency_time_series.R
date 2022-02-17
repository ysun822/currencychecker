#' Get currency exchange rate of the base currency in the time series period input by the user.
#' 
#' 
#' @details This function need the user input the start date and the end date and the base currency 
#' for getting the dataframe of the currency exchange rate during the time period.
#'
#' @param start String with the start date. The format should be "yyyy-mm-dd", for example "2021-12-31"
#' 
#' @param end  String with the end date. The format should be "yyyy-mm-dd", for example "2021-12-31"
#' 
#' @param base String with the code of the base currency. Defaults to CAD, the canadian dollars. 
#' 
#' @return It will return a dataframe of the currency exchange rate of the base currency in the time period. 
#' If there is an error, it will return error and get the error message. 
#' 
#' @return the column will be the specific date currency exchange rate and the row will be the aim currency for that exchange rate. 
#' @examples \dontrun{
#' currency_time_series("2021-12-12", "2021-12-15", "USD")
#' currency_time_series("2021-01-01", "2022-01-01")
#' }
#' @references \url{https://exchangerate.host/#/}




library(jsonlite)
currency_code_vector<-c('USD','JPY','BGN','CZK','DKK','GBP','HUF','PLN','RON','SEK','CHF','ISK','NOK','HRK','RUB','TRY','AUD','BRL','CAD','CNY','HKD','IDR','ILS','INR','KRW','MXN','MYR','NZD','PHP','SGD','THB','ZAR','EUR','AED','AFN','ALL','ARS','BAM','BBD','BDT','BHD','BIF','BMD','BND','BOB','BSD','BWP','BZD','CLP','COP','CRC','CUP','CVE','DJF','DOP','DZD','EGP','ETB','FJD','GHS','GNF','GTQ','HNL','HTG','IQD','JMD','JOD','KES','KHR','KWD','KYD','KZT','LAK','LBP','LKR','LSL','LYD','MAD','MDL','MGA','MKD','MMK','MOP','MUR','MVR','MWK','NAD','NGN','NIO','NPR','OMR','PAB','PEN','PGK','PKR','PYG','QAR','RSD','RWF','SAR','SCR','SDG','SOS','SVC','SZL','TND','TTD','TWD','TZS','UAH','UGX','UYU','UZS','VND','XAF','XOF','XPF','ZMW')

currency_time_series <- function(start,end,base="CAD") {
  if(base %in% currency_code_vector == FALSE){
    warning("Invalid base currency name!")
    return ("Error")
  }
  url<-paste('https://api.exchangerate.host/timeseries?start_date=',start,'&end_date=',end,'&base=',base,"&places=2",sep="")
  data <- fromJSON(url)
  
  if(data$success!=TRUE){
    warning("Error in connecting to the API!")
    return ("Error")
  }
  if(length(data$rates)==0){
    warning("Error in the parameter, please check!")
    return ("Error")
  }
  
  data<- as.data.frame(do.call(cbind, data$rates))
  return (data)
}


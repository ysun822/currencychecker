#' obtain the the latest foreign exchange reference rates of a list of currencies 
#' on a specific base  at a specific amount on daily basis from the Exchange rates API. 
#' 
#' @details This function need the user input the base currency, symbols the list of
#'  currencies, and the amount for getting the reference rates.
#'
#' @param base Enter the three-letter currency code of your preferred base currency (e.g., base='USD'),
#' the default is base='EUR'.
#' 
#' @param symbols Enter a list of comma-separated currency codes to limit output currencies (e.g., symbols=c('USD','EUR','CZK')),
#' the default is all of the 170+ currencies.
#' 
#' @param amount The amount to be converted (e.g., amount=1200), the default is amount=1.
#'
#' @return It will return a dataframe with the columns `Date`, `Base`, `Rates`, and `Amount`.
#' If there is an error, it will return error and get the error message. 
#' 
#' @examples \dontrun{
#' latest_rates('CNH','USD,EUR,CAD',5000)
#' latest_rates(symbols='CAD,USD,CNH')
#' }
#' @references \url{https://exchangerate.host/#/}
install.packages("tidyr")
library(jsonlite)
library(tidyr)
library(ggplot2)

currency_code_vector<-c('AED', 'AFN', 'ALL', 'AMD', 'ANG', 'AOA', 'ARS', 'AUD', 'AWG', 'AZN',
                        'BAM', 'BBD', 'BDT', 'BGN', 'BHD', 'BIF', 'BMD', 'BND', 'BOB', 'BRL', 'BSD', 'BTC', 'BTN', 'BWP', 'BYN', 'BZD',
                        'CAD', 'CDF', 'CHF', 'CLF', 'CLP', 'CNH', 'CNY', 'COP','CRC', 'CUC', 'CUP','CVE','CZK',
                        'DJF', 'DKK', 'DOP', 'DZD',
                        'EGP', 'ERN', 'ETB', 'EUR',
                        'FJD', 'FKP',
                        'GBP', 'GEL', 'GGP', 'GHS', 'GIP', 'GMD', 'GNF', 'GTQ', 'GYD',
                        'HKD', 'HNL', 'HRK', 'HTG', 'HUF', 
                        'IDR', 'ILS', 'IMP', 'INR', 'IQD', 'IRR', 'ISK',
                        'JEP', 'JMD', 'JOD', 'JPY',
                        'KES', 'KGS', 'KHR', 'KMF', 'KPW', 'KRW', 'KWD', 'KYD', 'KZT',
                        'LAK', 'LBP', 'LKR', 'LRD', 'LSL', 'LYD',
                        'MAD', 'MDL', 'MGA', 'MKD', 'MMK', 'MNT', 'MOP', 'MRU', 'MUR', 'MVR', 'MWK', 'MXN', 'MYR', 'MZN',
                        'NAD', 'NGN', 'NIO', 'NOK', 'NPR', 'NZD', 
                        'OMR',
                        'PAB', 'PEN', 'PGK', 'PHP', 'PKR', 'PLN', 'PYG',
                        'QAR',
                        'RON', 'RSD', 'RUB', 'RWF',
                        'SAR', 'SBD', 'SCR', 'SDG', 'SEK', 'SGD', 'SHP', 'SLL', 'SOS', 'SRD', 'SSP', 'STD', 'STN', 'SVC', 'SYP', 'SZL',
                        'THB', 'TJS', 'TMT', 'TND', 'TOP', 'TRY', 'TTD', 'TWD', 'TZS',
                        'UAH', 'UGX', 'USD', 'UYU', 'UZS', 
                        'VES', 'VND', 'VUV', 
                        'WST', 
                        'XAF', 'XAG', 'XAU', 'XCD', 'XDR', 'XOF', 'XPD', 'XPF', 'XPT',
                        'YER',
                        'ZAR', 'ZMW', 'ZWL')

latest_rates <- function(base="EUR", symbols='', amount=1) {
  if(base %in% currency_code_vector == FALSE){
    warning("Invalid base currency name in base!")
    return ("Error")
  }
  
  if(all(unlist(strsplit(symbols, ",")) %in% currency_code_vector) == FALSE){
    warning("Invalid currency names in symbols!")
    return ("Error")
  }
  
  if(is.numeric(amount) == FALSE){
    warning("Input a number!")
    return ("Error")
  }
  
  url<-paste('https://api.exchangerate.host/latest?base=',base,'&symbols=',symbols,'&amount=',amount,"&places=2",sep="")
  data <- fromJSON(url)
  
  if(data$success!=TRUE){
    warning("Error in connecting to the API!")
    return ("Error")
  }
  
  if(length(data$rates)==0){
    warning("Error in the parameter, please check!")
    return ("Error")
  }
  
  data <- data.frame('Date' = data$date, 'Base' = base, 'Rates' = do.call(rbind, data$rates), 'Amount' = amount)
  return (data)
}




















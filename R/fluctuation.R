#' @name fluctuation
#'
#' @title Currency Fluctuate
#'
#' @description Retrieve information about how a list of currencies fluctuate on a specific base
#' at a specific amount on a day-to-day basis from the Exchange rates API.
#'
#' @details This function need the user input the start date, the end date, the base
#' currency, symbols the list of currencies, and the amount for getting the reference rates.
#'
#' @param start_date The start date of your preferred fluctuation timeframe (e.g. start='2020-01-01').
#'
#' @param end_date The end date of your preferred fluctuation timeframe (e.g. end='2020-01-01').
#'
#' @param base Changing base currency. Enter the three-letter currency code of your preferred base currency (e.g. base='USD').
#' The default is base='EUR'.
#'
#' @param amount The amount to be converted (e.g., amount=1200), the default is amount=1.
#' The default is amount=1.
#'
#' @param symbols Enter a list of comma-separated currency codes to limit output currencies (e.g., symbols=c('USD','EUR','CZK')).
#' The default is all of the 170+ currencies.
#'
#' @param amount The amount to be converted (e.g., amount=1200). The default is amount=1.
#'
#' @return It will return a dataframe with the columns `Start`, `End`, `Base`, `Rates.start_rate`, `Rates.end_rate`, `Rates.change_pct`, and `Amount`.
#' If there is an error, it will return error and get the error message.
#'
#' @examples
#' fluctuation('2022-01-01','2022-02-10')
#' fluctuation('2021-01-01','2021-12-10', symbols='CAD,USD')
#' fluctuation('2021-03-10','2021-11-15', symbols='CAD,USD,CZK', amount=1000)
#'
#' @references \url{https://exchangerate.host/#/}

library(jsonlite)
library(tidyr)
library(ggplot2)
library(testthat)

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

#' @export
fluctuation <- function(start, end, base='EUR', symbols='', amount=1) {
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

  url<-paste('https://api.exchangerate.host/fluctuation?start_date=',start,'&end_date=',end,'&base=',base,'&symbols=',symbols,'&amount=',amount,"&places=2",sep="")
  data <- jsonlite::fromJSON(url)

  if(data$success!=TRUE){
    warning("Error in connecting to the API!")
    return ("Error")
  }

  if(length(data$rates)==0){
    warning("Error in the parameter, please check!")
    return ("Error")
  }

  start <- as.Date(start)
  end <- as.Date(end)
  if(difftime(end, start, units = "days")>366){
    warning("Error in the timeframe! The maximum allowed is 366 days!")
    return ("Error")
  }

  data <- data.frame('Start' = data$start_date, 'End' = data$end_date, 'Base' = base, 'Amount' = amount, 'Rates' = do.call(rbind, data$rates))
  return (data)
}




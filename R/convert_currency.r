#' Get currency exchange rate between two currencies input by the user.
#' 
#' 
#' @details This function need the user input the currency to change from and the currency to change to.
#'
#' @param from String with the currency to change from. The format should be "XXX", for example "USD"
#' 
#' @param to  String with the currency to change to. The format should be "XXX", for example "CAD"
#' 
#' 
#' @return It will return a character vector of length two. The first element is the exchange rate. The second element is the date.  
#' If there is an error, it will return error and get the error message. 
#' 
#' @return the column will be the specific date currency exchange rate and the row will be the aim currency for that exchange rate. 
#' @examples \dontrun{
#' convert_currency("CAD", "USD")
#' }
#' @references \url{https://exchangerate.host/#/}
install.packages("jsonlite")
library(jsonlite)
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


convert_currency <- function(from, to) {
    
    if (from %in% currency_code_vector == FALSE) {
        warning("Invalid FROM currency name!")
        return ("Error")
        }

    if (to %in% currency_code_vector == FALSE) {
        warning("Invalid IN currency name!")
        return ("Error")
        }    
    
    url<-paste('https://api.exchangerate.host/convert?from=', from, '&to=', to, sep="")
    data <- fromJSON(url)

    if(data$success!=TRUE){
        warning("Error in connecting to the API!")
        return ("Error")
    }

    rate <- data$result
    date <- data$date
    output <- c(rate, date)
    
    return (output)
}
#' Get the plot of the exchange rate between 2 currencies in the time period. 
#' 
#' 
#' @details This function need the user input the start date, end date, base currency and the aim currency
#' for getting the plot of the currency exchange rate between the 2 currencies during the time period.
#'
#' @param start String with the start date. The format should be "yyyy-mm-dd", for example "2021-12-31"
#' 
#' @param end  String with the end date. The format should be "yyyy-mm-dd", for example "2021-12-31"
#' 
#' @param base String with the code of the base currency. Defaults to CAD, the canadian dollars. 
#'
#'  @param aim String with the code of the aim currency. Defaults to CAD, the canadian dollars. 
#'
#' @return It will return a plot of the currency exchange rate between the base currency and the aim currency in the time period. 
#' If there is an error, it will return error and get the error message. 
#' 
#' @return the plot x-axis will be the date and y-axis will be the currency exchange rate. 
#' @examples \dontrun{
#' history_trend_plot("2021-12-12", "2021-12-15", "USD","CAD")
#' history_trend_plot("2021-01-01", "2022-01-01","USD")
#' }
#' @references \url{https://exchangerate.host/#/}
install.packages("tidyr")
options(repr.plot.width = 15, repr.plot.height = 8)
library(jsonlite)
library(tidyr)
library(ggplot2)

currency_code_vector<-c('USD','JPY','BGN','CZK','DKK','GBP','HUF','PLN','RON','SEK','CHF','ISK','NOK','HRK','RUB','TRY','AUD','BRL','CAD','CNY','HKD','IDR','ILS','INR','KRW','MXN','MYR','NZD','PHP','SGD','THB','ZAR','EUR','AED','AFN','ALL','ARS','BAM','BBD','BDT','BHD','BIF','BMD','BND','BOB','BSD','BWP','BZD','CLP','COP','CRC','CUP','CVE','DJF','DOP','DZD','EGP','ETB','FJD','GHS','GNF','GTQ','HNL','HTG','IQD','JMD','JOD','KES','KHR','KWD','KYD','KZT','LAK','LBP','LKR','LSL','LYD','MAD','MDL','MGA','MKD','MMK','MOP','MUR','MVR','MWK','NAD','NGN','NIO','NPR','OMR','PAB','PEN','PGK','PKR','PYG','QAR','RSD','RWF','SAR','SCR','SDG','SOS','SVC','SZL','TND','TTD','TWD','TZS','UAH','UGX','UYU','UZS','VND','XAF','XOF','XPF','ZMW')
history_trend_plot<-function(start,end,base="CAD",aim="CAD"){
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
  if(length(data)==1 && data=="Error"){
    return ("Error")
  }
  if(aim %in% currency_code_vector == FALSE){
    warning("Invalid aim currency name!")
    return ("Error")
  }
  sub<-data[aim,]
  sub<-sub%>%pivot_longer(cols = everything(),names_to = "date",values_to = "currency_rate")
  sub$date<-as.Date(sub$date,'%Y-%m-%d') 
  
  title<-paste("The currency exchange rate between ",base, " and ", aim," in ",start," and ",end, " time period",sep="")
  plot <- ggplot(sub, aes(x = date, y = as.numeric(currency_rate))) +
    geom_line() +
    xlab("date") + 
    ylab("Currency rate") +
    ggtitle(title) +
    theme()
  return (plot)
}
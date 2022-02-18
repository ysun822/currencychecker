
test_that("latest rates works", {
  
  expect_equal(typeof(latest_rates('CNH','USD',1)),'list')
  expect_equal(ncol(latest_rates('CNH','USD',1)),4) 
  
  url<-'https://api.exchangerate.host/latest?base=CNH&symbols=USD&amount=1&places=2'
  data <- fromJSON(url)
  expect_equal(latest_rates('CNH','USD',1)[[1]],data$date[[1]])
  expect_equal(latest_rates('CNH','USD',1)[[2]],data$base[[1]])
  expect_equal(latest_rates('CNH','USD',1)[[3]],data$rates[[1]])
  expect_equal(latest_rates('CNH','USD',1)[[4]],1)
  
  expect_equal(typeof(latest_rates('CAD','USD,CNH',1000)),'list')
  expect_equal(ncol(latest_rates('CAD','USD,CNH',1000)), 2,4) 
  
  url<-'https://api.exchangerate.host/latest?base=CAD&symbols=USD,CNH&amount=1000&places=2'
  data <- fromJSON(url)
  expect_equal(latest_rates('CAD','USD,CNH',1000)[1,1],data$date[[1]])
  expect_equal(latest_rates('CAD','USD,CNH',1000)[2,2],data$base[[1]])
  expect_equal(latest_rates('CAD','USD,CNH',1000)[1,3],data$rates[[1]])
  expect_equal(latest_rates('CAD','USD,CNH',1000)[2,3],data$rates[[2]])
  expect_equal(latest_rates('CAD','USD,CNH',1000)[1,4],1000)      
})

test_that("latest rates throw errors and get warnings", {
  expect_warning(latest_rates('MMM','USD',1))
  expect_warning(latest_rates('CAD','USDCNH',1000))
  expect_warning(latest_rates('CAD','USDCNH','a'))
})
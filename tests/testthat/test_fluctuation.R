library(testthat)
test_that("fluctuation works", {
  
  expect_equal(typeof(fluctuation('2022-01-01','2022-02-10', symbols='USD')),'list')
  expect_equal(ncol(fluctuation('2022-01-01','2022-02-10', symbols='USD')),1,4) 
  
  url<-'https://api.exchangerate.host/fluctuation?start_date=2022-01-01&end_date=2022-02-10&base=EUR&symbols=USD&amount=1&places=2'
  data <- fromJSON(url)
  expect_equal(fluctuation('2022-01-01','2022-02-10', symbols='USD')[[1]],data$start_date[[1]])
  expect_equal(fluctuation('2022-01-01','2022-02-10', symbols='USD')[[2]],data$end_date[[1]])
  expect_equal(fluctuation('2022-01-01','2022-02-10', symbols='USD')[[3]],'EUR')    
  expect_equal(fluctuation('2022-01-01','2022-02-10', symbols='USD')[[4]],1)
  expect_equal(fluctuation('2022-01-01','2022-02-10', symbols='USD')[[5]][[1]],data$rates[[1]][[1]])
  expect_equal(fluctuation('2022-01-01','2022-02-10', symbols='USD')[[6]][[1]],data$rates[[1]][[2]])
  expect_equal(fluctuation('2022-01-01','2022-02-10', symbols='USD')[[7]][[1]],data$rates[[1]][[3]])
  expect_equal(fluctuation('2022-01-01','2022-02-10', symbols='USD')[[8]][[1]],data$rates[[1]][[4]])
  
  expect_equal(typeof(fluctuation('2021-02-01','2021-05-10', base='CNH', symbols='USD,CAD', amount=1000)),'list')
  expect_equal(ncol(fluctuation('2021-02-01','2021-05-10', base='CNH', symbols='USD,CAD', amount=1000)), 2,8) 
  
  url<-'https://api.exchangerate.host/fluctuation?start_date=2021-02-01&end_date=2021-05-10&base=CNH&symbols=USD,CAD&amount=1000&places=2'
  data <- fromJSON(url)
  expect_equal(fluctuation('2021-02-01','2021-05-10', base='CNH', symbols='USD,CAD', amount=1000)[[1]][1],data$start_date)
  expect_equal(fluctuation('2021-02-01','2021-05-10', base='CNH', symbols='USD,CAD', amount=1000)[[2]][1],data$end_date)
  expect_equal(fluctuation('2021-02-01','2021-05-10', base='CNH', symbols='USD,CAD', amount=1000)[[3]][1],'CNH')
  expect_equal(fluctuation('2021-02-01','2021-05-10', base='CNH', symbols='USD,CAD', amount=1000)[[4]][1],1000)
  expect_equal(fluctuation('2021-02-01','2021-05-10', base='CNH', symbols='USD,CAD', amount=1000)[[5]][[1]],data$rates[[1]][[1]])
  expect_equal(fluctuation('2021-02-01','2021-05-10', base='CNH', symbols='USD,CAD', amount=1000)[[5]][[2]],data$rates[[2]][[1]])
  expect_equal(fluctuation('2021-02-01','2021-05-10', base='CNH', symbols='USD,CAD', amount=1000)[[6]][[1]],data$rates[[1]][[2]])
  expect_equal(fluctuation('2021-02-01','2021-05-10', base='CNH', symbols='USD,CAD', amount=1000)[[6]][[2]],data$rates[[2]][[2]])
  expect_equal(fluctuation('2021-02-01','2021-05-10', base='CNH', symbols='USD,CAD', amount=1000)[[7]][[1]],data$rates[[1]][[3]])
  expect_equal(fluctuation('2021-02-01','2021-05-10', base='CNH', symbols='USD,CAD', amount=1000)[[7]][[2]],data$rates[[2]][[3]])
  expect_equal(fluctuation('2021-02-01','2021-05-10', base='CNH', symbols='USD,CAD', amount=1000)[[8]][[1]],data$rates[[1]][[4]])     
  expect_equal(fluctuation('2021-02-01','2021-05-10', base='CNH', symbols='USD,CAD', amount=1000)[[8]][[2]],data$rates[[2]][[4]])     
  
})

test_that("fluctuation throw errors and get warnings", {
  expect_warning(fluctuation('2021-02-01','2021-05-10','MMM'))
  expect_warning(fluctuation('2021-02-01','2021-05-10',symbols='MMM'))
  expect_warning(fluctuation('2021-02-01','2021-05-10',amount='MMM'))
  expect_warning(fluctuation('2021-02-01','2022-05-10'))    
})
source("../R/currency_time_series.R")

test_that("currency_time_series works", {
  expect_equal(typeof(currency_time_series("2020-01-01","2020-02-03","CAD")),'list')
  expect_equal(ncol(currency_time_series("2020-02-01","2020-02-03","CAD")),3)
  expect_equal(currency_time_series("2020-01-01","2020-01-04","CAD")[[1]]$USD,0.77)
  
})

test_that("currency_time_series throw errors and get warnings", {
  expect_warning(currency_time_series("2020-01-01","2020-02-03","AD"))
  expect_warning(currency_time_series(2020,"2020-02-03","CAD"))
})
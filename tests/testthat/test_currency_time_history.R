
test_that("currency_time_history works", {
  expect_equal(typeof(currency_time_history("2020-01-01","CAD")),'double')
  expect_equal(currency_time_history("2020-01-01","USD","CNY"),7.7991)
  
})

test_that("currency_time_history throw errors and get warnings", {
  expect_warning(currency_time_history("2020-01-01","AD"))
  expect_warning(currency_time_history("2020-01-01","CAD","AD"))
})
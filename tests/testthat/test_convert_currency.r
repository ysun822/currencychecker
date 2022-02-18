library(testthat)

test_that("convert_currency works", {
  expect_equal(typeof(convert_currency("USD", "CAD")),'character')
  expect_equal(length(convert_currency("USD", "CAD")), 2)
})

test_that("convert_currency throws errors and gets warnings", {
  expect_warning(convert_currency("USD","ACD"))
})
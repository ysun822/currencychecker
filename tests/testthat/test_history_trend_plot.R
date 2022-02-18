options(repr.plot.width = 15, repr.plot.height = 8)


test_that("history_trend_plot works", {
  expect_equal(typeof(history_trend_plot("2020-01-01","2020-02-03","CAD","USD")),'list') 
})


test_that("history_trend_of_two_currency_plot throw errors and get warnings", {
  expect_warning(history_trend_plot("2020-01-01","2020-02-03","AD","CAD"))
  expect_warning(history_trend_plot("2020-01-01","2020-02-03","CAD","AD")) 
  expect_warning(history_trend_plot(2020,"2020-02-03","CAD"))
  
})
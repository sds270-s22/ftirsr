library(testthat)

#greenland.csv unit tests
test_that("Checking greenland rows, cols", {
  expect_equal(dim(greenland)[1], 52668)
  expect_equal(dim(greenland)[2], 4)
})

test_that("Checking classes", {
  expect_is(greenland$bsi, "numeric")
  expect_is(greenland$sample_id, "character")
  expect_is(greenland$absorbance, "numeric")
})

#alaska.csv unit tests
test_that("Checking alaska rows, cols", {
  expect_equal(dim(alaska)[1], 193743)
  expect_equal(dim(alaska)[2], 4)
})

test_that("Checking classes", {
  expect_is(alaska$bsi, "numeric")
  expect_is(alaska$sample_id, "character")
  expect_is(alaska$absorbance, "numeric")
})


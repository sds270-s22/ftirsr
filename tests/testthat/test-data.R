library(testthat)

#greenland.csv unit tests
test_that("Checking greenland rows, cols", {
  expect_equal(dim(greenland)[1], 52668)
  expect_equal(dim(greenland)[2], 4)
})

test_that("Checking classes", {
  expect_type(greenland$bsi, "double")
  expect_type(greenland$sample_id, "character")
  expect_type(greenland$absorbance, "double")
  expect_s3_class(greenland, "ftirs")
})

#alaska.csv unit tests
test_that("Checking alaska rows, cols", {
  expect_equal(dim(alaska)[1], 193743)
  expect_equal(dim(alaska)[2], 4)
})

test_that("Checking classes", {
  expect_type(alaska$bsi, "double")
  expect_type(alaska$sample_id, "character")
  expect_type(alaska$absorbance, "double")
  expect_s3_class(alaska, "ftirs")
})

# read_ftirs_file.R unit tests
test_that("Checking read_ftirs", {

})

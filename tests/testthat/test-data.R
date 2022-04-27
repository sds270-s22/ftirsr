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
test_that("Checking read_ftirs_file", {
  expect_warning(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-10.0.csv"))
  expect_error(read_ftirs_file("~/ftirsr/tests/testthat/test_samples"))
  expect_warning(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv"))
  expect_type(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv")$wavenumber, "double")
  expect_type(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv")$absorbance, "double")
  expect_equal(ncol(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv")), 3)
  expect_equal(names(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv"))[1], "wavenumber")
  expect_equal(names(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv"))[2], "absorbance")
  expect_equal(names(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv"))[3], "sample_id")
  expect_equal(nrow(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv")), 1881)
  expect_error(read_ftirs_file(10))
  expect_error(read_ftirs_file("a"))
  expect_error(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-10.0.csv", "~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv"))
  expect_s3_class(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-10.0.csv"), "ftirs")
  expect_equal(names(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-10.0.csv", interpolate = FALSE)), names(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-10.0.csv")))
  expect_equal(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv")$sample_id[1], "FISK-270.0")
})

# read_ftirs.R unit tests
test_that("Checking read_ftirs", {
  expect_equal(as_ftirs(as_tibble(read_ftirs("~/ftirsr/tests/testthat/test_samples"))), head(greenland %>% select(-2), 5643))
})

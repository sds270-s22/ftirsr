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

# ftirs.R unit tests
test_that("Checking read_ftirs_file", {
  expect_warning(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-10.0.csv"))
  expect_error(suppressWarnings(read_ftirs_file("~/ftirsr/tests/testthat/test_samples")))
  expect_warning(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv"))
  expect_type(suppressWarnings(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv"))$wavenumber, "double")
  expect_type(suppressWarnings(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv"))$absorbance, "double")
  expect_equal(ncol(suppressWarnings(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv"))), 3)
  expect_equal(names(suppressWarnings(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv")))[1], "wavenumber")
  expect_equal(names(suppressWarnings(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv")))[2], "absorbance")
  expect_equal(names(suppressWarnings(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv")))[3], "sample_id")
  expect_equal(nrow(suppressWarnings(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv"))), 1881)
  expect_error(read_ftirs_file(10))
  expect_error(read_ftirs_file("a"))
  expect_error(suppressWarnings(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-10.0.csv", "~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv")))
  expect_s3_class(suppressWarnings(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-10.0.csv")), "ftirs")
  expect_equal(names(suppressWarnings(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-10.0.csv", interpolate = FALSE))), names(suppressWarnings(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-10.0.csv"))))
  expect_equal(suppressWarnings(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-270.0.csv"))$sample_id[1], "FISK-270.0")
})


test_that("Checking read_ftirs", {
  expect_equal(as_ftirs(as_tibble(suppressWarnings(read_ftirs("~/ftirsr/tests/testthat/test_samples")))), head(greenland %>% select(-2), 5643))
  expect_error(read_ftirs("~/ftirsr/tests/testthat/test_samples/FISK-10.0.csv"))
  expect_equal(ncol(suppressWarnings(read_ftirs("~/ftirsr/tests/testthat/test_samples", "~/ftirsr/tests//testthat/wet-chem-data.csv"))), 4)
  expect_error(suppressWarning(read_ftirs("~/ftirsr/tests/testthat/test_samples", "~/ftirsr/tests/testthat/test_samples")))
  expect_equal(suppressWarnings(read_ftirs("~/ftirsr/tests/testthat/test_samples", format = "wide")), suppressWarnings(read_ftirs("~/ftirsr/tests/testthat/test_samples")) %>% pivot_wider())
  expect_s3_class(suppressWarnings(read_ftirs("~/ftirsr/tests/testthat/test_samples")), "ftirs")
  expect_equal(nrow(suppressWarnings(read_ftirs("~/ftirsr/tests/testthat/test_samples", interpolate = FALSE))), 11091)
  expect_equal(names(suppressWarnings(read_ftirs("~/ftirsr/tests/testthat/test_samples"))), c("sample_id", "wavenumber", "absorbance"))
  expect_type(suppressWarnings(read_ftirs("~/ftirsr/tests/testthat/test_samples"))$wavenumber, "double")
  expect_type(suppressWarnings(read_ftirs("~/ftirsr/tests/testthat/test_samples"))$absorbance, "double")
})


test_that("Checking read_wet_chem", {
  #check errors
  # check col names
  # check col order
  #check BSi class
  # check class of object
})

# interpolate.R unit tests
test_that("Checking interpolation", {
  one_sample <- suppressWarnings(read_ftirs_file("~/ftirsr/tests/testthat/test_samples/FISK-10.0.csv", interpolate = FALSE))
  expect_equal(suppressWarnings(interpolate_ftirs(one_sample$wavenumber, one_sample$absorbance, rounded_wavenumbers$wavenumber)$wavenumber), rounded_wavenumbers$wavenumber)
})

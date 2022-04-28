library(testthat)

# greenland.csv unit tests
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

# alaska.csv unit tests
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
  expect_warning(read_ftirs_file("test_samples/FISK-10.0.csv"))
  expect_error(suppressWarnings(read_ftirs_file("test_samples")))
  expect_warning(read_ftirs_file("test_samples/FISK-270.0.csv"))
  expect_type(suppressWarnings(read_ftirs_file("test_samples/FISK-270.0.csv"))$wavenumber, "double")
  expect_type(suppressWarnings(read_ftirs_file("test_samples/FISK-270.0.csv"))$absorbance, "double")
  expect_equal(ncol(suppressWarnings(read_ftirs_file("test_samples/FISK-270.0.csv"))), 3)
  expect_equal(names(suppressWarnings(read_ftirs_file("test_samples/FISK-270.0.csv")))[1], "wavenumber")
  expect_equal(names(suppressWarnings(read_ftirs_file("test_samples/FISK-270.0.csv")))[2], "absorbance")
  expect_equal(names(suppressWarnings(read_ftirs_file("test_samples/FISK-270.0.csv")))[3], "sample_id")
  expect_equal(nrow(suppressWarnings(read_ftirs_file("test_samples/FISK-270.0.csv"))), 1881)
  expect_error(read_ftirs_file(10))
  expect_error(read_ftirs_file("a"))
  expect_error(suppressWarnings(read_ftirs_file("test_samples/FISK-10.0.csv", "test_samples/FISK-270.0.csv")))
  expect_s3_class(suppressWarnings(read_ftirs_file("test_samples/FISK-10.0.csv")), "ftirs")
  expect_equal(names(suppressWarnings(read_ftirs_file("test_samples/FISK-10.0.csv", interpolate = FALSE))), names(suppressWarnings(read_ftirs_file("test_samples/FISK-10.0.csv"))))
  expect_equal(suppressWarnings(read_ftirs_file("test_samples/FISK-270.0.csv"))$sample_id[1], "FISK-270.0")
})


test_that("Checking read_ftirs", {
  expect_equal(as_ftirs(as_tibble(suppressWarnings(read_ftirs("test_samples")))), head(greenland %>% select(-2), 5643))
  expect_error(read_ftirs("test_samples/FISK-10.0.csv"))
  expect_equal(ncol(suppressWarnings(read_ftirs("test_samples", "wet-chem-data.csv"))), 4)
  expect_error(suppressWarning(read_ftirs("test_samples", "test_samples")))
  expect_equal(suppressWarnings(read_ftirs("test_samples", format = "wide")), suppressWarnings(read_ftirs("test_samples")) %>% pivot_wider())
  expect_s3_class(suppressWarnings(read_ftirs("test_samples")), "ftirs")
  expect_equal(nrow(suppressWarnings(read_ftirs("test_samples", interpolate = FALSE))), 11091)
  expect_equal(names(suppressWarnings(read_ftirs("test_samples"))), c("sample_id", "wavenumber", "absorbance"))
  expect_type(suppressWarnings(read_ftirs("test_samples"))$wavenumber, "double")
  expect_type(suppressWarnings(read_ftirs("test_samples"))$absorbance, "double")
})


test_that("Checking read_wet_chem", {
  expect_equal(read_wet_chem("wet-chem-data.csv", greenland %>% select(-2)), greenland)
  expect_equal(names(read_wet_chem("wet-chem-data.csv", greenland %>% select(-2))), c("sample_id", "bsi", "wavenumber", "absorbance"))
  expect_s3_class(read_wet_chem("wet-chem-data.csv", greenland %>% select(-2)), "ftirs")
  expect_type(read_wet_chem("wet-chem-data.csv", greenland %>% select(-2))$bsi, "double")
})

test_that("Checking pivot_wider.ftirs", {
  expect_s3_class(pivot_wider(greenland), "ftirs")
  expect_error(pivot_wider(pivot_wider(greenland)))
  expect_equal(names(pivot_wider(greenland))[1], "bsi")
  expect_equal(names(pivot_wider(greenland))[2], "3996")
  expect_equal(ncol(pivot_wider(greenland)), 1882)
})

test_that("Checking pivot_longer.ftirs", {
  expect_error(pivot_longer(pivot_wider(greenland)))
  expect_equal(names(pivot_longer(pivot_wider(greenland), wet_chem = TRUE))[1], "sample_id")
  expect_equal(names(pivot_longer(pivot_wider(greenland), wet_chem = TRUE))[2], "bsi")
  expect_equal(names(pivot_longer(pivot_wider(greenland), wet_chem = TRUE))[3], "wavenumber")
  expect_equal(names(pivot_longer(pivot_wider(greenland), wet_chem = TRUE))[4], "absorbance")
  expect_equal(names(pivot_longer(pivot_wider(greenland %>% select(-2)), wet_chem = FALSE))[1], "sample_id")
  expect_equal(names(pivot_longer(pivot_wider(greenland %>% select(-2)), wet_chem = FALSE))[2], "wavenumber")
  expect_equal(names(pivot_longer(pivot_wider(greenland %>% select(-2)), wet_chem = FALSE))[3], "absorbance")
  expect_s3_class(pivot_longer(pivot_wider(greenland), wet_chem = TRUE), "ftirs")
  expect_type(pivot_longer(pivot_wider(greenland), wet_chem = TRUE)$wavenumber, "double")
  expect_type(pivot_longer(pivot_wider(greenland), wet_chem = TRUE)$absorbance, "double")
  expect_type(pivot_longer(pivot_wider(greenland), wet_chem = TRUE)$bsi, "double")
})

test_that("Checking is_ftirs", {
  expect_false(is_ftirs(3))
  expect_true(is_ftirs(greenland))
})

test_that("Checking as_ftirs", {
  expect_error(as_ftirs(3))
  expect_error(as_ftirs("a"))
  expect_error(as_ftirs(greenland$wavenumber))
  expect_s3_class(as_ftirs(read_csv("test_samples/FISK-10.0.csv")), "ftirs")
})

# interpolate.R unit tests
test_that("Checking interpolation", {
  one_sample <- suppressWarnings(read_ftirs_file("test_samples/FISK-10.0.csv", interpolate = FALSE))
  one_sample <- suppressWarnings(read_ftirs_file("test_samples/FISK-10.0.csv", interpolate = FALSE))
  multiple_sample <- suppressWarnings(read_ftirs("test_samples", interpolate = FALSE))
  expect_equal(suppressWarnings(interpolate_ftirs(one_sample$wavenumber, one_sample$absorbance, rounded_wavenumbers$wavenumber)$wavenumber), rounded_wavenumbers$wavenumber)
  expect_warning(interpolate_ftirs(multiple_sample$wavenumber, multiple_sample$absorbance, rounded_wavenumbers$wavenumber))
  expect_equal(names(interpolate_ftirs(one_sample$wavenumber, one_sample$absorbance, rounded_wavenumbers$wavenumber)), c("wavenumber", "absorbance"))
})

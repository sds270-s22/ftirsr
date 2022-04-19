library(testthat)

#greenland.csv unit tests
test_that("Checking greenland rows, cols", {
  expect_equal(dim(greenland)[1], 103516)
  expect_equal(dim(greenland)[2], 4)
})

test_that("Checking classes", {
  expect_is(greenland$bsi_percent, "numeric")
  expect_is(greenland$sample_id, "character")
  expect_is(greenland$absorbance, "numeric")
})

#alaskaWetChemAbsorbance.csv unit tests
test_that("Checking alaskaWetChemAbsorbance rows, cols", {
  expect_equal(dim(alaskaWetChemAbsorbance)[1], 193846)
  expect_equal(dim(alaskaWetChemAbsorbance)[2], 4)
})

test_that("Checking classes", {
  expect_is(alaskaWetChemAbsorbance$bsi_percent, "numeric")
  expect_is(alaskaWetChemAbsorbance$sample_id, "character")
  expect_is(alaskaWetChemAbsorbance$absorbance, "numeric")
})


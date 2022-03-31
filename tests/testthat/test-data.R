test_that("Checking greenland rows, cols", {
  expect_equal(dim(greenland)[1], 28)
  expect_equal(dim(greenland)[2], 3699)
})

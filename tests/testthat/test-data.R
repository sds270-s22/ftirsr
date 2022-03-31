test_that("Checking greenland rows, cols", {
  expect_equal(dim(greenland)[1], 28)
  expect_equal(dim(greenland)[2], 3699)
})

test_that("Checking classes", {
  expect_is(greenland$bsi_percent, "numeric")
  expect_is(greenland$sample_id, "character")
  expect_is(greenland$v1, "numeric")
})

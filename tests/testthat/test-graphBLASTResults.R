test_that("Returns errors", {
  data("BlastResults5Max")
  data("geneData")
  expect_error(graphBLASTResults(BlastResults5Max[1,],geneData))
})

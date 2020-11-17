test_that("Returns list with correct amount of rows and columns", {

  tmp <- getBlastResults("exampleQueryFasta.fasta","exampleDatabase.fasta",
                         maxSequencesReturned=2, dbType="nucl", userFastaType="prot")
  expect_equal(nrow(tmp), 2)
  expect_equal(ncol(tmp), 12)

  tmp <- getBlastResults("exampleQueryFasta.fasta","exampleDatabase.fasta",
                         maxSequencesReturned=5, dbType="nucl", userFastaType="prot")
  expect_equal(nrow(tmp), 5)
  expect_equal(ncol(tmp), 12)

} )

test_that("Returns a list", {
  tmp <- getBlastResults("exampleQueryFasta.fasta","exampleDatabase.fasta",
                         maxSequencesReturned=2, dbType="nucl", userFastaType="prot")
  expect_type(tmp, "list")
})

test_that("Creates a database", {
  tmp <- getBlastResults("exampleQueryFasta.fasta","exampleDatabase.fasta",
                         maxSequencesReturned=5, dbType="nucl", userFastaType="prot")
  expect_true(file.exists(paste("exampleDatabase.fasta", ".nhr",sep="")))
  expect_true(file.exists(paste("exampleDatabase.fasta", ".nin",sep="")))
  expect_true(file.exists(paste("exampleDatabase.fasta", ".nsq",sep="")))
})

test_that("Returns errors", {
  #Checking whether or not maxSequencesReturned is checked
  expect_error(getBlastResults("exampleQueryFasta.fasta","exampleDatabase.fasta",
                               maxSequencesReturned=0, dbType="nucl", userFastaType="prot"))
  expect_error(getBlastResults("exampleQueryFasta.fasta","exampleDatabase.fasta",
                               maxSequencesReturned=-1, dbType="nucl", userFastaType="prot"))

  #checking dbType and userFastaType
  expect_error(getBlastResults("exampleQueryFasta.fasta","exampleDatabase.fasta",
                               maxSequencesReturned=-1, dbType="lol", userFastaType="lol"))
})

## code to prepare `Example` dataset goes here

library(DEGSimilar)
databaseFasta <- readChar("exampleDatabase.fasta", file.info("exampleDatabase.fasta")$size)
queryFasta <- readChar("exampleQueryFasta.fasta", file.info("exampleQueryFasta.fasta")$size)
BlastResults5Max <- getBlastResults("data-raw/exampleQueryFasta.fasta","data-raw/exampleDatabase.fasta", maxSequencesReturned=5, dbType="nucl", userFastaType="prot")
BlastResults2Max <- getBlastResults("data-raw/exampleQueryFasta.fasta","data-raw/exampleDatabase.fasta", maxSequencesReturned=2, dbType="nucl", userFastaType="prot")
geneData <- read.csv("data-raw/GeneDataExample.csv",encoding="UTF-8",row.names=1)
usethis::use_data(databaseFasta,queryFasta,BlastResults2Max,geneData,BlastResults5Max, overwrite = TRUE)

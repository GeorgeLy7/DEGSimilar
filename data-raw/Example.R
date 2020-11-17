## code to prepare `Example` dataset goes here

library(DEGSimilar)
BlastResults5Max <- getBlastResults("data-raw/exampleQueryFasta.fasta","data-raw/exampleDatabase.fasta", maxSequencesReturned=5, dbType="nucl", userFastaType="prot")
BlastResults2Max <- getBlastResults("data-raw/exampleQueryFasta.fasta","data-raw/exampleDatabase.fasta", maxSequencesReturned=2, dbType="nucl", userFastaType="prot")
geneData <- read.csv("data-raw/GeneDataExample.csv",encoding="UTF-8",row.names=1)
usethis::use_data(BlastResults2Max,geneData,BlastResults5Max, overwrite = TRUE)

#' Gets BLAST Results
#'
#' A function that gets the BLAST hits of the submitted fasta file in the submitted fasta dabatase file.
#' Creates a fasta database out of the user-submitted fastaDatabse file.
#'
#' @param userFasta A fasta file containing one fasta entry. This sequence is the one the users wishes to
#'    compare to the entries in the fastaDatabse file.
#' @param fastaDatabase A fasta file containing fasta entries with sequences the user wishes to create a
#'    database out of and compare userFasta to.
#' @param maxSequencesReturned The maximum amount of sequences that should be returned from the BLAST. Requires >= 1.
#' @param dbType The sequence type of the database fasta. Is required to be "nucl" for nucleotide or "prot" for protein
#' @param userFastaType The sequence type of the fasta to perorm BLAST on. Is required to be "nucl" for nucleotide or "prot" for protein
#'
#' @return Returns a list containing the BLAST result template.
#' \itemize{
#'    \item QueryID - The name of the query sequence
#'    \item SubjectID - The name of the matched sequence
#'    \item Perc.Ident - The percent identity of the sequence match
#'    \item Alignment.Length - The length of the alignment in the match
#'    \item Mismatches - The number of mismatches in the alignments
#'    \item Gap.Openings - The number of gaps in the alignment
#'    \item Q.start - The start of the alignment on the query sequence
#'    \item Q.end - The end of the alignment of the query sequence
#'    \item S.start - The start of the alignment on the subject sequence
#'    \item S.end - The end of the alignment of the subject sequence
#'    \item E - The E-value of the alignment
#'    \item Bits - The bit score of the alignment
#' }
#' @export
#' @import rBLAST
#' @import Biostrings
getBlastResults <- function(userFasta, fastaDatabase, maxSequencesReturned=5, dbType, userFastaType) {

  #Checking if BLAST capability is on system
  if (Sys.which("makeblastdb") == '' || (Sys.which("blastn") == '' || Sys.which("tblastn") == '')) {
    stop("BLAST+ executable cannot be found by R, install the executable from NCBI or try specifying the location of the executable to R")
  }

  #Checking user input
  if (maxSequencesReturned < 1) {
    stop("max_target_seqs should be greater than 1")
  }

  if (dbType != "nucl" && dbType != "prot") {
    stop("dbType must be prot or nucl")
  }

  if (userFastaType != "nucl" && userFastaType != "prot") {
    stop("userFastaType must be prot or nucl")
  }

  #Checks if database already exists, if not creates database
  if (!file.exists(paste(fastaDatabase, ".nhr",sep="")) || (!file.exists(paste(fastaDatabase, ".nin",sep="")) ||
                                                           (!file.exists(paste(fastaDatabase, ".nsq",sep=""))))) {
    makeblastdb(fastaDatabase, dbtype=dbType)
  }
  else {
    print("BLAST Databse already exists for fastaDatabase file, skipping database creation")
  }

  #Selecting correct type of BLAST
  if (dbType == "nucl" && userFastaType == "nucl") {
    bl <- blast(db=fastaDatabase, type="blastn")
    seq <- Biostrings::readDNAStringSet(userFasta)
  }
  else if (dbType == "prot" && userFastaType == "prot") {
    bl <- blast(db=fastaDatabase, type="blastp")
    seq <- Biostrings::readAAStringSet(userFasta)
  }
  else if (dbType == "nucl" && userFastaType == "prot") {
    bl <- blast(db=fastaDatabase, type="tblastn")
    seq <- Biostrings::readAAStringSet(userFasta)
  }
  else if (dbtype == "prot" && userFastaType == "nucl") {
    bl <- blast(db=fastaDatabase, type="blastx")
    seq <- Biostrings::readDNAStringSet(userFasta)
  }

  #Checking how many fasta entries are in query fasta file
  if (length(seq) != 1) {
    stop("userFasta must contain only 1 fasta entry")
  }

  results <- predict(bl, seq, BLAST_args="-max_hsps 1")
  return(results[1:maxSequencesReturned,])
}

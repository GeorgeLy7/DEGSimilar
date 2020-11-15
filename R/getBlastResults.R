#' Gets BLAST Results
#'
#' A function that gets the BLAST hits of the submitted fasta file in the submitted fasta dabatase file.
#' Creates a fasta database out of the user-submitted fastaDatabse file.
#'
#' @param userFasta A fasta file containing one fasta entry. This sequence is the one the users wishes to
#'    compare to the entries in the fastaDatabse file.
#' @param fastaDatabase A fasta file containing fasta entries with sequences the user wishes to create a
#'    database out of and compare userFasta to.
#' @param max_targe_seqs The maximum amount of sequences that should be returned from the BLAST. Requires >= 1.
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
getBlastResults <- function(userFasta, fastaDatabase, max_target_seqs=5) {

  #Checking user input
  if (max_target_seqs < 1) {
    stop("max_target_seqs should be greater than 1")
  }

  #Checks if database already exists, if not creates database
  if (!file.exists(paste(fastaDatabase, ".nhr",sep="")) | (!file.exists(paste(fastaDatabase, ".nin",sep="")) |
                                                           (!file.exists(paste(fastaDatabase, ".nsq",sep=""))))) {
    makeblastdb(fastaDatabase)
  }

  bl <- blast(db=fastaDatabase)
  seq <- readDNAStringSet(userFasta)
  maxSeqs <- paste("-max_target_seqs", max_target_seqs)
  results <- predict(bl, seq, BLAST_args=maxSeqs)
  return(results)
}

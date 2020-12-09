#' Graphs BLAST Results from getBlastResults
#'
#' A function that gets the BLAST hits of the submitted fasta file in the submitted fasta dabatase file.
#' Creates a fasta database out of the user-submitted fastaDatabse file.
#'
#' @param blastResults A list containing fasta entries, must be generated from getBlastResults
#' @param geneData A list or dataframe containing gene counts or log transformed gene count data
#' @param rowLabelScaling An integer representing the scaling of the row labels, the higher the bigger the label will be
#' @param colLabelScaling An integer representing the scaling of the column labels, the higher the bigger the label will be
#'
#' @export
#' @import gplots
#' @return Returns a plot comparing the expression gene data of one more treatments of the genes in blastResults
graphBLASTResults <-function(blastResults, geneData, rowLabelScaling=1, colLabelScaling=1) {

  #Checking if BLAST capability is on system
  if (Sys.which("makeblastdb") == '' || (Sys.which("blastn") == '' || Sys.which("tblastn") == '')) {
    stop("BLAST+ executable cannot be found by R, install the executable from NCBI or try specifying the location of the executable to R")
  }

  #Checking user input
  if (ncol(blastResults) < 2) {
    stop("Must contain more than 1 BLAST result to graph")
  }

  queryName <- blastResults["QueryID"][1,]
  if (!is.element(queryName, row.names(geneData))) {
    stop("geneData does not contain query sequence information")
  }
  toGraph <- geneData[queryName,]
  toIterate <- blastResults["SubjectID"]
  for (i in 1:nrow(toIterate)) {
    if (queryName == toIterate[i,]) {
      next
    }
    if (!is.element(toIterate[i,], row.names(geneData))) {
      errorString <- paste("geneData does not contain", toIterate[i,], "skipping...")
      print(errorString)
    }
    else {
      toGraph <- rbind(toGraph,geneData[toIterate[i,],])
    }
  }
  if (ncol(toGraph) == 1) {
    df <- data.frame(toGraph)
    gplots::heatmap.2(cbind(df[[1]],df[[1]]),labRow=row.names(df),labCol = "", margins = c(12,12))

  }
  else {
    gplots::heatmap.2(as.matrix(toGraph), cexRow = rowLabelScaling,
              cexCol = colLabelScaling, srtCol = 45, margins = c(8,8), Rowv = FALSE, dendrogram = "col")
  }

}

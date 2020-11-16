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
graphBLASTResults <-function(blastResults, geneData, rowLabelScaling=1, colLabelScaling=1) {

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
    if (!is.element(toIterate[i,], row.names(geneData))) {
      errorString <- paste("geneData does not contain", toIterate[i,], "skipping...")
      print(errorString)
    }
    else {
      toGraph <- rbind(toGraph,geneData[toIterate[i,],])
    }
  }
  heatmap.2(as.matrix(toGraph), cexRow = rowLabelScaling,
            cexCol = colLabelScaling, srtCol = 45, margins = c(12,12), Rowv = FALSE, dendrogram = "col")

}

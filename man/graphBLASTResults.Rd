% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/graphBLASTResults.R
\name{graphBLASTResults}
\alias{graphBLASTResults}
\title{Graphs BLAST Results from getBlastResults}
\usage{
graphBLASTResults(
  blastResults,
  geneData,
  rowLabelScaling = 1,
  colLabelScaling = 1
)
}
\arguments{
\item{blastResults}{A list containing fasta entries, must be generated from getBlastResults}

\item{geneData}{A list or dataframe containing gene counts or log transformed gene count data}

\item{rowLabelScaling}{An integer representing the scaling of the row labels, the higher the bigger the label will be}

\item{colLabelScaling}{An integer representing the scaling of the column labels, the higher the bigger the label will be}
}
\value{
Returns a plot comparing the expression gene data of one more treatments of the genes in blastResults
}
\description{
A function that gets the BLAST hits of the submitted fasta file in the submitted fasta dabatase file.
Creates a fasta database out of the user-submitted fastaDatabse file.
}
\examples{
# Example 1:
# Using the provided gene expression and blastResults files
# data(BlastResults5Max)
# data(geneData)
# graphBLASTResults(blastResults=BlastResults5Max, geneData=geneData)
}

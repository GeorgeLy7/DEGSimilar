#' Launch Shiny App for DEGSimilar
#'
#' A function that launches the Shiny app for DEGSimilar.
#' Can perform every function of DEGSimilar, including outputting BLAST Results and graphing such results based on gene expression.
#'
#' @return No return value but opens up a Shiny page.
#'
#' @examples
#' \dontrun{
#'
#' DEGSimilar::runDEGSimilar()
#' }
#' @export
#' @importFrom shiny runApp
library(shiny)
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput("query", "Choose Fasta Query File",
                accept = c(
                  "fasta/fa/fai",
                  ".fasta",
                  ".fa",
                  ".fai")
      ),
      radioButtons(inputId="QueryType",
                   label="What type of sequence is the Query Fasta?",
                   choices=c("nucl","prot")
      ),
      fileInput("database", "Choose Fasta Database File",
                accept = c(
                  "fasta/fa/fai",
                  ".fasta",
                  ".fa",
                  ".fai")
      ),
      radioButtons(inputId="DatabaseType",
                   label="What type of sequence is the Database Fasta?",
                   choices=c("nucl","prot")
      ),
      numericInput("maxSeqs",
                   "Max number of BLAST Results:",
                   5,
                   min = 2,
                   max = 100),
      fileInput("geneData", "Choose CSV Gene Data File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")
      )
    ),
    mainPanel(
      tableOutput("blastResults"),
      plotOutput("graphResults")
    )
  )
)

server <- function(input, output) {
  output$blastResults <- renderTable({
    query <- input$query
    database <- input$database
    if (is.null(query))
      return(NULL)
    if (is.null(database))
      return(NULL)
    if (is.null(input$maxSeqs))
      return(NULL)
    DEGSimilar::getBlastResults(query$datapath, database$datapath,
                                maxSequencesReturned=input$maxSeqs, dbType=input$DatabaseType, userFastaType=input$QueryType)
  })
  output$graphResults <- renderPlot({
    query <- input$query
    database <- input$database
    geneExpression <- input$geneData

    if (is.null(query))
      return(NULL)
    if (is.null(database))
      return(NULL)
    if (is.null(geneExpression))
      return(NULL)
    if (is.null(input$maxSeqs))
      return(NULL)

    expressionData <- read.csv(geneExpression$datapath,row.names=1)
    tmpBlastResults <- DEGSimilar::getBlastResults(query$datapath, database$datapath,
                                maxSequencesReturned=input$maxSeqs, dbType=input$DatabaseType, userFastaType=input$QueryType)
    graphBLASTResults(blastResults=tmpBlastResults, geneData=expressionData)

  })
}

shinyApp(ui, server)



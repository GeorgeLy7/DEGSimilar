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
runDEGSimilar <- function() {
  appDir <- system.file("shiny-scripts",
                        package = "DEGSimilar")
  shiny::runApp(appDir, display.mode = "normal")
  return()
}

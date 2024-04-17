box::use(
  shiny,
)

#' @export
ui <- function(id) {
  ns <- shiny$NS(id)
  shiny$div(
    shiny$h1("Hello"),

    # Step 3:
    shiny::textInput(inputId = ns("name"), label = "What is your name"),

    # Step 4:
    shiny::textOutput(ns("greeting"))
  )
}

#' @export
server <- function(id) {
  shiny$moduleServer(id, function(input, output, session) {
    # Step 4:
    output$greeting <- shiny::renderText(paste("Hello", shiny$req(input$name)))
  })
}

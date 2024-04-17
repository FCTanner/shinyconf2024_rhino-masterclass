box::use(
  shiny[...],
  shiny.fluent[...],
)


ui <- function(id) {
  ns <- NS(id)
  div(
    Calendar.shinyInput(ns("date")),
    verbatimTextOutput(ns("text")),
  )
}

server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$text <- renderText({
      paste("Date:", input$date)
    })
  })
}

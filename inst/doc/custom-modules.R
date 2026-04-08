## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval = FALSE
)

## ----module-ui----------------------------------------------------------------
# library(VizModules)
# 
# minimalModuleUI <- function(id) {
#     ns <- NS(id)
#     tagList(
#         h4("Minimal Module Controls"),
#         # Custom input - uses the module's namespace
#         checkboxInput(ns("filter_setosa"), "Start with Setosa Only", value = FALSE),
#         hr(),
#         # Base module UI - pass the bare 'id', not ns(id)
#         dittoViz_scatterPlotInputsUI(id, iris)
#     )
# }
# 
# minimalModuleOutput <- function(id) {
#     # Simply delegate to the base module's output UI
#     dittoViz_scatterPlotOutputUI(id)
# }

## ----module-server------------------------------------------------------------
# minimalModuleServer <- function(id, data_reactive) {
#     # Step 1: Process data inside a moduleServer block
#     # This gives us access to inputs namespaced to 'id' (our module's inputs)
#     filtered_data <- moduleServer(id, function(input, output, session) {
#         reactive({
#             req(data_reactive())
#             df <- data_reactive()
# 
#             # Input specific to this custom module
#             if (isTRUE(input$filter_setosa)) {
#                 if ("Species" %in% names(df)) {
#                     df <- df[df$Species == "setosa", ]
#                 }
#             }
#             df
#         })
#     })
# 
#     # Step 2: Call the base module server OUTSIDE the moduleServer block
#     # This is critical! If we called this inside the moduleServer above,
#     # dittoViz_scatterPlotServer would look for inputs at id-id-inputName instead of id-inputName
#     dittoViz_scatterPlotServer(id, filtered_data)
# }

## ----full-app-----------------------------------------------------------------
# ui <- fluidPage(
#     titlePanel("Minimal Module Example"),
#     sidebarLayout(
#         sidebarPanel(
#             minimalModuleUI("demo")
#         ),
#         mainPanel(
#             minimalModuleOutput("demo")
#         )
#     )
# )
# 
# server <- function(input, output, session) {
#     # Pass a reactive data source to the module
#     minimalModuleServer("demo", reactive({
#         iris
#     }))
# }
# 
# shinyApp(ui, server)

## ----hiding-inputs------------------------------------------------------------
# focusedModuleUI <- function(id) {
#     ns <- NS(id)
#     tagList(
#         h4("Simplified Scatter Plot"),
#         # Hide a few parameters
#         dittoViz_scatterPlotInputsUI(id, iris,
#             hide.inputs = c("shape.by", "color.by")
#         )
#     )
# }


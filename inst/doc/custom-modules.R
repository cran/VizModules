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
#         # The UI takes no hide.* arguments -- see the server below.
#         dittoViz_scatterPlotInputsUI(id, iris)
#     )
# }
# 
# focusedModuleServer <- function(id, data_reactive) {
#     # hide.inputs and hide.tabs are arguments of the *Server*, not the *InputsUI.
#     dittoViz_scatterPlotServer(id, data_reactive,
#         hide.inputs = c("shape.by", "color.by")
#     )
# }

## ----reactive-defaults--------------------------------------------------------
# colouredModuleServer <- function(id, data_reactive) {
#     colour_col <- moduleServer(id, function(input, output, session) {
#         reactive(if (isTRUE(input$filter_setosa)) "" else "Species")
#     })
# 
#     # The colour mapping tracks the checkbox, but the user can still change it.
#     dittoViz_scatterPlotServer(
#         id, data_reactive,
#         defaults = list(color.by = colour_col)
#     )
# }

## ----manual-edits-------------------------------------------------------------
# customPlotServer <- function(id, data_reactive) {
#     moduleServer(id, function(input, output, session) {
#         # 1. A unique event source + the edit store, created once.
#         plot_source <- session$ns("customplot")
#         edit_store <- setup_manual_edits(input, session, plot_source)
# 
#         output$plot <- renderPlotly({
#             # 2. Create your plotly object with your plotting function
#             fig <- build_my_plotly_figure(data_reactive(), input)
#             # 3. Restore + capture edits on every render, then return the figure.
#             finalize_manual_edits(fig, plot_source, edit_store, session)
#         })
#     })
# }


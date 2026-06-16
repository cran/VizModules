## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval = FALSE
)

## ----run-gallery--------------------------------------------------------------
# library(shiny)
# shiny::runApp(system.file("apps/module-gallery", package = "VizModules"))

## ----scatter-example----------------------------------------------------------
# library(VizModules)
# 
# ui <- fluidPage(
#     sidebarLayout(
#         sidebarPanel(
#             dittoViz_scatterPlotInputsUI("cars",
#                 mtcars,
#                 defaults = list(
#                     x.by = "wt",
#                     y.by = "mpg",
#                     color.by = "cyl"
#                 )
#             )
#         ),
#         mainPanel(dittoViz_scatterPlotOutputUI("cars"))
#     )
# )
# 
# server <- function(input, output, session) {
#     dittoViz_scatterPlotServer("cars", data = reactive(mtcars))
# }
# 
# shinyApp(ui, server)

## ----hide-controls------------------------------------------------------------
# dittoViz_scatterPlotServer(
#     "cars",
#     data = reactive(mtcars),
#     hide.inputs = c("split.by", "rows.use"),
#     hide.tabs = c("Plotly")
# )

## ----create-module-app--------------------------------------------------------
# library(VizModules)
# 
# app <- createModuleApp(
#     inputs_ui_fn = plotthis_BarPlotInputsUI,
#     output_ui_fn = plotthis_BarPlotOutputUI,
#     server_fn    = plotthis_BarPlotServer,
#     data_list    = list("cars" = mtcars),
#     title        = "My Bar Plot"
# )
# if (interactive()) runApp(app)

## ----data-summary-------------------------------------------------------------
# 
# if (interactive()) {
#     library(shiny)
#     library(plotly)
# 
#     ui <- fluidPage(
#         plotlyOutput("plot"),
#         downloadButton("download_summary", "Download Summary")
#     )
# 
#     server <- function(input, output, session) {
#         # A reactive plotly plot
#         plot_reactive <- reactive({
#             plot_ly(mtcars, x = ~wt, y = ~mpg, type = "scatter", mode = "markers")
#         })
# 
#         # Optional: a reactive returning a stats data.frame
#         stats_reactive <- reactive({
#             data.frame(
#                 metric = c("mean_mpg", "sd_mpg"),
#                 value  = c(mean(mtcars$mpg), sd(mtcars$mpg))
#             )
#         })
# 
#         # Optional: capture all UI inputs as a named list
#         AllInputs <- reactive({
#             reactiveValuesToList(input)
#         })
# 
#         output$plot <- renderPlotly(plot_reactive())
# 
#         # Assemble the summary, then wire up the download handler.
#         plot_summary_reactive <- reactive({
#             collect_source_data(
#                 plot_reactive   = plot_reactive,
#                 stats_reactive  = stats_reactive,
#                 inputs_reactive = AllInputs()
#             )
#         })
# 
#         output$download_summary <- create_source_download_handler(
#             data_list     = plot_summary_reactive,
#             filename_base = "my_plot_summary"
#         )
#     }
# 
#     shinyApp(ui, server)
# }


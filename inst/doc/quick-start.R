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


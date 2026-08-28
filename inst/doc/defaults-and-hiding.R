## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval = FALSE
)

## ----defaults-basic-----------------------------------------------------------
# library(VizModules)
# 
# ui <- fluidPage(
#     sidebarLayout(
#         sidebarPanel(
#             dittoViz_scatterPlotInputsUI(
#                 "p", mtcars,
#                 defaults = list(
#                     x.by        = "wt",
#                     y.by        = "mpg",
#                     color.by    = "cyl",
#                     size        = 3,
#                     best.fit    = TRUE
#                 )
#             )
#         ),
#         mainPanel(dittoViz_scatterPlotOutputUI("p"))
#     )
# )
# 
# server <- function(input, output, session) {
#     dittoViz_scatterPlotServer("p", data = reactive(mtcars))
# }
# 
# shinyApp(ui, server)

## ----defaults-reactive--------------------------------------------------------
# library(VizModules)
# 
# ui <- fluidPage(
#     selectInput("colour_col", "Colour by", choices = c("cyl", "gear", "carb")),
#     sidebarLayout(
#         sidebarPanel(uiOutput("controls")),
#         mainPanel(dittoViz_scatterPlotOutputUI("p"))
#     )
# )
# 
# server <- function(input, output, session) {
#     plot_defaults <- list(
#         x.by = "wt",
#         y.by = "mpg",
#         color.by = reactive(input$colour_col)
#     )
# 
#     output$controls <- renderUI({
#         dittoViz_scatterPlotInputsUI("p", mtcars, defaults = plot_defaults)
#     })
# 
#     dittoViz_scatterPlotServer("p", data = reactive(mtcars), defaults = plot_defaults)
# }
# 
# shinyApp(ui, server)

## ----defaults-app-------------------------------------------------------------
# plotthis_BoxPlotApp(
#     defaults = list(
#         x.by     = "Species",
#         y.by     = "Sepal.Length",
#         pt.size  = 0
#     )
# )

## ----defaults-createModuleApp-------------------------------------------------
# app <- createModuleApp(
#     inputs_ui_fn = plotthis_BoxPlotInputsUI,
#     output_ui_fn = plotthis_BoxPlotOutputUI,
#     server_fn    = plotthis_BoxPlotServer,
#     data_list    = list("iris" = iris),
#     defaults     = list(x.by = "Species", y.by = "Sepal.Length")
# )
# if (interactive()) runApp(app)

## ----hide-inputs--------------------------------------------------------------
# server <- function(input, output, session) {
#     dittoViz_scatterPlotServer(
#         "p",
#         data        = reactive(mtcars),
#         hide.inputs = c("shape.by", "plot.order", "opacity")
#     )
# }

## ----hide-fixed---------------------------------------------------------------
# server <- function(input, output, session) {
#     dittoViz_scatterPlotServer(
#         "p",
#         data        = reactive(mtcars),
#         defaults    = list(color.by = "cyl"),
#         hide.inputs = "color.by"
#     )
# }

## ----hide-tabs----------------------------------------------------------------
# server <- function(input, output, session) {
#     dittoViz_scatterPlotServer(
#         "p",
#         data      = reactive(mtcars),
#         hide.tabs = c("Plotly", "Lines", "Trajectory")
#     )
# }

## ----combined-----------------------------------------------------------------
# ui <- fluidPage(
#     sidebarLayout(
#         sidebarPanel(
#             plotthis_ViolinPlotInputsUI(
#                 "v", example_rnaseq,
#                 defaults = list(
#                     x.by     = "condition",
#                     y.by     = "expression",
#                     color.by = "condition"
#                 )
#             )
#         ),
#         mainPanel(plotthis_ViolinPlotOutputUI("v"))
#     )
# )
# 
# server <- function(input, output, session) {
#     plotthis_ViolinPlotServer(
#         "v",
#         data        = reactive(example_rnaseq),
#         hide.inputs = c("color.by"),
#         hide.tabs   = c("Plotly", "Lines")
#     )
# }
# 
# shinyApp(ui, server)

## ----hide-in-app--------------------------------------------------------------
# plotthis_ViolinPlotApp(
#     defaults    = list(x.by = "Species", y.by = "Sepal.Length"),
#     hide.inputs = "color.by",
#     hide.tabs   = "Plotly"
# )

## ----dynamic-hide-------------------------------------------------------------
# library(shinyjs)
# 
# myModuleServer <- function(id, data_reactive) {
#     moduleServer(id, function(input, output, session) {
#         # Hide the 'size' input whenever a size.by column is chosen
#         observe({
#             if (nzchar(input$size.by)) {
#                 shinyjs::hide(id = "size")
#             } else {
#                 shinyjs::show(id = "size")
#             }
#         })
#     })
# 
#     dittoViz_scatterPlotServer(id, data_reactive)
# }

## ----dynamic-hide-reflow------------------------------------------------------
# myModuleServer <- function(id, data_reactive) {
#     moduleServer(id, function(input, output, session) {
#         observe({
#             if (nzchar(input$size.by)) {
#                 VizModules::hide_input(session, "size")
#             } else {
#                 VizModules::show_input(session, "size")
#             }
#         })
#     })
# 
#     dittoViz_scatterPlotServer(id, data_reactive)
# }


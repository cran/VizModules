## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval = FALSE
)

## ----defaults-basic-----------------------------------------------------------
# library(VizModules)
# 
# scatter_defaults <- list(
#     x.by        = "wt",
#     y.by        = "mpg",
#     color.by    = "cyl",
#     size        = 3,
#     best.fit    = TRUE
# )
# 
# ui <- fluidPage(
#     sidebarLayout(
#         sidebarPanel(
#             dittoViz_scatterPlotInputsUI("p", mtcars, defaults = scatter_defaults)
#         ),
#         mainPanel(dittoViz_scatterPlotOutputUI("p"))
#     )
# )
# 
# server <- function(input, output, session) {
#     dittoViz_scatterPlotServer("p", data = reactive(mtcars), defaults = scatter_defaults)
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
#     data_list = list("iris" = example_iris),
#     defaults = list(
#         x.data     = "Species",
#         y.data     = "Sepal.Length",
#         add.points = TRUE,
#         pt.size    = 2
#     )
# )

## ----defaults-createModuleApp-------------------------------------------------
# app <- createModuleApp(
#     inputs_ui_fn = plotthis_BoxPlotInputsUI,
#     output_ui_fn = plotthis_BoxPlotOutputUI,
#     server_fn    = plotthis_BoxPlotServer,
#     data_list    = list("iris" = iris),
#     defaults     = list(x.data = "Species", y.data = "Sepal.Length")
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
#             plotthis_BoxPlotInputsUI(
#                 "b", example_rnaseq,
#                 defaults = list(
#                     x.data   = "cell_type",
#                     y.data   = "log2_cpm",
#                     group.by = "condition"
#                 )
#             )
#         ),
#         mainPanel(plotthis_BoxPlotOutputUI("b"))
#     )
# )
# 
# server <- function(input, output, session) {
#     plotthis_BoxPlotServer(
#         "b",
#         data        = reactive(example_rnaseq),
#         hide.inputs = c("group.by"),
#         hide.tabs   = c("Plotly", "Lines")
#     )
# }
# 
# shinyApp(ui, server)

## ----hide-in-app--------------------------------------------------------------
# plotthis_BoxPlotApp(
#     data_list   = list("iris" = example_iris),
#     defaults    = list(x.data = "Species", y.data = "Sepal.Length"),
#     hide.inputs = "group.by",
#     hide.tabs   = "Plotly"
# )

## ----dynamic-hide-------------------------------------------------------------
# library(shinyjs)
# 
# myModuleServer <- function(id, data_reactive) {
#     moduleServer(id, function(input, output, session) {
#         # Hide the 'size' input whenever a size.by column is chosen. isTRUE()
#         # because input$size.by is NULL until the control first reports in.
#         observe({
#             if (isTRUE(nzchar(input$size.by))) {
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
#             if (isTRUE(nzchar(input$size.by))) {
#                 VizModules::hide_input(session, "size")
#             } else {
#                 VizModules::show_input(session, "size")
#             }
#         })
#     })
# 
#     dittoViz_scatterPlotServer(id, data_reactive)
# }


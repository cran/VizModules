## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval = FALSE
)

## ----hide-columns-------------------------------------------------------------
# server <- function(input, output, session) {
#     filtered <- dataFilterServer("filter", reactive(example_sales),
#         hide.columns = c("sale_id", "profit")
#     )
# }

## ----hide-columns-toggle------------------------------------------------------
# server <- function(input, output, session) {
#     filtered <- dataFilterServer("filter", reactive(example_sales),
#         hide.columns = c("sale_id", "profit"),
#         col.visibility = TRUE
#     )
# }

## ----resolve-helper-----------------------------------------------------------
# DT::datatable(
#     example_sales,
#     rownames = FALSE,
#     options = list(
#         columnDefs = list(list(
#             visible = FALSE,
#             targets = resolve_column_targets(example_sales, c("sale_id", "profit"))
#         ))
#     )
# )

## ----minimal------------------------------------------------------------------
# library(shiny)
# library(VizModules)
# 
# ui <- fluidPage(
#     plotthis_BarPlotOutputUI("bar"),
#     dataFilterUI("filter"),
#     plotthis_BarPlotInputsUI("bar", example_bar)
# )
# 
# server <- function(input, output, session) {
#     # Returns a reactive of only the currently-visible rows.
#     filtered <- dataFilterServer("filter", reactive(example_bar))
# 
#     # The plot tracks the filter automatically.
#     plotthis_BarPlotServer("bar", data = filtered)
# }
# 
# if (interactive()) shinyApp(ui, server)

## ----multi--------------------------------------------------------------------
# library(shiny)
# library(shinyjs)
# library(VizModules)
# 
# ui <- fluidPage(
#     useShinyjs(),
#     fluidRow(
#         column(6, plotthis_BarPlotOutputUI("bar")),
#         column(6, plotthis_BoxPlotOutputUI("box"))
#     ),
#     dataFilterUI("filter"),
#     fluidRow(
#         column(6, plotthis_BarPlotInputsUI("bar", example_bar)),
#         column(6, plotthis_BoxPlotInputsUI("box", example_bar))
#     )
# )
# 
# server <- function(input, output, session) {
#     # One filtered reactive, shared by both modules.
#     filtered <- dataFilterServer("filter", reactive(example_bar))
# 
#     plotthis_BarPlotServer("bar", data = filtered)
#     plotthis_BoxPlotServer("box", data = filtered)
# }
# 
# if (interactive()) shinyApp(ui, server)


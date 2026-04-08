## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval = FALSE
)

## ----example-app--------------------------------------------------------------
# myPlotApp <- function(data_list = NULL) {
#     if (is.null(data_list)) {
#         data_list <- list("example" = my_default_data)
#     }
#     createModuleApp(
#         inputs_ui_fn = myPlotInputsUI,
#         output_ui_fn = myPlotOutputUI,
#         server_fn    = myPlotServer,
#         data_list    = data_list,
#         title        = "Modular myPlots"
#     )
# }

## -----------------------------------------------------------------------------
# # In a module server — filtering rows by a textInput:
# rows.use = safe_eval_filter(isolate_fn(input$rows.use), data())

## -----------------------------------------------------------------------------
# # In a module server — passing a highlight expression to plotthis:
# highlight <- validate_expression(isolate_fn(input$highlight), names(data()))

## -----------------------------------------------------------------------------
# # In a module server — resolving an adjustment function:
# x.adj.fxn = safe_resolve_adj_fxn(isolate_fn(input$x.adj.fxn))


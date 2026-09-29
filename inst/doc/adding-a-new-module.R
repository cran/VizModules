## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval = FALSE
)

## ----example-app--------------------------------------------------------------
# myPlotApp <- function(data_list = NULL, defaults = NULL, hide.inputs = NULL, hide.tabs = NULL) {
#     # With no data, open on the module's showcase example (its entry in
#     # .module_showcase()), layering any caller defaults over its own.
#     if (is.null(data_list)) {
#         example <- .module_example("myplot")
#         data_list <- example$data_list
#         defaults <- utils::modifyList(example$defaults, defaults %||% list())
#     }
#     createModuleApp(
#         inputs_ui_fn = myPlotInputsUI,
#         output_ui_fn = myPlotOutputUI,
#         server_fn    = myPlotServer,
#         data_list    = data_list,
#         defaults     = defaults,
#         hide.inputs  = hide.inputs,
#         hide.tabs    = hide.tabs,
#         title        = "Modular myPlots"
#     )
# }

## ----debounce-----------------------------------------------------------------
# # Once, in the module server body -- not inside a reactive.
# filter_text <- debounce(reactive(input$row_filter), 700)
# 
# filtered <- reactive({
#     keep <- safe_eval_filter(filter_text(), data())
#     if (is.null(keep)) data() else data()[keep, , drop = FALSE]
# })

## -----------------------------------------------------------------------------
# # In a module server — filtering rows by a textInput:
# rows.use = safe_eval_filter(isolate_fn(input$rows.use), data())

## -----------------------------------------------------------------------------
# # In a module server — passing a highlight expression to plotthis:
# highlight <- validate_expression(isolate_fn(input$highlight), names(data()))

## -----------------------------------------------------------------------------
# # In a module server — resolving an adjustment function:
# x.adj.fxn = safe_resolve_adj_fxn(isolate_fn(input$x.adj.fxn))


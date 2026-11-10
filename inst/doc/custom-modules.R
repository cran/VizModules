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

## ----fig-fn-------------------------------------------------------------------
# cutoffScatterInputsUI <- function(id, data, defaults = NULL) {
#     ns <- NS(id)
#     tagList(
#         numericInput(ns("cutoff"), "Y Cutoff", value = NA),
#         dittoViz_scatterPlotInputsUI(id, data, defaults = defaults)
#     )
# }
# 
# cutoffScatterServer <- function(id, data_reactive, defaults = NULL) {
#     dittoViz_scatterPlotServer(
#         id, data_reactive,
#         defaults = defaults,
#         fig.fn = function(fig, input, isolate_fn) {
#             # The wrapper's input shares the module's id, so it is on this `input` too.
#             # isolate_fn() respects the module's Auto Update setting.
#             cutoff <- isolate_fn(input$cutoff)
#             if (is.null(cutoff) || is.na(cutoff)) {
#                 return(fig)
#             }
#             # Append rather than replace: facet strips, brackets and line labels share this list.
#             fig$x$layout$annotations <- c(fig$x$layout$annotations, list(list(
#                 text = paste("Cutoff:", cutoff), showarrow = FALSE,
#                 xref = "paper", x = 1, xanchor = "right",
#                 yref = "y", y = cutoff, yanchor = "bottom"
#             )))
#             fig$x$layout$yaxis$title$text <- paste0(isolate_fn(input$y.by), " (cutoff ", cutoff, ")")
#             fig
#         }
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
#             # 3. Restore + capture edits on every render. Last: when only the
#             #    layout changed, it sends just that and ends the render.
#             finalize_manual_edits(fig, plot_source, edit_store, session)
#         })
#     })
# }

## ----two-steps----------------------------------------------------------------
# customPlotServer <- function(id, data_reactive, defaults = NULL) {
#     moduleServer(id, function(input, output, session) {
#         params <- setup_reactive_defaults(defaults, input, session)
#         plot_source <- session$ns("customplot")
#         edit_store <- setup_manual_edits(input, session, plot_source)
# 
#         # What is drawn: cached, keyed on the data and every input read here.
#         draw_plot <- function(isolate_fn) {
#             p <- my_plot_function(data_reactive(), x = isolate_fn(input$x.by))
#             list(fig = plotly::ggplotly(p))
#         }
#         base_plot <- cached_structure(draw_plot, input, session, data_reactive, params = params)
# 
#         # How it looks: re-run for a styling change, without redrawing.
#         generate_plot <- reactive({
#             isolate_fn <- setup_auto_update_logic(input, params)
#             apply_uniform_styling(base_plot()$fig, input, isolate_fn)
#         })
# 
#         output$plot <- renderPlotly({
#             finalize_manual_edits(apply_render_margins(generate_plot(), input), plot_source, edit_store, session)
#         })
#     })
# }

## ----extension-helpers--------------------------------------------------------
# extendedServer <- function(id, data, defaults = NULL, hide.inputs = NULL) {
#     moduleServer(id, function(input, output, session) {
#         data <- require_data_frame(data)
# 
#         # A faceted plot has no editable main title: swap in the facet title inputs.
#         observe({
#             toggle_facet_title_inputs(session, nz_value(input$facet.by), hidden = hide.inputs)
#         })
# 
#         output$plot <- renderPlotly({
#             # "" (nothing chosen), NA and NULL all become NULL.
#             facet.by <- blank_to_null(input$facet.by)
#             # Jitter stays put across rebuilds instead of redrawing on every input change.
#             with_stable_seed(build_my_plotly_figure(data(), facet.by = facet.by))
#         })
# 
#         observeEvent(input$reset, {
#             # Restore the group colour picker to the mapping in `defaults`.
#             reset_group_colors(session, "palette.colours", defaults, groups(), default_palette_values)
#             reset_plotly_inputs(session, defaults)
#         })
#     })
# }

## ----debounce-wrapper---------------------------------------------------------
# myModuleServer <- function(id, data) {
#     filtered <- moduleServer(id, function(input, output, session) {
#         # Once, in the moduleServer body (where the wrapper's own input lives),
#         # not inside the reactive below. 500-800ms is a good range.
#         query <- debounce(reactive(input$query), 700)
# 
#         reactive({
#             keep <- safe_eval_filter(query(), data())
#             if (is.null(keep)) data() else data()[keep, , drop = FALSE]
#         })
#     })
# 
#     dittoViz_scatterPlotServer(id, filtered)
# }


## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval = FALSE
)

## -----------------------------------------------------------------------------
# library(shiny)
# library(VizModules)
# 
# ui <- fluidPage(
#     br(),
#     splitLayout(
#         multiColorPicker(
#             "dept_cols",
#             label = "Plot colors",
#             groups = c("Engineering", "Finance", "HR",
#                        "Marketing", "Operations", "Sales"),
#             selected_palette = "dittoColors"
#         ),
#         verbatimTextOutput("value")
#     )
# )
# 
# server <- function(input, output, session) {
#     output$value <- renderPrint(input$dept_cols)
# }
# 
# shinyApp(ui, server)

## ----echo = FALSE, eval = TRUE, out.width = "50%"-----------------------------
knitr::include_graphics("../man/figures/multiColorPicker.png")

## -----------------------------------------------------------------------------
# # With groups = c("Engineering", "Finance", "HR", ...)
# input$dept_cols
# #> c(
# #>   Engineering = "#E69F00",
# #>   Finance     = "#56B4E9",
# #>   HR          = "#009E73",
# #>   Marketing   = "#F0E442",
# #>   Operations  = "#0072B2",
# #>   Sales       = "#D55E00"
# #> )

## -----------------------------------------------------------------------------
# # Set specific group colors (only named groups change)
# updateMultiColorPicker(session, "dept_cols",
#     colors = c(Engineering = "#1B9E77", Finance = "#D95F02"))
# 
# # Apply a named palette to all groups
# updateMultiColorPicker(session, "dept_cols", palette = "ggplot2")
# 
# # Reset colors and palette back to the initial state
# updateMultiColorPicker(session, "dept_cols", reset = TRUE)

## -----------------------------------------------------------------------------
# library(shiny)
# library(VizModules)
# 
# ui <- fluidPage(
#     br(),
#     splitLayout(
#         multiDynamicInput(
#             "layers",
#             label = "Layers",
#             row_spec = list(
#                 colour = list(
#                     type = "colour",
#                     args = list(value = "#000000")
#                 ),
#                 size   = list(
#                     type = "numeric",
#                     args = list(value = 2, min = 0.5, max = 10)
#                 ),
#                 style  = list(type = "select",
#                 args = list(choices = c("solid", "dashed", "dotted")))
#             )
#         ),
#         verbatimTextOutput("value")
#     )
# )
# 
# server <- function(input, output, session) {
#     output$value <- renderPrint(input$layers)
# }
# 
# shinyApp(ui, server)

## ----echo = FALSE, eval = TRUE, out.width = "100%"----------------------------
knitr::include_graphics("../man/figures/multiDynamicInput.png")

## -----------------------------------------------------------------------------
# # Using type aliases
# row_spec = list(
#     name = list(type = "text", args = list(placeholder = "Enter name")),
#     age  = list(type = "numeric", args = list(value = 25, min = 0, max = 120))
# )
# 
# # Using fn for a custom input
# row_spec = list(
#     date = list(fn = shiny::dateInput, args = list(label = "Date", value = Sys.Date()))
# )

## -----------------------------------------------------------------------------
# multiDynamicInput(
#     "models",
#     label = "Models",
#     row_spec = list(
#         model_type = list(type = "select", args = list(choices = c("lm", "glm"))),
#         formula    = list(type = "text", args = list(placeholder = "y ~ x"))
#     ),
#     elements = list(
#         models1 = list(model_type = "lm", formula = "revenue ~ units"),
#         models2 = list(model_type = "glm", formula = "revenue ~ poly(units, 2)")
#     )
# )

## -----------------------------------------------------------------------------
# # With label = "Models" and two rows filled in:
# input$models
# #> list(
# #>   models1 = list(model_type = "lm", formula = "revenue ~ units"),
# #>   models2 = list(model_type = "glm", formula = "revenue ~ poly(units, 2)")
# #> )

## -----------------------------------------------------------------------------
# # Replace all rows
# updateMultiDynamicInput(session, "models", elements = list(
#     models1 = list(model_type = "lm", formula = "y ~ x")
# ))
# 
# # Clear all rows
# updateMultiDynamicInput(session, "models", clear = TRUE)

## -----------------------------------------------------------------------------
# row_spec = list(
#     model_type = list(type = "select", args = list(choices = c("lm", "drm"))),
#     formula    = list(type = "text", args = list(placeholder = "y ~ x")),
#     # Only visible when model_type == "drm"
#     drc_fct    = list(type = "select", backend = "drm",
#                       args = list(choices = c("LL.4", "LL.3")))
# )


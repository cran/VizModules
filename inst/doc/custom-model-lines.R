## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval = FALSE
)

## -----------------------------------------------------------------------------
# library(VizModules)
# 
# dittoViz_scatterPlotApp(
#     data_list = list("sales" = example_sales),
#     defaults = list(
#         x.by = "units",
#         y.by = "revenue",
#         custom.model.enable = TRUE,
#         custom.models = list(
#             models1 = list(
#                 model_type = "lm",
#                 formula = "revenue ~ units",
#                 line_colour = "#1F77B4",
#                 line_width = 2
#             ),
#             models2 = list(
#                 model_type = "loess",
#                 formula = "revenue ~ units",
#                 line_colour = "#E63946",
#                 line_width = 3
#             )
#         )
#     )
# )

## -----------------------------------------------------------------------------
# library(VizModules)
# library(drc)
# 
# register_model_backend("drm", list(
#     fit = function(formula, data, drc_fct = "LL.4", ...) {
#         fct_map <- list(
#             "LL.4" = drc::LL.4, "LL.3" = drc::LL.3, "LL.2" = drc::LL.2,
#             "W1.4" = drc::W1.4, "W2.4" = drc::W2.4
#         )
#         fct_fn <- fct_map[[drc_fct]]
#         if (is.null(fct_fn)) stop("Unknown drc family: ", drc_fct)
#         drc::drm(formula, data = data, fct = fct_fn())
#     },
#     predict = function(model, newdata) {
#         as.numeric(predict(model, newdata = newdata))
#     },
#     validate_classes = "drc",
#     fields = list(
#         drc_fct = list(
#             type = "select",
#             args = list(choices = c("LL.4", "LL.3", "LL.2", "W1.4", "W2.4"),
#                         selected = "LL.4")
#         )
#     )
# ))
# 
# # Launch — "drm" now appears in the dropdown with a "Drc fct" selector
# data(ryegrass, package = "drc")
# dittoViz_scatterPlotApp(data_list = list("ryegrass" = ryegrass))

## -----------------------------------------------------------------------------
# register_model_backend("gam", list(
#     fit = function(formula, data, ...) {
#         mgcv::gam(formula, data = data)
#     },
#     predict = function(model, newdata) {
#         as.numeric(predict(model, newdata = newdata))
#     },
#     validate_classes = "gam"
#     # No extra fields needed — formula handles everything (e.g. y ~ s(x))
# ))


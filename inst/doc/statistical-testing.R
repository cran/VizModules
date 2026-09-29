## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval = FALSE
)

## ----stats-app----------------------------------------------------------------
# library(VizModules)
# plotthis_BoxPlotApp()

## ----stats-defaults-----------------------------------------------------------
# plotthis_BoxPlotApp(
#     data_list = list("iris" = example_iris),
#     defaults = list(
#         x.data        = "Species",
#         y.data        = "Sepal.Length",
#         stats.enabled = TRUE,
#         stat.display  = "symbol",
#         stat.pairs    = c("setosa vs versicolor", "versicolor vs virginica")
#     )
# )

## ----stat-helpers-basic-------------------------------------------------------
# library(VizModules)
# library(ggplot2)
# library(plotly)
# 
# stats_df <- compute_pairwise_stats(
#     df   = example_iris,
#     x    = "Species",
#     y    = "Sepal.Length",
#     test = "wilcox.test",
#     p.adjust.method = "holm"
# )
# 
# # Build the figure with ggplot2 + ggplotly(), matching how the plot modules
# # construct their figures. This matters for bracket placement: ggplotly()
# # categorical axes are 1-based (the first factor level sits at x = 1), which
# # is the convention create_stat_annotations() expects.
# p <- ggplot(example_iris, aes(x = Species, y = Sepal.Length)) +
#     geom_boxplot()
# fig <- ggplotly(p)
# 
# stat_result <- create_stat_annotations(
#     stats_df = stats_df,
#     fig      = fig,
#     df       = example_iris,
#     x        = "Species",
#     y        = "Sepal.Length",
#     display  = "symbol"
# )
# 
# apply_stat_annotations(fig, stat_result)

## ----pairs--------------------------------------------------------------------
# choices <- generate_pair_strings(example_iris, x = "Species")
# pairs   <- parse_pair_strings(choices[1:2])
# 
# stats_df <- compute_pairwise_stats(
#     df    = example_iris,
#     x     = "Species",
#     y     = "Sepal.Length",
#     test  = "wilcox.test",
#     pairs = pairs
# )

## ----faceted------------------------------------------------------------------
# compute_pairwise_stats(
#     df        = example_rnaseq,
#     x         = "condition",
#     y         = "log2_cpm",
#     test      = "wilcox.test",
#     facet.by  = "gene",
#     per.facet = TRUE
# )

## ----plotted-values-----------------------------------------------------------
# plotted <- adjust_column_values(example_iris, y.col = "Sepal.Length", y.adj.fun = "log10")
# 
# stats_df <- compute_pairwise_stats(plotted, x = "Species", y = "Sepal.Length.adj")
# fig <- dittoViz::yPlot(example_iris, "Sepal.Length", "Species",
#     var.adj.fxn = log10, plots = "boxplot", do.hover = TRUE)
# stat_result <- create_stat_annotations(stats_df, fig = fig, df = plotted,
#     x = "Species", y = "Sepal.Length.adj")
# apply_stat_annotations(fig, stat_result)


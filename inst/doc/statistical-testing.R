## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval = FALSE
)

## ----stats-app----------------------------------------------------------------
# library(VizModules)
# plotthis_BoxPlotApp()

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
#     y         = "expression",
#     test      = "wilcox.test",
#     facet.by  = "gene",
#     per.facet = TRUE
# )


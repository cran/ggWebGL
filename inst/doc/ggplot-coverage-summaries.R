## ----setup, include = FALSE---------------------------------------------------
ggwebgl_truthy <- function(x) {
  tolower(x) %in% c("1", "true", "yes", "y")
}

ggwebgl_ci_vars <- c(
  "CI",
  "GITHUB_ACTIONS",
  "GITLAB_CI",
  "BUILDKITE",
  "TRAVIS",
  "APPVEYOR",
  "CIRCLECI",
  "JENKINS_URL"
)
ggwebgl_is_ci <- any(vapply(Sys.getenv(ggwebgl_ci_vars), ggwebgl_truthy, logical(1)))
ggwebgl_is_check <- nzchar(Sys.getenv("_R_CHECK_PACKAGE_NAME_"))
ggwebgl_eval_code <- !ggwebgl_is_ci &&
  !ggwebgl_is_check &&
  (
    ggwebgl_truthy(Sys.getenv("NOT_CRAN")) ||
      ggwebgl_truthy(Sys.getenv("GGWEBGL_EVAL_COVERAGE_VIGNETTE"))
  )
ggwebgl_eval_widgets <- ggwebgl_eval_code &&
  ggwebgl_truthy(Sys.getenv("GGWEBGL_EVAL_LIVE_WIDGETS"))

knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = ggwebgl_eval_code
)

library(ggplot2)
library(ggWebGL)

## ----coverage-eval-note, echo = FALSE, results = "asis", eval = TRUE----------
if (!ggwebgl_eval_code) {
  cat(
    "> Example chunks are shown but not evaluated in this build. ",
    "Set `GGWEBGL_EVAL_COVERAGE_VIGNETTE=true` or `NOT_CRAN=true` ",
    "to evaluate them during a local non-CI render.\n",
    sep = ""
  )
} else if (!ggwebgl_eval_widgets) {
  cat(
    "> Non-widget code chunks may evaluate in this build, but live WebGL ",
    "widgets are skipped. Set `GGWEBGL_EVAL_LIVE_WIDGETS=true` as well ",
    "to render browser-side widgets locally.\n",
    sep = ""
  )
}

## ----frequency-polygons, eval = ggwebgl_eval_widgets--------------------------
# p <- ggplot(mtcars, aes(mpg, colour = factor(cyl))) +
#   geom_freqpoly_webgl(binwidth = 4, linewidth = 1.1) +
#   labs(title = "Frequency polygons")
# ggplot_webgl(p, height = 420)

## ----density-curves, eval = ggwebgl_eval_widgets------------------------------
# p <- ggplot(mtcars, aes(mpg, colour = factor(cyl))) +
#   geom_density_webgl(linewidth = 1.1) +
#   labs(title = "Density curves")
# ggplot_webgl(p, height = 420)

## ----density2d-contours, eval = ggwebgl_eval_widgets && requireNamespace("MASS", quietly = TRUE)----
# p <- ggplot(mtcars, aes(wt, mpg)) +
#   geom_density2d_webgl(linewidth = 0.8) +
#   labs(title = "Two-dimensional density contours")
# ggplot_webgl(p, height = 420)

## ----gridded-contour-lines, eval = ggwebgl_eval_widgets-----------------------
# volcano_df <- as.data.frame(as.table(volcano))
# names(volcano_df) <- c("x", "y", "z")
# volcano_df$x <- as.numeric(volcano_df$x)
# volcano_df$y <- as.numeric(volcano_df$y)
# 
# p <- ggplot(volcano_df, aes(x, y, z = z)) +
#   geom_contour_webgl(bins = 8) +
#   labs(title = "Gridded contour lines")
# 
# ggplot_webgl(p, height = 420)

## ----linerange-pointrange, eval = ggwebgl_eval_widgets------------------------
# summary_df <- data.frame(
#   group = factor(c("a", "b", "c")),
#   y = c(4.1, 5.3, 6.0),
#   ymin = c(3.6, 4.7, 5.4),
#   ymax = c(4.8, 6.1, 6.8)
# )
# 
# p <- ggplot(summary_df, aes(group, y, ymin = ymin, ymax = ymax)) +
#   geom_linerange_webgl(linewidth = 1.2) +
#   geom_pointrange_webgl(colour = "#2563eb") +
#   labs(title = "Linerange and pointrange")
# ggplot_webgl(p, height = 420)

## ----error-bars-crossbars, eval = ggwebgl_eval_widgets------------------------
# p <- ggplot(summary_df, aes(group, y, ymin = ymin, ymax = ymax)) +
#   geom_errorbar_webgl(width = 0.25) +
#   geom_crossbar_webgl(aes(fill = group), width = 0.45, alpha = 0.55) +
#   labs(title = "Error bars and crossbars")
# ggplot_webgl(p, height = 420)

## ----boxplot-summary, eval = ggwebgl_eval_widgets-----------------------------
# p <- ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(cyl))) +
#   geom_boxplot_webgl() +
#   labs(title = "Boxplot summary")
# ggplot_webgl(p, height = 420)

## ----violin-density-summary, eval = ggwebgl_eval_widgets----------------------
# p <- ggplot(mtcars, aes(factor(cyl), mpg, fill = factor(cyl))) +
#   geom_violin_webgl(alpha = 0.7) +
#   labs(title = "Violin density summary")
# ggplot_webgl(p, height = 420)

## ----ribbon-band, eval = ggwebgl_eval_widgets---------------------------------
# band <- data.frame(
#   x = seq(0, 2 * pi, length.out = 80)
# )
# band$y <- sin(band$x)
# band$ymin <- band$y - 0.15
# band$ymax <- band$y + 0.15
# 
# p <- ggplot(band, aes(x, ymin = ymin, ymax = ymax)) +
#   geom_ribbon_webgl(fill = "#93c5fd", alpha = 0.6) +
#   geom_line_webgl(aes(y = y), colour = "#1d4ed8") +
#   labs(title = "Ribbon band")
# ggplot_webgl(p, height = 420)

## ----area-band, eval = ggwebgl_eval_widgets-----------------------------------
# p <- ggplot(band, aes(x, y)) +
#   geom_area_webgl(fill = "#a7f3d0", alpha = 0.7) +
#   labs(title = "Area band")
# ggplot_webgl(p, height = 420)

## ----simple-polygon, eval = ggwebgl_eval_widgets------------------------------
# triangle <- data.frame(
#   x = c(0, 1, 0.2),
#   y = c(0, 0.2, 1),
#   group = 1
# )
# 
# p <- ggplot(triangle, aes(x, y, group = group)) +
#   geom_polygon_webgl(fill = "#f97316", alpha = 0.7) +
#   labs(title = "Simple polygon")
# ggplot_webgl(p, height = 420)

## ----raster-grid, eval = ggwebgl_eval_widgets---------------------------------
# small_raster <- expand.grid(
#   x = seq_len(8),
#   y = seq_len(6),
#   KEEP.OUT.ATTRS = FALSE
# )
# small_raster$value <- with(small_raster, x * y)
# 
# p <- ggplot(small_raster, aes(x, y, fill = value)) +
#   geom_raster_webgl() +
#   labs(title = "Raster grid")
# ggplot_webgl(p, height = 420)

## ----text-and-rug-overlays, eval = ggwebgl_eval_widgets-----------------------
# labels <- data.frame(
#   x = c(2, 6),
#   y = c(2, 5),
#   label = c("low", "high")
# )
# 
# p <- ggplot(small_raster, aes(x, y, fill = value)) +
#   geom_tile_webgl(alpha = 0.55) +
#   geom_text_webgl(data = labels, aes(x = x, y = y, label = label), inherit.aes = FALSE) +
#   geom_rug_webgl(colour = "#334155") +
#   labs(title = "Text and rug overlays")
# ggplot_webgl(p, height = 420)

## ----label-overlay-metadata, eval = ggwebgl_eval_widgets----------------------
# p <- ggplot(labels, aes(x, y, label = label)) +
#   geom_label_webgl(fill = "#ffffff", colour = "#0f172a") +
#   labs(title = "Label overlay metadata")
# ggplot_webgl(p, height = 420)

## ----fixed-scale-facets, eval = ggwebgl_eval_widgets--------------------------
# p <- ggplot(mtcars, aes(wt, mpg, colour = factor(cyl))) +
#   geom_point_webgl() +
#   facet_wrap(~am) +
#   labs(title = "Fixed-scale facets")
# 
# ggplot_webgl(p, height = 420)


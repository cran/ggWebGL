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

## ----grammar-points-lines, eval = ggwebgl_eval_widgets------------------------
# p <- ggplot(mtcars, aes(wt, mpg, colour = factor(cyl))) +
#   geom_point_webgl() +
#   geom_line_webgl(aes(group = cyl), alpha = 0.35) +
#   labs(title = "Grammar-style points and lines") +
#   theme_webgl(shader = "density_splat")
# 
# ggplot_webgl(p, height = 420)

## ----renderer-ready-points, eval = ggwebgl_eval_widgets-----------------------
# spec <- ggwebgl_spec(
#   layers = list(
#     ggwebgl_layer_points(mtcars, x = "wt", y = "mpg", colour = "#2563eb")
#   ),
#   labels = list(title = "Renderer-ready point specification"),
#   webgl = webgl_spec(shader = "density_splat")
# )
# 
# ggWebGL(spec)

## ----ordered-path-segments, eval = ggwebgl_eval_widgets-----------------------
# trajectory <- data.frame(
#   x = cos(seq(0, 2 * pi, length.out = 48)) * seq(0.2, 1, length.out = 48),
#   y = sin(seq(0, 2 * pi, length.out = 48)) * seq(0.2, 1, length.out = 48),
#   frame = seq_len(48),
#   group = "spiral"
# )
# 
# arrows <- data.frame(
#   x = c(-0.8, -0.2, 0.4),
#   y = c(-0.6, 0.1, 0.5),
#   xend = c(-0.45, 0.15, 0.75),
#   yend = c(-0.25, 0.35, 0.2)
# )
# 
# p <- ggplot(trajectory, aes(x, y, group = group)) +
#   geom_path_webgl(aes(frame = frame), colour = "#2563eb", linewidth = 1.2) +
#   geom_point_webgl(aes(frame = frame), colour = "#0f766e", size = 1.8) +
#   geom_segment_webgl(
#     data = arrows,
#     aes(x = x, y = y, xend = xend, yend = yend),
#     inherit.aes = FALSE,
#     colour = "#334155"
#   ) +
#   labs(title = "Ordered 2D path with segments")
# 
# ggplot_webgl(p, height = 420)

## ----line-sorting-path-order, eval = ggwebgl_eval_widgets---------------------
# ordered <- data.frame(
#   x = c(3, 1, 2, 4),
#   y = c(1, 3, 2, 4),
#   group = "ordered"
# )
# 
# p <- ggplot(ordered, aes(x, y, group = group)) +
#   geom_line_webgl(colour = "#64748b") +
#   geom_path_webgl(colour = "#dc2626", linewidth = 1.2) +
#   labs(title = "Line sorting versus path order")
# 
# ggplot_webgl(p, height = 420)

## ----tile-grid, eval = ggwebgl_eval_widgets-----------------------------------
# tile_grid <- expand.grid(
#   x = seq_len(5),
#   y = seq_len(4),
#   KEEP.OUT.ATTRS = FALSE
# )
# tile_grid$value <- with(tile_grid, sin(x / 2) + cos(y / 2))
# 
# p <- ggplot(tile_grid, aes(x, y, fill = value)) +
#   geom_tile_webgl(alpha = 0.85) +
#   labs(title = "Tile grid")
# ggplot_webgl(p, height = 420)

## ----stacked-bar-counts, eval = ggwebgl_eval_widgets--------------------------
# p <- ggplot(mtcars, aes(factor(cyl), fill = factor(am))) +
#   geom_bar_webgl(position = "stack") +
#   labs(title = "Stacked bar counts")
# ggplot_webgl(p, height = 420)

## ----histogram-bins, eval = ggwebgl_eval_widgets------------------------------
# p <- ggplot(mtcars, aes(mpg)) +
#   geom_histogram_webgl(binwidth = 4) +
#   labs(title = "Histogram bins")
# ggplot_webgl(p, height = 420)

## ----two-dimensional-bins, eval = ggwebgl_eval_widgets------------------------
# p <- ggplot(mtcars, aes(wt, mpg)) +
#   geom_bin2d_webgl(bins = 8) +
#   labs(title = "Two-dimensional bins")
# ggplot_webgl(p, height = 420)

## ----explicit-rectangles, eval = ggwebgl_eval_widgets-------------------------
# rectangles <- data.frame(
#   xmin = c(0.0, 1.2),
#   xmax = c(1.0, 2.0),
#   ymin = c(0.0, 0.4),
#   ymax = c(0.8, 1.4),
#   label = c("a", "b")
# )
# 
# p <- ggplot(rectangles) +
#   geom_rect_webgl(
#     aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = label),
#     alpha = 0.75
#   ) +
#   labs(title = "Explicit rectangles")
# 
# ggplot_webgl(p, height = 420)


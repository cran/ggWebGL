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

## ----three-d-helix-path, eval = ggwebgl_eval_widgets--------------------------
# helix_t <- seq(0, 4 * pi, length.out = 80)
# helix <- data.frame(
#   x = cos(helix_t),
#   y = sin(helix_t),
#   z = helix_t / max(helix_t),
#   time = helix_t,
#   group = "helix"
# )
# 
# p <- ggplot(helix, aes(x, y, z = z, group = group, time = time)) +
#   geom_path3d_webgl(colour = "#2563eb") +
#   coord_webgl_3d() +
#   labs(title = "3D helix path")
# 
# ggplot_webgl(p, height = 420)

## ----structured-surface, eval = ggwebgl_eval_widgets--------------------------
# surface_grid <- expand.grid(
#   x = seq(-1, 1, length.out = 12),
#   y = seq(-1, 1, length.out = 12),
#   KEEP.OUT.ATTRS = FALSE
# )
# surface_grid$z <- with(surface_grid, exp(-(x^2 + y^2)))
# 
# p <- ggplot(surface_grid, aes(x, y, z = z, fill = z)) +
#   geom_surface_webgl(shading = "surface_height_colormap") +
#   coord_webgl_3d() +
#   labs(title = "Structured surface")
# 
# ggplot_webgl(p, height = 420)

## ----unstructured-mesh, eval = ggwebgl_eval_widgets---------------------------
# mesh_vertices <- data.frame(
#   x = c(0, 1, 0, 0),
#   y = c(0, 0, 1, 0),
#   z = c(0, 0, 0, 1),
#   scalar = c(0, 1, 1, 0.5),
#   i = c(1, 1, 1, 2),
#   j = c(2, 2, 3, 3),
#   k = c(3, 4, 4, 4)
# )
# 
# p <- ggplot(mesh_vertices, aes(x, y, z = z, i = i, j = j, k = k, scalar = scalar)) +
#   geom_mesh_webgl(shading = "mesh_scalar_colormap") +
#   coord_webgl_3d() +
#   labs(title = "Unstructured mesh")
# 
# ggplot_webgl(p, height = 420)


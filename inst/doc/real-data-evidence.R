## ----include = FALSE----------------------------------------------------------
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

knitr::opts_chunk$set(collapse = TRUE, comment = "#>", eval = ggwebgl_eval_code)
library(ggWebGL)
helper_path <- system.file("examples", "real", "real-data-helpers.R", package = "ggWebGL")
source(helper_path, local = knitr::knit_global())
real_examples <- if (ggwebgl_eval_code) real_data_plots() else NULL
real_info <- real_data_metadata()

## ----volcano-dem, out.width='100%'--------------------------------------------
# real_examples$volcano_dem

## ----volcano-demgl, out.width='100%', eval = ggwebgl_eval_widgets-------------
# ggplot_webgl(real_examples$volcano_dem+theme_webgl(shader = "default"), height = 620)

## ----volcano-demgl2, out.width='100%', eval = ggwebgl_eval_widgets------------
# ggplot_webgl(real_examples$volcano_dem, height = 620)

## ----storm-tracks, out.width='100%'-------------------------------------------
# real_examples$storm_tracks

## ----storm-tracksgl, out.width='100%', eval = ggwebgl_eval_widgets------------
# ggplot_webgl(real_examples$storm_tracks+theme_webgl(shader = "default"), height = 620)

## ----storm-tracksgl2, out.width='100%', eval = ggwebgl_eval_widgets-----------
# ggplot_webgl(real_examples$storm_tracks, height = 620)

## ----dense-embedding, out.width='100%'----------------------------------------
# real_examples$dense_embedding

## ----dense-embeddinggl, out.width='100%', eval = ggwebgl_eval_widgets---------
# ggplot_webgl(real_examples$dense_embedding+theme_webgl(shader = "default"), height = 620)

## ----dense-embeddinggl2, out.width='100%', eval = ggwebgl_eval_widgets--------
# ggplot_webgl(real_examples$dense_embedding, height = 620)

## ----faceted-embedding, out.width='100%'--------------------------------------
# real_examples$faceted_embedding

## ----faceted-embeddinggl, out.width='100%', eval = ggwebgl_eval_widgets-------
# ggplot_webgl(real_examples$faceted_embedding+theme_webgl(shader = "default"), height = 720)

## ----faceted-embeddinggl2, out.width='100%', eval = ggwebgl_eval_widgets------
# ggplot_webgl(real_examples$faceted_embedding, height = 720)


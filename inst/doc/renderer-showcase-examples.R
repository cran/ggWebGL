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
helper_path <- system.file("examples", "showcase", "showcase-helpers.R", package = "ggWebGL")
source(helper_path, local = knitr::knit_global())
showcase_info <- showcase_metadata()
showcase_examples <- if (ggwebgl_eval_code) showcase_plots(detail = "standard") else NULL

## ----latent-cloud, out.width='100%'-------------------------------------------
# showcase_examples$latent_cloud

## ----latent-cloudgl, out.width='100%', eval = ggwebgl_eval_widgets------------
# ggplot_webgl(showcase_examples$latent_cloud+theme_webgl(shader = "default", height = 630))

## ----latent-cloudgl2, out.width='100%', eval = ggwebgl_eval_widgets-----------
# ggplot_webgl(showcase_examples$latent_cloud, height = 630)

## ----diffusion-paths, out.width='100%'----------------------------------------
# showcase_examples$diffusion_paths

## ----diffusion-pathsgl, out.width='100%', eval = ggwebgl_eval_widgets---------
# ggplot_webgl(showcase_examples$diffusion_paths+theme_webgl(shader = "default", height = 630), height = 630)

## ----diffusion-pathsgl2, out.width='100%', eval = ggwebgl_eval_widgets--------
# ggplot_webgl(showcase_examples$diffusion_paths, height = 630)

## ----phase-portrait, out.width='100%'-----------------------------------------
# showcase_examples$phase_portrait

## ----phase-portraitgl, out.width='100%', eval = ggwebgl_eval_widgets----------
# ggplot_webgl(showcase_examples$phase_portrait+theme_webgl(shader = "default"), height = 630)

## ----phase-portraitgl2, out.width='100%', eval = ggwebgl_eval_widgets---------
# ggplot_webgl(showcase_examples$phase_portrait, height = 630)

## ----loss-landscape, out.width='100%'-----------------------------------------
# showcase_examples$loss_landscape

## ----loss-landscapegl, out.width='100%', eval = ggwebgl_eval_widgets----------
# ggplot_webgl(showcase_examples$loss_landscape+theme_webgl(shader = "default"), height = 630)

## ----loss-landscapegl2, out.width='100%', eval = ggwebgl_eval_widgets---------
# ggplot_webgl(showcase_examples$loss_landscape, height = 630)

## ----loss-landscapegl3, out.width='100%', eval = ggwebgl_eval_widgets---------
# ggplot_webgl(showcase_examples$loss_landscape+theme_webgl(shader = "trajectory_age"), height = 630)

## ----loss-landscapegl4, out.width='100%', eval = ggwebgl_eval_widgets---------
# ggplot_webgl(showcase_examples$loss_landscape+theme_webgl(shader = "trajectory_age_glow"), height = 630)


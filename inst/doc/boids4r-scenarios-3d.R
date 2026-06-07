## ----include = FALSE----------------------------------------------------------
knitr::opts_knit$set(purl = FALSE)

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
if (file.exists("../DESCRIPTION") && requireNamespace("pkgload", quietly = TRUE)) {
  pkgload::load_all("..", export_all = FALSE, helpers = FALSE, quiet = TRUE)
} else {
  library(ggWebGL)
}

boids4r_available <- requireNamespace("boids4R", quietly = TRUE)

## ----eval = ggwebgl_eval_code-------------------------------------------------
# if (!boids4r_available) {
#   cat("boids4R is unavailable, so live 3D boids widgets are skipped.\n")
# } else if (!ggwebgl_eval_widgets) {
#   cat("boids4R is available, but live 3D boids widgets are skipped because live widget evaluation is disabled.\n")
# } else {
#   cat("boids4R is available; live 3D boids widgets will be rendered below.\n")
# }

## ----include = FALSE, eval = ggwebgl_eval_code--------------------------------
# render_3d_boids_scenario <- function(name, n, seed) {
#   sim <- boids4R::boids_scenario(
#     name,
#     n = n,
#     steps = 240L,
#     record_every = 4L,
#     seed = seed
#   )
#   spec <- ggWebGL:::ggwebgl_boids_display_spec(
#     sim,
#     boid_size = 4.0,
#     prey_size = 4.8,
#     predator_size = 7.5,
#     current_alpha = 0.95,
#     trail_alpha = 0.18,
#     vector_mode = "current",
#     vector_colour_mode = "species",
#     vector_every = 1L,
#     vector_alpha = 0.68,
#     vector_width = 1.25,
#     vector_scale = 0.11,
#     obstacle_mode = "ring",
#     obstacle_segments = 48L,
#     obstacle_alpha = 0.9,
#     trail = "recent",
#     trail_length = 32L,
#     shader = "default",
#     speed = 1.4,
#     fps = 24L
#   )
#   spec$labels$title <- paste("boids4R", name)
#   ggWebGL::ggWebGL(spec, height = 540)
# }

## ----murmuration-3d, eval = ggwebgl_eval_widgets------------------------------
# if (!boids4r_available) {
#   cat("Murmuration widget skipped.\n")
# } else {
#   render_3d_boids_scenario("murmuration_3d", n = 240L, seed = 114L)
# }

## ----mixed-species-3d, eval = ggwebgl_eval_widgets----------------------------
# if (!boids4r_available) {
#   cat("Mixed-species widget skipped.\n")
# } else {
#   render_3d_boids_scenario("mixed_species_3d", n = 210L, seed = 115L)
# }


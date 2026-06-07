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

if (file.exists("DESCRIPTION") && requireNamespace("pkgload", quietly = TRUE)) {
  pkgload::load_all(".", export_all = FALSE, helpers = FALSE, quiet = TRUE)
} else if (file.exists("../DESCRIPTION") && requireNamespace("pkgload", quietly = TRUE)) {
  pkgload::load_all("..", export_all = FALSE, helpers = FALSE, quiet = TRUE)
} else {
  library(ggWebGL)
}

example_candidates <- c(
  "inst/examples/htmlwidget/surface-gallery.R",
  file.path("..", "inst", "examples", "htmlwidget", "surface-gallery.R"),
  system.file("examples", "htmlwidget", "surface-gallery.R", package = "ggWebGL")
)
example_candidates <- example_candidates[nzchar(example_candidates) & file.exists(example_candidates)]
if (!length(example_candidates)) {
  stop("Could not find surface-gallery.R")
}
sys.source(example_candidates[[1L]], envir = knitr::knit_global())

## ----volcano-surface, out.width='100%', eval = ggwebgl_eval_widgets-----------
# surface_gallery_volcano_widget(height = 460)

## ----scalar-mesh, out.width='100%', eval = ggwebgl_eval_widgets---------------
# surface_gallery_mesh_widget(height = 460)


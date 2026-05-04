## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
if (file.exists("../DESCRIPTION") && requireNamespace("pkgload", quietly = TRUE)) {
  pkgload::load_all("..", export_all = FALSE, helpers = FALSE, quiet = TRUE)
} else {
  library(ggWebGL)
}
build_optional_bridges <- identical(
  tolower(Sys.getenv("GGWEBGL_BUILD_OPTIONAL_BRIDGES", "false")),
  "true"
)
bridge_candidates <- c(
  "inst/examples/htmlwidget/xgeortr-bridge-gallery.R",
  file.path("..", "inst", "examples", "htmlwidget", "xgeortr-bridge-gallery.R"),
  system.file("examples", "htmlwidget", "xgeortr-bridge-gallery.R", package = "ggWebGL")
)
bridge_candidates <- bridge_candidates[nzchar(bridge_candidates) & file.exists(bridge_candidates)]

bridge_env <- new.env(parent = globalenv())
bridge_path <- if (length(bridge_candidates)) bridge_candidates[[1L]] else NA_character_
if (build_optional_bridges && !is.na(bridge_path)) {
  sys.source(bridge_path, envir = bridge_env)
}

bridge_available <- build_optional_bridges &&
  !is.na(bridge_path) &&
  exists("xgeortr_bridge_available", envir = bridge_env, inherits = FALSE) &&
  isTRUE(bridge_env$xgeortr_bridge_available())

bridge_widgets <- if (bridge_available) {
  bridge_env$ggwebgl_xgeortr_bridge_widgets(height = 520)
} else {
  NULL
}

## -----------------------------------------------------------------------------
if (!build_optional_bridges) {
  cat("Optional XGeoRTR live bridge widgets are disabled for this vignette build.\n")
} else if (!bridge_available) {
  cat("XGeoRTR is unavailable, so the live bridge widgets are skipped in this vignette.\n")
} else {
  cat("XGeoRTR bridge widgets are available.\n")
}

## -----------------------------------------------------------------------------
if (!bridge_available) {
  cat("Representative widget skipped.\n")
} else {
  bridge_widgets$representative
}

## -----------------------------------------------------------------------------
if (!bridge_available) {
  cat("Multiscale widget skipped.\n")
} else {
  bridge_widgets$multiscale
}

## -----------------------------------------------------------------------------
if (!bridge_available) {
  cat("Attribution widget skipped.\n")
} else {
  bridge_widgets$attribution
}

## -----------------------------------------------------------------------------
if (!bridge_available) {
  cat("Structure widget skipped.\n")
} else {
  bridge_widgets$structure
}

## ----eval = FALSE-------------------------------------------------------------
# source(system.file("examples", "htmlwidget", "xgeortr-bridge-gallery.R", package = "ggWebGL"))


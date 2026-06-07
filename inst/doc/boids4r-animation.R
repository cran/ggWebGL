## ----include = FALSE----------------------------------------------------------
knitr::opts_knit$set(purl = FALSE)
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", eval = FALSE)

## ----optional-boids4r-guard, eval = FALSE-------------------------------------
# boids4r_available <- requireNamespace("boids4R", quietly = TRUE)
# if (!boids4r_available) {
#   cat("boids4R is unavailable, so live boids animations are skipped.\n")
# }

## ----eval = FALSE-------------------------------------------------------------
# sim <- boids4R::boids_scenario("mixed_species_3d", n = 210, steps = 240, seed = 115)
# spec <- ggWebGL:::ggwebgl_boids_display_spec(
#   sim,
#   vector_mode = "current",
#   vector_colour_mode = "species",
#   obstacle_mode = "ring",
#   trail = "recent",
#   trail_length = 32,
#   shader = "default"
# )
# ggWebGL::ggWebGL(spec, height = 540)


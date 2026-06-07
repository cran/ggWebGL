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

if (file.exists("DESCRIPTION") && requireNamespace("pkgload", quietly = TRUE)) {
  pkgload::load_all(".", export_all = FALSE, helpers = FALSE, quiet = TRUE)
} else if (file.exists("../DESCRIPTION") && requireNamespace("pkgload", quietly = TRUE)) {
  pkgload::load_all("..", export_all = FALSE, helpers = FALSE, quiet = TRUE)
} else {
  library(ggWebGL)
}

example_candidates <- c(
  "inst/examples/htmlwidget/temporal-trajectories.R",
  file.path("..", "inst", "examples", "htmlwidget", "temporal-trajectories.R"),
  system.file("examples", "htmlwidget", "temporal-trajectories.R", package = "ggWebGL")
)
example_candidates <- example_candidates[nzchar(example_candidates) & file.exists(example_candidates)]
if (!length(example_candidates)) {
  stop("Could not find temporal-trajectories.R")
}
sys.source(example_candidates[[1L]], envir = knitr::knit_global())

## ----spiral-trajectory, out.width='100%', eval = ggwebgl_eval_widgets---------
# temporal_spiral_widget(height = 460)

## ----helix-trajectory, out.width='100%', eval = ggwebgl_eval_widgets----------
# temporal_helix_widget(height = 460)

## ----velocity-trajectory, out.width='100%', eval = ggwebgl_eval_widgets-------
# temporal_velocity_widget(height = 460)

## ----direction-trajectory, out.width='100%', eval = ggwebgl_eval_widgets------
# temporal_direction_widget(height = 460)

## ----exact-particles, out.width='100%', eval = ggwebgl_eval_widgets-----------
# temporal_exact_particles_widget(height = 460)

## ----shiny-timeline-snippet, eval = FALSE-------------------------------------
# library(shiny)
# library(ggWebGL)
# 
# ui <- fluidPage(
#   actionButton("restart", "Reset"),
#   ggWebGLOutput("plot", height = "420px"),
#   verbatimTextOutput("timeline_state")
# )
# 
# server <- function(input, output, session) {
#   output$plot <- renderGgWebGL({
#     temporal_helix_widget(height = 460)
#   })
# 
#   observeEvent(input$restart, {
#     updateGgWebGLTimeline(session, "plot", index = 1L, playing = FALSE)
#   })
# 
#   output$timeline_state <- renderPrint({
#     input$plot_timeline
#   })
# }
# 
# if (interactive()) {
#   shinyApp(ui, server)
# }


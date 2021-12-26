withr::with_options(list(usethis.quiet = TRUE), usethis::proj_set())
if(is.null(pkgload::pkg_ns())) suppressMessages(pkgload::load_all(export_all = !FALSE, helpers = FALSE, quiet = TRUE, warn_conflicts = FALSE))
requireNamespace("printr", quietly = TRUE)


# global options ----------------------------------------------------------
options(
    lubridate.week.start = 1, # 1 = Monday, 7 = Sunday
    tidyverse.quiet = TRUE,
    usethis.quiet = TRUE,
    digits = 3
)


# ggplot2 -----------------------------------------------------------------
library(ggplot2)
ggplot2::theme_set(ggplot2::theme_bw())
ggplot2::theme_update(legend.position='top', legend.justification='left', legend.direction='horizontal')


# knitr -------------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    out.width = '100%',
    echo = FALSE,
    results = "markup",
    message = FALSE,
    warning = FALSE,
    cache = !TRUE,
    comment = "#>",
    fig.retina = 0.8, # figures are either vectors or 300 dpi diagrams
    dpi = 300,
    out.width = "70%",
    fig.align = 'center',
    fig.width = 6,
    fig.asp = 0.618,  # 1 / phi
    fig.show = "hold",
    eval.after = 'fig.cap' # so captions can use link to demos
)

knitr::knit_hooks$set(
    error = function(x, options) {
        paste('\n\n<div class="alert alert-danger">',
              x
              |> stringr::str_replace_all('^.*:', '**Caution:**')
              |> stringr::str_replace_all('#> ', '\n'),
              '</div>', sep = '\n')
    },
    warning = function(x, options) {
        paste('\n\n<div class="alert alert-warning">',
              x 
              |> stringr::str_replace_all('##', '\n')
              |> stringr::str_replace_all('^#>\ Warning:', '**Note:**')
              |> stringr::str_remove_all("#>"),
              '</div>', sep = '\n')
    },
    message = function(x, options) {
        paste('\n\n<div class="alert alert-info">',
              x
              |> stringr::str_replace_all('##|#>', '\n**Tip:**'),
              '</div>', sep = '\n')
    }
)


# rmarkdown ---------------------------------------------------------------
kable <- knitr::kable


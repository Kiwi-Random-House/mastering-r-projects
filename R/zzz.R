.onAttach <- function(...) {#nocov start
    options(
        usethis.quiet = TRUE,
        tidyverse.quiet = TRUE,
        drake_clean_menu = FALSE
    )

    Sys.setenv(`_R_S3_METHOD_REGISTRATION_NOTE_OVERWRITES_` = "false")

    invisible()
}#nocov end

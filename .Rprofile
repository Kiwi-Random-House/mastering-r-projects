assign(".Rprofile", new.env(), envir = globalenv())

# .First ------------------------------------------------------------------
.First <- function(){
    try(if(testthat::is_testing()) return())

    # Package Management System
    Date <- as.character(read.dcf("DESCRIPTION", "Date"));
    URL <- if(is.na(Date)) "https://cran.rstudio.com/" else paste0("https://mran.microsoft.com/snapshot/", Date)
    options(repos = URL)
}

# .Last -------------------------------------------------------------------
.Last <- function(){
    try(if(testthat::is_testing()) return())

    unlink("./renv", recursive = TRUE)
    try(system('docker-compose down'), silent = TRUE)
}

# Docker ------------------------------------------------------------------
.Rprofile$docker$browse_url <- function(service){
    path_script <- tempfile("system-", fileext = ".R")
    job_name <- paste("Testing", as.character(read.dcf('DESCRIPTION', 'Package')), "in a Docker Container")
    define_service <- paste0("service = c(", paste0(paste0("'",service,"'"), collapse = ", "),")")
    define_service <- if(is.null(service)) "service = NULL" else define_service
    writeLines(c(
        "source('./R/utils-DockerCompose.R')",
        define_service,
        "DockerCompose$new()$browse_url(service)"), path_script)
    .Rprofile$utils$run_script(path_script, job_name)
}

.Rprofile$docker$start <- function(service = NULL){
    path_script <- tempfile("system-", fileext = ".R")
    job_name <- paste("Testing", as.character(read.dcf('DESCRIPTION', 'Package')), "in a Docker Container")
    define_service <- paste0("service <- c(", paste0(paste0("'",service,"'"), collapse = ", "),")")
    define_service <- if(is.null(service)) "service = NULL" else define_service
    writeLines(c(
        "source('./R/utils-DockerCompose.R')",
        define_service,
        "DockerCompose$new()$start(service)"), path_script)
    .Rprofile$utils$run_script(path_script, job_name)
}

.Rprofile$docker$stop <- function(){
    path_script <- tempfile("system-", fileext = ".R")
    job_name <- paste("Testing", as.character(read.dcf('DESCRIPTION', 'Package')), "in a Docker Container")
    writeLines(c("source('./R/utils-DockerCompose.R'); DockerCompose$new()$stop()"), path_script)
    .Rprofile$utils$run_script(path_script, job_name)
}

.Rprofile$docker$restart <- function(service = NULL){
    path_script <- tempfile("system-", fileext = ".R")
    job_name <- paste("Testing", as.character(read.dcf('DESCRIPTION', 'Package')), "in a Docker Container")
    define_service <- paste0("service <- c(", paste0(paste0("'",service,"'"), collapse = ", "),")")
    define_service <- if(is.null(service)) "service = NULL" else define_service
    writeLines(c(
        "source('./R/utils-DockerCompose.R')",
        define_service,
        "DockerCompose$new()$restart(service)"), path_script)
    .Rprofile$utils$run_script(path_script, job_name)
}

.Rprofile$docker$reset <- function(){
    path_script <- tempfile("system-", fileext = ".R")
    job_name <- paste("Testing", as.character(read.dcf('DESCRIPTION', 'Package')), "in a Docker Container")
    writeLines(c("source('./R/utils-DockerCompose.R'); DockerCompose$new()$reset()"), path_script)
    .Rprofile$utils$run_script(path_script, job_name)
}

# bookdown ----------------------------------------------------------------
.Rprofile$bookdown$browse_book <- function(){
    path <- "./_book"
    name <- "index.html"
    try(browseURL(stringr::str_glue('{path}/{name}', path = path, name = name)))
    invisible()
}

.Rprofile$bookdown$render_book <- function(output_format = "gitbook"){
    output_format <- match.arg(output_format, c("gitbook", "pdf_book"))
    path_script <- tempfile("system-", fileext = ".R")
    job_name <- "Rendering Book"

    writeLines(c(
        "temp_dir <<- tempfile('bookdown-')",
        "if(fs::dir_exists(temp_dir)) fs::dir_delete(temp_dir)",
        "files <- list.files(full.names = TRUE, recursive = TRUE)",
        "fs::dir_create(temp_dir)",
        "fs::dir_create(unique(dirname(file.path(temp_dir, gsub('^\\\\./', '', files)))))",
        "message('--> Coping files to temp location')",
        "fs::file_copy(files, file.path(temp_dir, gsub('^\\\\./', '', files)))",
        "message('--> Rendering files')",
        "withr::with_dir(file.path(temp_dir, 'vignettes'), {",
        paste0("bookdown::render_book('index.Rmd', output_format = 'bookdown::", output_format,"', output_dir = '../_book', quiet = TRUE)"),
        "})",
        "message('--> Retrieving book from temp location')",
        "try(fs::dir_delete('_book'), silent = TRUE)",
        "dir.create('_book', TRUE, TRUE)",
        "fs::dir_copy(file.path(temp_dir, '_book'), getwd())",
        "message('--> Done!')"),
        path_script)

    .Rprofile$utils$run_script(path_script, job_name, workingDir = usethis::proj_get())
}

.Rprofile$bookdown$test_book <- function(){
    .Rprofile$docker$restart("r-test")
}

# Utils -------------------------------------------------------------------
.Rprofile$utils$run_script <- function(path, name, workingDir = "."){
    withr::with_envvar(
        c(TESTTHAT = "true"),
        rstudioapi::jobRunScript(
            path = path,
            name = name,
            workingDir = workingDir,
            importEnv = FALSE,
            exportEnv = ""
        ))
    invisible()
}


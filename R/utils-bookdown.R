bookdown <- new.env()

bookdown$print_install.packages_command <- function(pkgs){
    # Note! step 1: install_string <- bookdown$print_install.packages_command(pkgs)
    # Note! chunk options should be: {r code = install_string, echo = TRUE, eval = FALSE}
    pkgs <- strwrap(paste(encodeString(pkgs, quote = '"'), collapse = ", "), exdent = 2)
    return(paste0(
        "install.packages(c(\n  ", 
        paste(pkgs, "\n", collapse = ""), 
        "))"
    ))
}

bookdown$print_package_info_table <- function(pkgs) return(
    # Note! chunk options should be: {r, echo = FALSE, results = "asis", cache = FALSE}
    pkgs
    %>% bookdown$create_package_info_table()
    %>% knitr::kable(format = "markdown", row.names = FALSE)
)

bookdown$create_package_info_table <- function(pkgs) return(
    # Note! chunk options should be: {r, echo = FALSE, results = "asis", cache = FALSE}
    pkgs
    %>% bookdown$create_package_info_table()
    %>% knitr::kable(format = "markdown", row.names = FALSE)
)


bookdown$get_imports <- function() return(
    desc::description$new()$get_deps()  
    %>% subset(type %in% "Imports", select = "package", drop = TRUE)  
    %>% sort()
)  

bookdown$dir_tree <- function(path){
    fs::dir_tree(path, recurse = TRUE)
}    

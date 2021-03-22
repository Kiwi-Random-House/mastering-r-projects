# R Package Development: Book --------------------------------------------------
FROM rocker/tidyverse

# Setup ------------------------------------------------------------------------
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    dos2unix \
    libcurl4-openssl-dev \
    libssl-dev \
	libxt-dev \
    libxml2-dev \
    libcairo2-dev \
    libsqlite-dev \
    libmariadbd-dev \
    libmariadbclient-dev \
    libpq-dev \
	libsodium-dev \
    libssh2-1-dev \
    libsasl2-dev \
    unixodbc-dev \
    libsqliteodbc \
    libharfbuzz-dev libfribidi-dev \
    libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure RStudio Server -----------------------------------------------------
ARG R_REPOS=\'https://mran.microsoft.com/snapshot/2021-02-15\'
RUN touch .env .Rprofile
RUN echo "options(repos = ${R_REPOS})" >> .Rprofile
RUN R -q -e "if(!require(remotes)) install.packages('remotes')"
RUN echo "require(remotes)" >> .Rprofile

RUN R -q -e "install_cran('tidyverse', dependencies = TRUE)"
RUN R -q -e "update_packages(upgrade  = 'always')"

RUN R -q -e "install_cran(c('devtools', 'testthat', 'roxygen2', 'bookdown'))"
RUN R -q -e "install_cran(('tinytex')); tinytex::install_tinytex()"
RUN R -q -e "install_cran(('webshot')); webshot::install_phantomjs()"

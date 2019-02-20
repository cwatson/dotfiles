.First <- function() {
  library(colorout)
  setOutputColors256(const=13, number=11, negnum=11, string=14, date=7)
  options(repos=c(CRAN='http://cran.us.r-project.org/'),
          width=100,
          datatable.print.nrows=50,
          useFancyQuotes='TeX')
  Sys.setenv(R_PDFVIEWER='/usr/bin/zathura')

  library(pacman)
  p_load(setwidth, plyr, data.table, ggplot2, gridExtra)
  cat("\nSuccessfully loaded .Rprofile at", date(), "\n")
}

#-------------------------------------------------------------------------------
# Utility functions
#-------------------------------------------------------------------------------
# Print the structure of object "x" w/ max.level=1
str1 <- function(x) str(x, max.level=1)

# Search for string "x" in environment "e"'s object list
lss <- function(x, e=.GlobalEnv) ls(envir=e)[grep(x, ls(envir=e))]

# Create an empty named list based on character vector "x"
emptyList <- function(x) sapply(x, function(y) NULL)

# Don't prompt to save on quit
q <- function() .Internal(quit(save='no', status=0, runLast=TRUE))

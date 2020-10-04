.First <- function() {
  library(colorout)
  setOutputColors256(const=13, number=11, negnum=11, string=14, date=7)
  options(repos=c(CRAN='http://cran.us.r-project.org/'),
          width=100,
          datatable.print.nrows=50,
          useFancyQuotes='TeX')
  Sys.setenv(R_PDFVIEWER='/usr/bin/zathura')

  library(pacman)
  p_load(setwidth, data.table, ggplot2, gridExtra, microbenchmark)
  cat("\nSuccessfully loaded .Rprofile at", date(), "\n")
}

#-------------------------------------------------------------------------------
# Utility functions
#-------------------------------------------------------------------------------
# Print the structure of object "x" w/ max.level=1
str1 <- function(x, ...) str(x, max.level=1, ...)

# Exclude attributes
str1a <- function(x, ...) str(x, max.level=1, give.attr=FALSE, ...)

# Shorten list output
strl <- function(x, len=10L, ...) str(x, list.len=len, ...)

str1l <- function(x, len=10L, ...) str(x, max.level=1, list.len=len, ...)

# Search for string "x" in "name"; "name" can be missing
lss <- function(x, name=.GlobalEnv, ...) ls(name, pattern=x, ...)

# List non-functions, in case some are in the workspace
lsnofun <- function(name=.GlobalEnv) {
  res <- ls(name)
  res[vapply(res, function(x) !is.function(get(x, envir=name)), logical(1L))]
}

# List only functions in a certain package
lsfun <- function(pkg) {
  env <- getNamespace(pkg)
  res <- ls(env)
  res[vapply(res, function(x) is.function(get(x, envir=env)), logical(1L))]
}

# List methods for a generic S3 function in a certain package
lsmethods <- function(generic, pkg) {
  intersect(lsfun(pkg), methods(generic))
}

# Return column names of a "data.table" from a search string
grepnames <- function(string, DT, ...) grep(string, names(DT), value=TRUE, ...)

# Create an empty named list based on character vector "x"
emptyList <- function(x) sapply(x, function(y) NULL)

# Shortcut for "rbindlist(lapply(...))"
rbl <- function(l, ...) rbindlist(lapply(l, ...))

# Convenience function to use "head" and "tail" on arrays
head.array <- function(x, i=8L, j=10L, k=2L, ...) abind::acorn(x, n=i, m=j, r=k, ...)
tail.array <- function(x, i=-8L, j=-10L, k=-2L, ...) abind::acorn(x, n=i, m=j, r=k, ...)

#-------------------------------------------------------------------------------
# Use "summary" in "data.table" with "by="; works for "ecdf" objects
#-------------------------------------------------------------------------------
summBy <- function(x, ...) {
  if (inherits(x, 'ecdf')) return(as.list(summary(x)))
  mn <- mean(x, ...)
  mdn <- median(x, ...)
  rg <- range(x, ...)
  iqr <- quantile(x, probs=c(0.25, 0.75), ...)
  return(list(Min.=rg[1], `1st Qu.`=iqr[1], Median=mdn, Mean=mn, `3rd Qu.`=iqr[2], Max.=rg[2]))
}

# Improve "summary" output for matrices and arrays
#-----------------------------------------------------------
summary.matrix <- function(object, j=8L, ...) {
  j <- min(dim(object)[2L], j)
  t(apply(object[, seq_len(j), drop=FALSE], 2L, summary, ...))
}

summary.array <- function(object, as.vec=FALSE, k=2L, j=8L, ...) {
  dims <- dim(object)
  k <- min(dims[3L], k)
  ks <- seq_len(k)
  j <- min(dims[2L], j)
  if (isTRUE(as.vec)) {
    res <- t(apply(object[, seq_len(j), ks, drop=FALSE], 3L, function(z) summary(as.vector(z), ...)))
  } else {
    res <- vector('list', k)
    for (z in seq_along(res)) res[[z]] <- summary(object[, , z], ...)
    if (!is.null((nms <- dimnames(object)[[3L]]))) names(res) <- nms[ks]
  }
  res
}

#-------------------------------------------------------------------------------
# Convert seconds to (hours), minutes, and seconds
#-------------------------------------------------------------------------------
sec2min <- function(x) {
  hrs <- x %/% 3600
  hrrem <- x %% 3600
  mins <- hrrem %/% 60
  mrem <- hrrem %% 60
  structure(list(hrs=hrs, mins=mins, secs=mrem), class='sec2min')
}

print.sec2min <- function(x, ...) {
  string <- ''
  if (x$hrs > 0) string <- paste0(string, x$hrs, ' h')
  string <- paste(string, x$mins, 'min')
  string <- paste(string, round(x$secs, 2), 'sec')
  print(trimws(string))
  invisible(x)
}

# Don't prompt to save on quit
utils::assignInNamespace(
"q",
function(save="no", status=0, runLast=TRUE) {
  .Internal(quit(save, status, runLast))
},
"base"
)

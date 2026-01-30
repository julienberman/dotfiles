message("Loading global .Rprofile...")

if (file.exists(".Rprofile")) {
  message("Found local .Rprofile, sourcing...")
  source(".Rprofile")
}

view <- function(df) {
  tmp <- tempfile(fileext = ".csv")
  write.csv(df, tmp, row.names = FALSE)
  system(paste("vd", shQuote(tmp)))
  unlink(tmp)
}

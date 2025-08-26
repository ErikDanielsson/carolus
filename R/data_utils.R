library(reticulate)

# Set up an enviroment so that we can cache the file loads
pkg.env <- new.env()
pkg.env$loaded_files <- list()

get_arrow_file <- function(
    csv_fp,
    group_by,
    format="tsv",
    ...
  ) {
  
  fn <- path_file(csv_fp) 
  
  if (fn %in% names(pkg.env$loaded_files)) {
    message(glue("Returning cached {fn}"))
    return(pkg.env$loaded_files[[fn]])
  } else {
    message(glue("Loading file {fn}"))
  }
  data <- fread(csv_fp, ...)
  pkg.env$loaded_files[[fn]] <- data
  return(data)     
}

make_file_long <- function(
  csv_fp, cache_relpath, col_header_name, val_header_name
) {
  # Construct the out file name
  fn <- path_file(csv_fp) 
  out_fp <- path(carolus_dir("cache"), cache_relpath, glue("long_{fn}"))
  
  # Check if we need to convert the file
  if (!file.exists(out_fp)) {
    reticulate::source_python(
      system.file("python", "wide_to_long_tsv.py", package="carolus")
    ) 
    message(glue("Converting wide file '{csv_fp}' into long file '{out_fp}'"))
    wide_to_long_tsv(csv_fp, out_fp, col_header_name, val_header_name)  
  } else {
    message("File already converted to long")
  }
  return(out_fp)
}


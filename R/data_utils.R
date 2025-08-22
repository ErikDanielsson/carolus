
# Set up an enviroment so that we can cache the file loads
pkg.env <- new.env()
pkg.env$loaded_files <- list()

get_arrow_file <- function(csv_fp, cache_relpath, group_by, format="tsv", ...) {
  
  fn <- path_file(csv_fp) 
  pq_fp <- path(carolus_dir("cache"), cache_relpath, fn)
  
  if (fn %in% names(pkg.env$loaded_files)) {
    message(glue("Returning cached {fn}"))
    return(pkg.env$loaded_files[[fn]])
  } else {
    message(glue("Loading file {fn}"))
  }
  
  if (file.exists(pq_fp)) {
    # Read the cached parquet file
    data <- open_dataset(
      sources = pq_fp,
      format = "parquet"
    )
    pkg.evn$loaded_files[[fn]] <- data
    return(data)
  } else {
    # Read the downloaded CSV file
    # data <- open_dataset(
    #   sources = csv_fp,
    #   col_types = schema(ISBN = string()),
    #   format = format
    # )
    data <- fread(csv_fp, ...)
    pkg.env$loaded_files[[fn]] <- data
    
    # TODO: Create a parquet file in the cache directory  
    # message(glue("Creating parquet file for {fn} at {pq_fp}"))
    # data |> write_dataset(path = pq_fp, format = "parquet")
    
    return(data)     
  }
}


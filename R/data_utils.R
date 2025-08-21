library(tidyverse)
library(arrow)
library(glue)
library(fs)

get_arrow_file <- function(csv_fp, cache_relpath, group_by, format="tsv") {
  
  fn <- path_file(csv_fp) 
  pq_fp <- path(carolus_dir("cache"), cache_relpath, fn)
  
  if (file.exists(pq_fp)) {
    # Read the cached parquet file
    data <- open_dataset(
      sources = pq_fp,
      format = "parquet"
    )
    return(data)
  } else {
    # Read the downloaded CSV file
    data <- open_dataset(
      sources = csv_fp,
      col_types = schema(ISBN = string()),
      format = format
    )
    
    # TODO: Create a parquet file in the cache directory  
    # message(glue("Creating parquet file for {fn} at {pq_fp}"))
    # data |> write_dataset(path = pq_fp, format = "parquet")
    
    return(data)     
  }
}


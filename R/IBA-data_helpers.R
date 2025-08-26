#' Get arrow table from a tabular file with country data
#'
#' Helper function to fetch data for a given country code in the IBA dataset
#' Files should look like '{fn_prefix}_{country code}.{format}'
#' @param fn_prefix The prefix of the file
#' @param country The country code. Either 'SE' or 'MG'
#' @param format The file ending. Defaults to 'tsv'
#' @return A data frame of the file
#' @export
get_IBA_file_country <- function(
    fn_prefix,
    data_source,
    country = "SE",
    format="tsv",
    long=FALSE, 
    col_header_name=NULL,
    val_header_name=NULL,
    ...
) {
   # Check that the locality looks correct
  if (country != "SE" && country != "MG") {
    message(glue("Country code '{locality}' is invalid. Please pick either 'SE' or 'MG'")) 
    return(NA)
  }
  return(get_IBA_data_file(
    fn_prefix,
    data_source,
    arguments = country,
    format = format,
    long = long,
    col_header_name = col_header_name,
    val_header_name = val_header_name,
    ...
  ))
}

#' Get arrow table from a tabular file
#'
#' Helper function to fetch data for a list of given arguments in the IBA dataset
#' Files should look like '{fn_prefix}_{arguments}.{format}'
#' @param fn_prefix The prefix of the file
#' @param arguments Some arguments to paste at the end of the file prefix
#' @param format The file ending. Defaults to 'tsv'
#' @return A data frame of the file
#' @export
get_IBA_data_file <- function(
  fn_prefix,
  data_source,
  arguments=NULL,
  format="tsv",
  long=FALSE,
  col_header_name=NULL,
  val_header_name=NULL,
  ...
) {
  # Construct the file name
  if (!is.null(arguments)) {
    fn_prefix <- glue("{fn_prefix}_{arguments}") 
  }
  # Check that the data source is 'raw' or 'processed'
  if (data_source != "raw" && data_source != "processed") {
    message(glue("Data source '{data_source}' is invalid. Please pick either 'raw' or 'processed'")) 
    return(NA)
  }
  
  # Construct the file name and path 
  fn <- glue("{fn_prefix}.{format}")
  csv_fp <- path(carolus_dir("data", "IBA", data_source), fn) 
  
  if (long) {
    message("File is long")
     csv_fp <- make_file_long(
       csv_fp, data_source, col_header_name, val_header_name
     )
  } else {
    message("File is not long")
  }
  
  return(get_arrow_file(csv_fp, data_source, ...))
}
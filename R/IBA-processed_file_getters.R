#' Get the 'asv_taxonomy' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @param program The taxonomy program to select. Supports 'epang', 'sintax' and 'vsearch'. Use NULL for default taxonomy
#' @return A data frame of the file
#' @export
get_asv_taxonomy <- function(country="SE", program=NULL) {
  if (program == NULL) {
    fn_prefix <- "asv_taxonomy" 
  } else if (program %in% c("epang", "sintax", "vsearch")) {
    fn_prefix <- glue("asv_taxonomy_{program}")
  } else {
    message("Program name '{program}' is invalid please use either: NULL, 'epang', 'sintax' or 'vsearch'")
  }
  return(get_IBA_file_country(fn_prefix, "processed", country = country, format="tsv.gz"))
}

#' Get the 'cleaned_noise_filtered_cluster_counts' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_cleaned_noise_filtered_cluster_counts <- function(country="SE") {
  return(get_IBA_file_country(
    "cleaned_noise_filtered_cluster_counts", "processed", country = country, format="tsv.gz"
  ))
}

#' Get the 'cleaned_noise_filtered_cluster_taxonomy' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_cleaned_noise_filtered_cluster_taxonomy <- function(country="SE") {
  return(get_IBA_file_country(
    "cleaned_noise_filtered_cluster_taxonomy", "processed", country = country, format="tsv.gz"
  ))
}

#' Get the 'cluster_consensus_taxonomy' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_cluster_consensus_taxonomy <- function(country="SE") {
  return(get_IBA_file_country(
    "cluster_consensus_taxonomy", "processed", country = country, format="tsv.gz"
  ))
}

#' Get the 'cluster_counts' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_cluster_counts <- function(country="SE") {
  return(get_IBA_file_country(
    "cluster_counts", "processed", country = country, format="tsv.gz"
  ))
}

#' Get the 'cluster_counts' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_cluster_counts <- function(country="SE") {
  return(get_IBA_file_country(
    "cluster_counts", "processed", country = country, format="tsv.gz"
  ))
}

# TODO: FASTA files
# cluster_reps_MG.fasta.gz
# cluster_reps_SE.fasta.gz

#' Get the 'cluster_taxonomy' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_cluster_taxonomy <- function(country="SE") {
  return(get_IBA_file_country(
    "cluster_taxonomy", "processed", country = country, format="tsv.gz"
  ))
}

#' Get the 'noise_filtered_cluster_counts' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_noise_filtered_cluster_counts <- function(country="SE") {
  return(get_IBA_file_country(
    "noise_filtered_cluster_counts", "processed", country = country, format="tsv.gz"
  ))
}
# 
# MANIFEST.txt
# noise_filtered_cluster_counts_MG.tsv.gz
# noise_filtered_cluster_counts_SE.tsv.gz
# noise_filtered_cluster_taxonomy_MG.tsv.gz
# noise_filtered_cluster_taxonomy_SE.tsv.gz
# README.txt
# removed_control_tax_MG.tsv.gz
# removed_control_tax_SE.tsv.gz
# shasum.txt
# spikeins_tax_MG.tsv.gz
# spikeins_tax_SE.tsv.gz
# 
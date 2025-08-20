#' Get arrow table from a tabular file with country data
#'
#' Helper function to fetch data for a given country code in the IBA dataset
#' Files should look like '{fn_prefix}_{country code}.{format}'
#' @param fn_prefix The prefix of the file
#' @param country The country code. Either 'SE' or 'MG'
#' @param format The file ending. Defaults to 'tsv'
#' @return A data frame of the file
#' @export
get_raw_file_country <- function(fn_prefix, country = "SE", format="tsv") {
   # Check that the locality looks correct
  if (country != "SE" && country != "MG") {
    message(glue("Country code '{locality}' is invalid. Please pick either 'SE' or 'MG'")) 
    return(NA)
  }
  return(get_raw_data_file(fn_prefix, arguments = country, format = format))
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
get_raw_data_file <- function(fn_prefix, arguments=NULL, format="tsv") {
  # Construct the file name
  if (!is.null(arguments)) {
    fn_prefix <- glue("{fn_prefix}_{arguments}") 
  }
  fn <- glue("{fn_prefix}.{format}")
  csv_fp <- path(carolus_dir("IBA", "raw"), fn) 
  
  return(get_arrow_file(csv_fp, "raw"))
}

#' Get the 'biological_spikes_taxonomy' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_biological_spikes_taxonomy <- function(country="SE") {
  return(get_raw_file_country("biological_spikes_taxonomy", country = country, format="tsv.gz"))
}

#' Get the 'biological_spikes_taxonomy' files
#'
#' @param dataset The dataset name. Either 'IBA' or 'SIIP'
#' @return A data frame of the file
#' @export
get_biomass_count <- function(dataset="IBA") {
  if (dataset != "IBA" && dataset != "SIIP") {
    message(glue("Dataset '{dataset}' is invalid. Please pick either 'IBA' or 'SIIP'")) 
    return(NA)
  }
  return(get_raw_data_file("biomass_count", arguments = dataset, format="tsv"))
}

#' Get the 'CO1_asv_counts' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_CO1_asv_counts <- function(country="SE") {
  return(get_raw_file_country("CO1_asv_counts", country = country, format="tsv.gz"))
}

# TODO: Implement ape function for:
# - CO1_asv_seqs_MG.fasta.gz
# - CO1_asv_seqs_SE.fasta.gz

#' Get the 'CO1_sequencing_metadata' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_CO1_sequencing_metadata <- function(country="SE") {
  return(get_raw_file_country("CO1_sequencing_metadata", country = country, format="tsv"))
}

#' Get the metadata litter files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_sample_metadata_litter <- function(country="SE") {
  if (country == "SE") {
    return(get_raw_data_file("sample_metadata_soil_litter", arguments = country))
  } else if (country == "MG") {
    return(get_raw_data_file("samples_metadata_litter", arguments = country))
  } else {
    message(glue("Country code '{locality}' is invalid. Please pick either 'SE' or 'MG'")) 
    return(NA)
  }
}

#' Get the 'samples_metadata_malaise' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_samples_metadata_malaise <- function(country="SE") {
  return(get_raw_file_country("samples_metadata_malaise", country = country))
}

#' Get the 'sites_metadata' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_sites_metadata <- function(country="SE") {
  return(get_raw_file_country("sites_metadata", country = country))
}

#' Get the 'soil_chemistry' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_soil_chemistry <- function(country="SE") {
  return(get_raw_file_country("soil_chemistry", country = country))
}

#' Get the 'stand_characteristic' file. Madagascar specific
#'
#' @return A data frame of the file
#' @export
get_stand_characteristics_MG <- function() {
  return(get_raw_file_country("stand_characteristics", country = "MG"))
}

#' Get the 'synthetic_spikes_info' file. 
#'
#' @return A data frame of the file
#' @export
get_synthetic_spikes_info <- function() {
  return(get_raw_data_file("synthetic_spikes_info"))
}
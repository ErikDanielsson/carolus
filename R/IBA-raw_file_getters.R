library(arrow)
#' Get the 'biological_spikes_taxonomy' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_raw_dataset <- function(country="SE") {
    raw_conns <- list()
    raw_conns$get_biomass_count <- get_biomass_count()
    raw_conns$get_CO1_asv_counts <- get_CO1_asv_counts()
    raw_conns$get_CO1_sequencing_metadata <- get_CO1_sequencing_metadata()
    raw_conns$get_sample_metadata_litter <- get_sample_metadata_litter()
    raw_conns$get_samples_metadata_malaise <- get_samples_metadata_malaise()
    raw_conns$get_sites_metadata <- get_sites_metadata()
    raw_conns$get_soil_chemistry <- get_soil_chemistry()
    raw_conns$get_stand_characteristics_MG <- get_stand_characteristics_MG()
    raw_conns$get_synthetic_spikes_info <- get_synthetic_spikes_info()
    return(open_dataset(raw_conns))
} 

#' Get the 'biological_spikes_taxonomy' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_biological_spikes_taxonomy <- function(country="SE") {
  return(get_IBA_file_country("biological_spikes_taxonomy", "raw", country = country, format="tsv.gz"))
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
  return(get_IBA_data_file("biomass_count", "raw", arguments = dataset, format="tsv", dec=","))
}

#' Get the 'CO1_asv_counts' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_CO1_asv_counts <- function(country="SE") {
  return(get_IBA_file_country("CO1_asv_counts", "raw", country = country, format="tsv.gz"))
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
  return(get_IBA_file_country("CO1_sequencing_metadata", "raw", country = country, format="tsv"))
}

#' Get the metadata litter files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_sample_metadata_litter <- function(country="SE") {
  if (country == "SE") {
    return(get_IBA_data_file("samples_metadata_soil_litter", "raw", arguments = country))
  } else if (country == "MG") {
    return(get_IBA_data_file("samples_metadata_litter", "raw", arguments = country))
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
  return(get_IBA_file_country("samples_metadata_malaise", "raw", country = country, dec = "."))
}

#' Get the 'sites_metadata' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_sites_metadata <- function(country="SE") {
  return(get_IBA_file_country("sites_metadata", "raw", country = country))
}

#' Get the 'soil_chemistry' files
#'
#' @param country The country code. Either 'SE' or 'MG', defaults to 'SE'  
#' @return A data frame of the file
#' @export
get_soil_chemistry <- function(country="SE") {
  return(get_IBA_file_country("soil_chemistry", "raw", country = country))
}

#' Get the 'stand_characteristic' file. Madagascar specific
#'
#' @return A data frame of the file
#' @export
get_stand_characteristics_MG <- function() {
  return(get_IBA_file_country("stand_characteristics", "raw", country = "MG"))
}

#' Get the 'synthetic_spikes_info' file. 
#'
#' @return A data frame of the file
#' @export
get_synthetic_spikes_info <- function() {
  return(get_IBA_data_file("synthetic_spikes_info", "raw"))
}
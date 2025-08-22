
#' Search the dataset for a set of taxa
#' 
#' @param taxa A character vector containing the taxa of interest
#' @param rank The rank of the taxa supplied
#' @param treatment_type The treatment type of the sample: 'lysate', 'homogenate' or 'all'
#' @param dataset The dataset name: 'IBA_SE' or 'IBA_MG'
#' @return A data frame containing the sample ids of the taxa with metadata
#' @examples
#' # Search for a single taxon 
#' taxon_search("Trypoxylon attenuatum", "Species")
#'
#' # Search for a multiple taxa
#' taxon_search(c("Astata", "Mellinus", "Trypoxylon"), "Genus")
#'
#' # Search for lysate samples
#' taxon_search("Astata boops", "Species", treatment_type = "lysate")
#' 
#' @export
taxon_search <- function(
    taxa,
    rank,
    treatment_type="all",
    dataset = "IBA_SE"
  ) {
  # Parse the dataset name
  parsed_dsetn <- str_split(dataset, "_", simplify = TRUE) 
  data_source <- parsed_dsetn[1,1]
  country <- parsed_dsetn[1,2]
  if (data_source != "IBA") {
    message(glue("The only supported data source is 'IBA'"))
    return(NA)
  }
  
  # Get the treatment type columns
  lysate_values <- if (country == "SE")
    c("CO1_lysate_2019_SE", "CO1_lysate_2021_SE")
  else c("CO1_lysate_2019_MG")
  homogenate_values <- if (country == "SE")
    c("CO1_homogenate_2019_SE")
  else c("CO1_litter_2019_MG")
  if (treatment_type == "all") {
    treatment_cols <- union(lysate_values, homogenate_values) 
  } else if (treatment_type == "lysate") {
    treatment_cols <- lysate_values
  } else if (treatment_type == "homogenate") {
    treatment_cols <- homogenate_values
  } else {
    message(glue("Invalid treatment type {treatment_type}"))
    return(NA)
  }
  
  # Get all clusters corresponding to the taxa of interest
  taxa_clusters <- get_cluster_consensus_taxonomy(country) %>%
    filter(.data[[rank]] %in% taxa) %>%
    .$cluster

  # Get the cluster counts rows which contain the clusters of interest
  taxa_cluster_rows <- get_cluster_counts(country) %>%
    filter(cluster %in% taxa_clusters) 

  # Get all columns except the cluster column
  sample_ID_NGI_cols <- setdiff(names(taxa_cluster_rows), "cluster")

  # Get NGI sample ids which had a positive number of hits
  sample_ID_NGIs_logical <- taxa_cluster_rows %>%
    summarise(across(all_of(sample_ID_NGI_cols), ~ any(. > 0, na.rm = TRUE))) %>%
    collect()  # collect only the final 1-row result
  sample_ID_NGIs <- names(sample_ID_NGIs_logical)[unlist(sample_ID_NGIs_logical)]
  
  # Get the field sample ids corresponding to the NGI sample ids 
  taxa_samples <- get_CO1_sequencing_metadata(country) %>%
    filter(sampleID_NGI %in% sample_ID_NGIs) %>%
    filter(dataset %in% treatment_cols) %>%
    select(sampleID_FIELD, dataset) %>%
    collect() 
  
  # Get the malaise metadata 
  mmc <- c("sampleID_FIELD", "trapID", "biomass_grams", "collecting_date", "sample_status")
  malaise_metadata <- get_samples_metadata_malaise(country) %>%
    select(all_of(mmc))
  
  # Join the metadata with the samples 
  taxa_samples <- left_join(taxa_samples, malaise_metadata, by="sampleID_FIELD")  
  
   # Get the site metadata
  smc <- c("siteID", "trapID", "latitude_WGS84", "longitude_WGS84")
  site_metadata <- get_sites_metadata(country) %>%
    select(all_of(smc))
  
   # Join the site metadata with the samples 
  taxa_samples <- left_join(taxa_samples, site_metadata, by="trapID") %>%
    arrange(siteID)
  
  return(taxa_samples)
}
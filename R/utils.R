library(yaml)

#' The default config file 
#'
#' Creates a default config file in the '~/.carolus' directory.
#' This file contain the paths of the datasets
#' @export
.carolus_default_dirs <- list(
  data = list(
    IBA = list(
      raw       = NULL,
      processed = NULL
    )
  ),
  cache  = tools::R_user_dir("carolus", which = "cache")
)

#' Check that the carolus config exists. Create it otherwise
#'
#' If no file is found, a default on is created based on the
#' template '.carolus_default_dirs'
#' @param config_path The path of the config file
#' @export
configure_carolus <- function(config_path = "~/.carolus/config.yaml") {
  if (!file.exists(config_path)) {
    create_carolus_config(config_path = "~/.carolus/config.yaml")
  } else {
    message(glue("Found config file at {config_path}"))
  }
}

#' Get the config file containing paths to data
#'
#' If no file is found, a default on is created based on the
#' template '.carolus_default_dirs'
#' @param config_path The path of the config file
#' @return A nested list of the parsed YAML
#' @export
carolus_config <- function(config_path = "~/.carolus/config.yaml") {
  if (!file.exists(config_path)) {
    create_carolus_config(config_path = "~/.carolus/config.yaml")
  }
  user_cfg <- yaml::read_yaml(config_path)
  utils::modifyList(.carolus_default_dirs, user_cfg)
}

create_carolus_config <- function(config_path = "~/.carolus/config.yaml") {
    dir.create(dirname(config_path), showWarnings = FALSE, recursive = TRUE)
    message(glue("Creating config file in {dirname(config_path)}"))
    raw_dir <- prompt_path("Enter the path to the raw IBA data")
    message(glue("Entered raw data dir '{raw_dir}' in config")) 
    .carolus_default_dirs$data$IBA$raw <- raw_dir
    processed_dir <- prompt_path("Enter the path to the processed IBA data")
    message(glue("Entered processed data dir '{processed_dir}' in config")) 
    .carolus_default_dirs$data$IBA$processed <- processed_dir
    yaml::write_yaml(.carolus_default_dirs, config_path)
    message("Created default config at ", config_path)
}

prompt_path <- function(message) {
  while (TRUE) {
    fp_str <- readline(glue("{message}: "))
    fp <- path_abs(fp_str)
    if (fp_str != "" && dir.exists(fp))
      break
    else if (fp_str == "") 
      message(glue("Please enter a valid directory"))
    else
      message(glue("Directory {fp} does not exist"))
  }
  return(fp) 
}

#' Get a directory specified in the config file
#'
#' If no file is found, a default on is created based on the
#' template '.carolus_default_dirs'
#' @param ... Keys in the config files to the path
#' @return A path to the directory of interest
#' @export
carolus_dir <- function(..., config_file = "~/.carolus/config.yaml") {
  cfg <- carolus_config(config_file)
  keys <- list(...)
  val <- cfg
  for (k in keys) {
    if (!is.list(val) || !k %in% names(val)) {
      stop("Unknown directory key: ", paste(keys, collapse = " -> "))
    }
    val <- val[[k]]
  }
  val
} 

library(yaml)

#' The default config file 
#'
#' Creates a default config file in the '~/.carolus' directory.
#' This file contain the paths of the datasets
#' @export
.carolus_default_dirs <- list(
  data   = tools::R_user_dir("carolus", which = "data"),
  IBA = list(
    raw       = file.path(tools::R_user_dir("carolus", "data"), "IBA", "raw"),
    processed = file.path(tools::R_user_dir("carolus", "data"), "IBA", "processed")
  ), 
  cache  = tools::R_user_dir("carolus", which = "cache"),
  models = tools::R_user_dir("carolus", which = "config") 
)

#' Get the config file containing paths to data
#'
#' If no file is found, a default on is created based on the
#' template '.carolus_default_dirs'
#' @param config_file The path of the config file
#' @return A nested list of the parsed YAML
#' @export
carolus_config <- function(config_file = "~/.carolus/config.yaml") {
  if (!file.exists(config_file)) {
    dir.create(dirname(config_file), showWarnings = FALSE, recursive = TRUE)
    message(glue("Creating config file in {dirname(config_file)}"))
    yaml::write_yaml(.carolus_default_dirs, config_file)
    message("Created default config at ", config_file)
  }
  user_cfg <- yaml::read_yaml(config_file)
  utils::modifyList(.carolus_default_dirs, user_cfg)
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

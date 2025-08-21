# Extremely simple test to see that all
# functions returns something remotely correct
test_that("all functions return", {
    expect_s3_class(get_biomass_count(), "ArrowObject")
    expect_s3_class(get_CO1_asv_counts(), "ArrowObject")
    expect_s3_class(get_CO1_sequencing_metadata(), "ArrowObject")
    expect_s3_class(get_sample_metadata_litter(), "ArrowObject")
    expect_s3_class(get_samples_metadata_malaise(), "ArrowObject")
    expect_s3_class(get_sites_metadata(), "ArrowObject")
    expect_s3_class(get_soil_chemistry(), "ArrowObject")
    expect_s3_class(get_stand_characteristics_MG(), "ArrowObject")#' 
    expect_s3_class(get_synthetic_spikes_info(), "ArrowObject")
})
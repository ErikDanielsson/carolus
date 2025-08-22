# Extremely simple test to see that all
# functions returns something remotely correct
test_that("all functions return", {
  expect_s3_class(get_asv_taxonomy(), "ArrowObject")
  expect_s3_class(get_cleaned_noise_filtered_cluster_counts(), "ArrowObject")
  expect_s3_class(get_cleaned_noise_filtered_cluster_taxonomy(), "ArrowObject")
  expect_s3_class(get_cluster_consensus_taxonomy(), "ArrowObject")
  expect_s3_class(get_cluster_counts(), "ArrowObject")
  expect_s3_class(get_cluster_taxonomy(), "ArrowObject")
  expect_s3_class(get_noise_filtered_cluster_counts(), "ArrowObject")
  expect_s3_class(get_noise_filtered_cluster_taxonomy(), "ArrowObject")
  expect_s3_class(get_removed_control_tax(), "ArrowObject")
  expect_s3_class(get_spikeins_tax(), "ArrowObject")
})

# carolus
R package for analysis of insect metabarcoding data

## Installation 

The `carolus` package can be install with `devtools` - if `devtools` is not installed on your machine please run `install.packages("devtools")` before proceeding.
To install the carolus package simply run
```R
devtools::install_github("station-linne/carolus")
```
in your `R` REPL (interactive prompt).
This will install the `carolus` package and its dependencies.

## Usage

At the moment, only a single function is supported: `taxon_search`.
To test it out, you need to have the ensure that you have the [IBA](https://www.insectbiomeatlas.org/) data available locally.
In the case that you have not downloaded it yet, the data is available on Figshare and is split between a
[raw dataset](https://figshare.scilifelab.se/articles/dataset/Amplicon_sequence_variants_from_the_Insect_Biome_Atlas_project/25480681/6)
containing raw amplicon sequence variants and a 
[processed dataset](https://figshare.scilifelab.se/articles/dataset/Processed_ASV_data_from_the_Insect_Biome_Atlas_Project/27202368/3)
containing processed data.
For more details on the data see the [Nature data paper](https://doi.org/10.1038/s41597-025-05151-0).

With the data available and `carolus` install, run
```R
library(carolus)
configure_carolus()
```
This command will help you create a config file which contain the paths of the downloaded data.
This config file is used by `carolus` to locate files in the datasets.

At the moment, `carolus` only supports a single function: `taxon_search`.
Test it out with
```R
taxon_search("Astata boops", "Species")
```
This will search for records of _Astata boops_ in the Swedish IBA dataset. 
Type `?taxon_search` to see further configuration options.

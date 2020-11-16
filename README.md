
<!-- README.md is generated from README.Rmd. Please edit that file -->

# DEGSimilar

<!-- badges: start -->

<!-- badges: end -->

The goal of DEGSimilar is to provide an easy pipeline in order to
analyze the results of Differential Gene Expression (DEG). This is done
by providing an easy method to compare DEGs of choice to other DEGs
based on BLAST similiarity within a user-specified database.

## Installation

Yout can install the package from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("GeorgeLy7/DEGSimilar")
```

In order to use this package the BLAST+ executable must be installed. It
may be installed from here:
<https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download>

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(DEGSimilar)
blastResults <- getBlastResults("./data-raw/newTest2.fasta","./data-raw/StHeBC3.fasta")
#> [1] "BLAST Databse already exists for fastaDatabase file, skipping database creation"
blastResults
#>   QueryID      SubjectID Perc.Ident Alignment.Length Mismatches Gap.Openings
#> 1 testing StHeBC3_7581.1      84.31              561         85            3
#> 2 testing StHeBC3_7581.2      83.24              561         91            3
#> 3 testing StHeBC3_3102.1      89.69              359         37            0
#> 4 testing StHeBC3_3102.2      83.41              416         61            8
#> 5 testing StHeBC3_3102.4      90.87              230         21            0
#>   Q.start Q.end S.start S.end      E Bits
#> 1     262   819     670   110 3e-154  545
#> 2     262   819     646    86 3e-144  512
#> 3     238   596     487   845 4e-128  459
#> 4     389   800       1   412 3e-104  379
#> 5     367   596       3   232  5e-83  309
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub\!

#!/usr/bin/env Rscript
## transcript produced by Segtools 1.1.14

## Experimental R transcript
## You may not be able to run the R code in this file exactly as written.

segtools.r.dirname <-
  system2("python",
          c("-c", "'import segtools; print segtools.get_r_dirname()'"),
          stdout = TRUE)

source(file.path(segtools.r.dirname, 'common.R'))
source(file.path(segtools.r.dirname, 'aggregation.R'))
save.gene.aggregations('/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-06-06_Segway_Run_4/aggregate_gene/', 'feature_aggregation.splicing', 'feature_aggregation.translation', '/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-06-06_Segway_Run_4/aggregate_gene/feature_aggregation.tab', normalize = TRUE, mnemonic_file = '', clobber = FALSE, significance = FALSE)

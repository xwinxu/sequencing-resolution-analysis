#!/usr/bin/env Rscript
## transcript produced by Segtools 1.1.14

## Experimental R transcript
## You may not be able to run the R code in this file exactly as written.

segtools.r.dirname <-
  system2("python",
          c("-c", "'import segtools; print segtools.get_r_dirname()'"),
          stdout = TRUE)

source(file.path(segtools.r.dirname, 'common.R'))
source(file.path(segtools.r.dirname, 'transition.R'))
save.transition('/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-06-06_Segway_Run_4/gmtk_parameters/', 'gmtk_parameters', '/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-06-06_Segway_Run_4/train_results/params/params.params', gmtk = TRUE, mnemonic_file = '', clobber = FALSE, ddgram = FALSE)

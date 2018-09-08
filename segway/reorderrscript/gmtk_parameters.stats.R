#!/usr/bin/env Rscript
## transcript produced by Segtools 1.1.14

segtools.r.dirname <-
  system2("python",
          c("-c", "'import segtools; print segtools.get_r_dirname()'"),
          stdout = TRUE)

source(file.path(segtools.r.dirname, 'common.R'))
#source(file.path(segtools.r.dirname, 'signal.R'))
#source(file.path(segtools.r.dirname, 'track_statistics.R'))
#save.track.stats('/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-06-06_Segway_Run_4/gmtk_parameters/', 'gmtk_parameters.stats', '/mnt/work1/users/home2/winniexu/hoffmangroup/wxu/data/2018-06-06_Segway_Run_4/train_results/params/params.params', gmtk = TRUE, as_regex = FALSE, mnemonic_file = '', clobber = FALSE, translation_file = '', track_order = list(), label_order = list())

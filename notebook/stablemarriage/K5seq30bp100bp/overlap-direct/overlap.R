#!/usr/bin/env Rscript
## transcript produced by Segtools 1.1.14

segtools.r.dirname <-
  system2("python",
          c("-c", "'import segtools; print segtools.get_r_dirname()'"),
          stdout = TRUE)

source(file.path(segtools.r.dirname, 'common.R'))
source(file.path(segtools.r.dirname, 'overlap.R'))
save.overlap.performance('./K5seq30bp100bp/overlap-direct', 'overlap.performance', './K5seq30bp100bp/overlap-direct/overlap.tab', row.normalize = 'FALSE', mnemonic_file = '', clobber = FALSE, col_mnemonic_file = '')
save.overlap.heatmap('./K5seq30bp100bp/overlap-direct', 'overlap', './K5seq30bp100bp/overlap-direct/overlap.tab', clobber = FALSE, col_mnemonic_file = '', cluster = FALSE, max_contrast = FALSE, row.normalize = 'FALSE', mnemonic_file = '')

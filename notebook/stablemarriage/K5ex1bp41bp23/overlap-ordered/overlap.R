#!/usr/bin/env Rscript
## transcript produced by Segtools 1.1.14

segtools.r.dirname <-
  system2("python",
          c("-c", "'import segtools; print segtools.get_r_dirname()'"),
          stdout = TRUE)

source(file.path(segtools.r.dirname, 'common.R'))
source(file.path(segtools.r.dirname, 'overlap.R'))
save.overlap.performance('./seg34r8/overlap-ordered', 'overlap.performance', './seg34r8/overlap-ordered/overlap.tab', row.normalize = 'FALSE', mnemonic_file = './seg34r8/overlap-direct/mnemonics1_new.txt', clobber = FALSE, col_mnemonic_file = './seg34r8/overlap-direct/mnemonics2_new.txt')
save.overlap.heatmap('./seg34r8/overlap-ordered', 'overlap', './seg34r8/overlap-ordered/overlap.tab', clobber = FALSE, col_mnemonic_file = './seg34r8/overlap-direct/mnemonics2_new.txt', cluster = FALSE, max_contrast = FALSE, row.normalize = 'FALSE', mnemonic_file = './seg34r8/overlap-direct/mnemonics1_new.txt')

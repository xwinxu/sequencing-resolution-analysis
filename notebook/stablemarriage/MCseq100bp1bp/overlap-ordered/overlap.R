#!/usr/bin/env Rscript
## transcript produced by Segtools 1.1.14

segtools.r.dirname <-
  system2("python",
          c("-c", "'import segtools; print segtools.get_r_dirname()'"),
          stdout = TRUE)

source(file.path(segtools.r.dirname, 'common.R'))
source(file.path(segtools.r.dirname, 'overlap.R'))
save.overlap.performance('./MCseq100bp1bp/overlap-ordered', 'overlap.performance', './MCseq100bp1bp/overlap-ordered/overlap.tab', row.normalize = 'FALSE', mnemonic_file = './MCseq100bp1bp/overlap-direct/mnemonics1_new.txt', clobber = FALSE, col_mnemonic_file = './MCseq100bp1bp/overlap-direct/mnemonics2_new.txt')
save.overlap.heatmap('./MCseq100bp1bp/overlap-ordered', 'overlap', './MCseq100bp1bp/overlap-ordered/overlap.tab', clobber = FALSE, col_mnemonic_file = './MCseq100bp1bp/overlap-direct/mnemonics2_new.txt', cluster = FALSE, max_contrast = FALSE, row.normalize = 'FALSE', mnemonic_file = './MCseq100bp1bp/overlap-direct/mnemonics1_new.txt')

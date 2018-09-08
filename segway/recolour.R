# recolour.R ##################################################################
description <- "Recolours the labels of a segway run according to my colouring
scheme (0,1,2,3,4,5,6,7,8,9 coloured)"

recolor <- c(
    "193,75,119",
    "216,132,68",
    "193,188,40",
    "134,210,67",
    "67,210,163",
    "67,182,210",
    "67,115,210",
    "131,106,210",
    "236,118,212",
    "160,160,160"
    )

library(optparse)

# Parse command line argument #################################################
if (!interactive()) {
    option.list <- list(
        make_option(
            c("--bed"),
            type = "character",
            default = NA,
            help = "segway.bed.gz annotation output file to recolor"
            )
        )

    opt.parser <- OptionParser(
        option_list = option.list,
        desc = description
        )
    opt <- parse_args(opt.parser)
    bed.fn <<- opt$bed
}

# Read input ##################################################################
open.file.handle <- function(filename) {
    if (endsWith(bed.fn, ".gz")) {
        return(gzfile(bed.fn))
    } else {
        return(file(bed.fn))
    }
}

bed.fh <- open.file.handle(bed.fn)
header <- readLines(bed.fh, n=1)
seg.bed <- read.table(bed.fh, sep="\t", skip=1, stringsAsFactors=FALSE)

# recolor
for (i in unique(seg.bed$V4)) {
    seg.bed[seg.bed$V4 == i, 9] <- recolor[i+1]
}

# overwrite input
out.fh <- open.file.handle(bed.fn)
writeLines(header, out.fh)
write.table(
    seg.bed,
    out.fh,
    sep="\t",
    row.names=FALSE,
    col.names=FALSE,
    quote=FALSE
    )

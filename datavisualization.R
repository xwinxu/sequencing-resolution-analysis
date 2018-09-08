#FUNCTION FOR CREATING SEGMENT LABELS VS PROTEINS HEATMAP USING GMTK PARAMETERS OUTPUT
make_raw_heatmap <- function(csv1, csv2, label_dir){
  library(ComplexHeatmap)
  gmtkdata1 <- read.csv(csv1, header=TRUE, sep=",", row.names = 1)
  gmtkdata2 <- read.csv(csv2, header=TRUE, sep=",", row.names = 1)
  labelpath <- capture.output(cat("/scratch/mordor/hoffmangroup/wxu/data/", label_dir, "/overlap-direct/label_map.tab", sep = ""))
  labelmap <- read.csv(labelpath, sep="\t", skip=2, header=FALSE)
  
  # gmtkdata2 <- gmtkdata2[names(gmtkdata1)]
  gmtkdata1 <- gmtkdata1[, order(colnames(gmtkdata1))]
  gmtkdata2 <- gmtkdata2[, order(colnames(gmtkdata2))]
  rownames(gmtkdata1) <- paste("A", rownames(gmtkdata1), sep = "")
  rownames(gmtkdata2) <- paste("B", rownames(gmtkdata2), sep = "")
  ordered.map <- labelmap[order(labelmap$V1), ]
  reorderindex <- (ordered.map$V2 + 1)
  reordered.gmtkdata1 <- gmtkdata1[reorderindex, ]
  gmtkdata1 <- reordered.gmtkdata1
  my_palette <- colorRampPalette(c("mintcream", "#eeeaf3", "#245888"))(n = 299)
  # my_palette <- colorRampPalette(c("#eeeaf3", "#72a1c7", "#245888"))(n = 299)
 # my_palette <- colorRampPalette(c("mintcream", "lightskyblue", "navyblue"))(n = 299)
  data1 <- data.matrix(gmtkdata1)
  data2 <- data.matrix(gmtkdata2)
  key1 <- capture.output(cat("Run", "1"))
  key2 <- capture.output(cat("Run", "2"))
  ht1 <- Heatmap(data1, name = "Value", cluster_rows = FALSE, cluster_columns = FALSE, show_row_dend = FALSE, show_column_dend = FALSE, column_title = "Trained GMTK Mean Signal A", col = my_palette, row_names_side = "right")
  ht2 <- Heatmap(data2, name = "Value", cluster_rows = FALSE, cluster_columns = FALSE, show_row_dend = FALSE, show_column_dend = FALSE, column_title = "Trained GMTK Mean Signal B", col = my_palette, row_names_side = "left")
  list = ht1 + ht2
  draw(list, gap = unit(1, "cm"), row_title = "Segment Label", row_title_side = "left")
}

# FUNCTION FOR CREATING A DATA MATRIX WITH LOD AND HOD FOR DETERMINING PSEUDOCOUNT TO ADD FOR EACH PROTEIN AND ASSAY
create_LODHOD_df <- function(names, csv1){
  rownames <- read.csv(names, header = FALSE)
  LODHOD <- read.csv(csv1, header = FALSE, sep = ",")
  LODHOD <- as.matrix(LODHOD)
  rownames(LODHOD) <- rownames$V1
  rownames(LODHOD)[16] <- "MCFseqFoxA1"
  rownames(LODHOD)[13] <- "MCFexFoxA1"
  colnames(LODHOD) <- c("LOD", "HOD")
  return(LODHOD)
}
fetch_LOD_HOD <- function(dmatrix, assay){
  LOD <- dmatrix[assay, "LOD"]
  HOD <- dmatrix[assay, "HOD"]
  x = list("LOD" = LOD, "HOD" = HOD)
  return(x)
}

# FUNCTION FOR GENERATING HEATMAP TAKING RATIOS OF THE TWO DATA FRAMES FROM EACH OVERLAP.PY STABLE MARRIAGE RUN
# Column normalized
make_ratio_heatmap <- function(csv1, csv2, label_dir, marriage.name, assay.name){
  library(ComplexHeatmap)
  gmtkdata1 <- read.csv(csv1, header=TRUE, sep=",", row.names = 1)
  gmtkdata2 <- read.csv(csv2, header=TRUE, sep=",", row.names = 1)
  # gmtkdata1 <- read.csv("/scratch/mordor/hoffmangroup/wxu/data/2018-06-01_Segway_Run_3/gmtk_parameters/gmtk_parameters.stats.csv", header=TRUE, sep=",", row.names = 1)
  # gmtkdata2 <- read.csv("/scratch/mordor/hoffmangroup/wxu/data/2018-06-06_Segway_Run_4/gmtk_parameters/gmtk_parameters.stats.csv", header=TRUE, sep=",", row.names = 1)
  labelpath <- capture.output(cat("/scratch/mordor/hoffmangroup/wxu/data/", label_dir, "/overlap-direct/label_map.tab", sep = ""))
  # labelpath <- capture.output(cat("/scratch/mordor/hoffmangroup/wxu/data/2018-08-03_Stable_Marriage_Run_8/", "K5seq100bp4100bp23", "/overlap-direct/label_map.tab", sep = ""))
  labelmap <- read.csv(labelpath, sep="\t", skip=2, header=FALSE)
  gmtkdata1 <- gmtkdata1[, order(colnames(gmtkdata1))]
  gmtkdata2 <- gmtkdata2[names(gmtkdata1)]
  ordered.map <- labelmap[order(labelmap$V1), ]
  reorderindex <- (ordered.map$V2 + 1)
  reordered.gmtkdata1 <- gmtkdata1[reorderindex, ]
  gmtkdata1 <- reordered.gmtkdata1
  # gmtkdata2 <- gmtkdata2[reorderindex, ]
  my_palette <- colorRampPalette(c("mintcream", "lightskyblue", "navyblue"))(n = 299)
  data1 <- data.matrix(gmtkdata1)
  data2 <- data.matrix(gmtkdata2)
  data2
#FUNCTION THAT UN-NORMALIZES THE SEGWAY OUTPUT
  denormalize <- function(protein.name, gmtk.means, lod.hod, assay.name) {
    proteinnames <- colnames(gmtk.means)
    row.name <- paste(assay.name, protein.name, sep="")
    print(row.name)
    LOD <- lod.hod[row.name, "LOD"]
    HOD <- lod.hod[row.name, "HOD"]
    pseudocount <- asinh(LOD/2)
    gmtk.means[,protein.name] <- (gmtk.means[, protein.name]*(HOD-0)) + 0
    gmtk.means[,protein.name] <- gmtk.means[,protein.name] + pseudocount
  }
  
  proteinnames <- colnames(data1)
  #apply loops through all the protein names and passes it into the function
  colunnormdata1 <- sapply(proteinnames, denormalize, data1, lod.hod, assay.name)
    # colunnormdata1 <- sapply(proteinnames, denormalize, data1, lod.hod, "K562seq")

  colunnormdata1
  colunnormdata2 <- sapply(proteinnames, denormalize, data2, lod.hod, assay.name)
    # colunnormdata2 <- sapply(proteinnames, denormalize, data2, lod.hod, "K562seq")

  colunnormdata2
  # cnormselection <- apply(selection, 2, norm <- function(x){return ((x-min(x))/(max(x)-min(x)))})
  nonormdivide1 <- colunnormdata1/colunnormdata2
  nonormdivide1
  # print(divide1)
  nonormdivide2 <- colunnormdata2/colunnormdata1
  nonormdivide2
  # print(divide2)
  
  max1 <- max(nonormdivide1)
  max1
  max2 <- max(as.numeric(unlist(nonormdivide2)))
  divide1 <- nonormdivide1/(max1)
  divide2 <- nonormdivide2/(max2)
  
  # divide1 <- apply(nonormdivide1, 2, norm <- function(x){return ((x-min(x))/(max(x)-min(x)))})
  # divide2 <- apply(nonormdivide2, 2, norm <- function(x){return ((x-min(x))/(max(x)-min(x)))})
  # divide1
  my_palette <- colorRampPalette(c("mintcream", "#eeeaf3", "#245888"))(n = 299)
  key1 <- capture.output(cat("Run", "1"))
  key2 <- capture.output(cat("Run", "2"))
  ht_list = Heatmap(divide1, name = key1, cluster_rows = FALSE, show_row_dend = FALSE, show_column_dend = FALSE, column_title = "Protein Marks 1 into 2", row_title = "Labels", col = my_palette) +
            Heatmap(divide2, name = key2, cluster_rows = FALSE, show_row_dend = FALSE, show_column_dend = FALSE, column_title = "Protein Marks 2 into 1", row_title = "Labels", col = my_palette)
  draw(ht_list, gap = unit(1, "cm"), column_title = marriage.name, column_title_side = "top")
}

# FUNCTION FOR BP OVERLAP, AND NORMALIZED REORDERED LABELS HEATMAP BY ROW AND BY COLUMN
plot_reorder_labels <- function(csv_and_label_dir){
  library(ComplexHeatmap)
  csv_path <- capture.output(cat("/scratch/mordor/hoffmangroup/wxu/data/", csv_and_label_dir, "/overlap-direct/overlap.tab", sep = ""))
  labelpath <- capture.output(cat("/scratch/mordor/hoffmangroup/wxu/data/", csv_and_label_dir, "/overlap-direct/label_map.tab", sep = ""))
  # csv_path <- capture.output(cat("/scratch/mordor/hoffmangroup/wxu/data/2018-06-19_Segway_Analysis/", "K5seq100bp4100bp23", "/overlap-direct/overlap.tab", sep = ""))
  # labelpath <- capture.output(cat("/scratch/mordor/hoffmangroup/wxu/data/2018-06-19_Segway_Analysis/", "K5seq100bp4100bp23", "/overlap-direct/label_map.tab", sep = ""))
  
  labelmap <- read.csv(labelpath, sep="\t", skip=2, header=FALSE)
  overlap <- read.csv(csv_path, sep="\t", skip=1, header=TRUE)
  label <- overlap[,1]
  labelA <- paste("A", label, sep="")
  lastcolindex <- ncol(overlap)
  # none <- overlap[,lastcolindex-1]
  overlap <- as.matrix(overlap[,-c(1, lastcolindex)])
  selection <- overlap[,1:ncol(overlap)-1]
  # NOTE: row normalization gives you a transpose as a result!
  rnormselection <- t(apply(selection, 1, norm <- function(x){return ((x-min(x))/(max(x)-min(x)))}))
  cnormselection <- apply(selection, 2, norm <- function(x){return ((x-min(x))/(max(x)-min(x)))})
  colnames(selection) <- labelA
  # selection <- cbind(selection, none)
  # print(selection)
  colnames(rnormselection) <- labelA
  # rnormselection <- cbind(rnormselection, none)
  # print(rnormselection)
  colnames(cnormselection) <- labelA
  # cnormselection <- cbind(cnormselection, none)
  ordered.map <- labelmap[order(labelmap$V1), ]
  reorderindex <- (ordered.map$V2 + 1)
  reordered.overlap <- selection[reorderindex, ]
  selection <- reordered.overlap
  rnormselection <- rnormselection[reorderindex, ]
  cnormselection <- cnormselection[reorderindex, ]
  #paste("B", ordered.map$V2, sep="")
  rownames(selection) <- paste("B", ordered.map$V2, sep="")
  rownames(rnormselection) <- paste("B", ordered.map$V2, sep="")
  rownames(cnormselection) <- paste("B", ordered.map$V2, sep="")
  my_palette <- colorRampPalette(c("mintcream", "#eeeaf3", "#245888"))(n = 299)
  # my_palette <- colorRampPalette(c("#e0ecf4", "#eeeaf3", "#245888"))(n = 299)
  #my_palette <- colorRampPalette(c("#e0ecf4", "#e0ecf4", "#8856a7"))(n = 299)
  # my_palette <- colorRampPalette(c("mintcream", "lightskyblue", "navyblue"))(n = 299)
  # par(bg = 'black', fg='white')
 htlist = Heatmap(selection, name = "Value", cluster_rows = FALSE, cluster_columns = FALSE, show_row_dend = FALSE, show_column_dend = FALSE, column_title = "BP Overlap of Labels Only", row_title = "Labels Set A vs B", col = my_palette) +
            Heatmap(cnormselection, name =  "Value Norm", cluster_rows = FALSE, cluster_columns = FALSE, show_row_dend = FALSE, show_column_dend = FALSE, column_title = "Column Normalized", row_title = "Labels Set A vs B", col = my_palette) +
            Heatmap(rnormselection, name = "Value Norm", cluster_rows = FALSE, cluster_columns = FALSE,show_row_dend = FALSE, show_column_dend = FALSE, column_title = "Row Normalized", row_title = "Labels Set A vs B", col = my_palette)
  draw(htlist, gap = unit(1, "cm"), column_title = "", column_title_side = "top")
}

# BIPARTITE GRAPH WITH THRESHOLD CUT-OFFS FOR ARROWS
load.data <- function(overlap.dir, threshold.value) {
  overlap <- read.csv(capture.output(cat("/scratch/mordor/hoffmangroup/wxu/data/", overlap.dir, "/overlap-direct/overlap.tab", sep = "")), sep="\t", skip=1, header=TRUE)
  lastcolindex <- ncol(overlap)
  #grab sum of last column
  total <- sum(as.numeric(overlap$total))
  #get only the columns that are not labels, none, and total
  overlap <- as.matrix(overlap[,-c(1, lastcolindex-1, lastcolindex)])
  #normalize the matrix
  norm_overlap <- apply(overlap, 2, norm <- function(x){return (x/total)})
  #get the row, column indexes respectively
  edge <- as.data.frame(which(norm_overlap>as.numeric(threshold.value), arr.in = TRUE))
  #subtract one from the indices to get the apt label
  edge <- edge -1
  return(edge)
}

get_bipartite <- function(edge){
  require(igraph)                                                                  
  require(gtools)                                                   

  edge[,1] <- paste("B", edge[,1], sep="")
  edge[,2] <- paste("A", edge[,2], sep="")
                                                                                   
  # Order the vertices (which are mixed strings)                                  
  ordered.vertices <- unique(c(mixedsort(edge[,1]), mixedsort(edge[,2])))              
                                                                                   
  # Setup graph                                                                    
  bidata2 <- graph.data.frame(edge, vertices = ordered.vertices, directed = FALSE)
  # print(bidata2)
  V(bidata2)$type <- bipartite_mapping(bidata2)$type                              
  V(bidata2)$label.color <- "black"                                                
  V(bidata2)$color <- ifelse(V(bidata2)$type, "lightblue", "lightpink")              
  V(bidata2)$shape <- ifelse(V(bidata2)$type, "circle", "square")                  
  E(bidata2)$color <- "lightgray"                                                  
  V(bidata2)$label.cex <- 1                                                        
  V(bidata2)$frame.color <-  "lightgray"                                                
  V(bidata2)$size <- 18                                                            
                                                                                   
  # Reorder layout    
  # Add -1 for the 2nd column sort, so that it is in descending instead of ascending order (so 1-> 0); then we get x-axis to y-axis label readings
  l <- layout.bipartite(bidata2)
  # sort the bipartite mapping by the 2nd column first, then the first. Negate all values, then sort in asending so -1 -> -9
  l <- l[order(-l[,2], -l[,1]),]
  # to get a horizontal mapping                                                    
  bd2 <- plot(bidata2, layout = l[, c(2,1)])                                      
  return(bd2)                                                                      
}

#Example calls
#make_raw_heatmap("/scratch/mordor/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562seq/gmtk_parameters2.1/gmtk_parameters.stats.csv", "/scratch/mordor/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562seq/gmtk_parameters2.2/gmtk_parameters.stats.csv", "2018-08-03_Stable_Marriage_Run_8/K5seq100vseq1")
#
#plot_reorder_labels("2018-08-03_Stable_Marriage_Run_8/K5seq100vseq1")
#
#make_ratio_heatmap("/scratch/mordor/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562seq/gmtk_parameters2.1/gmtk_parameters.stats.csv", "/scratch/mordor/hoffmangroup/wxu/data/2018-08-01_Segway_Run_8/K562seq/gmtk_parameters2.2/gmtk_parameters.stats.csv", "2018-08-03_Stable_Marriage_Run_8/K5seq100vseq1", "Stable Marriage K562 ChIP-seq 100bp vs 1 bp", "K562seq")
#
#get_bipartite(load.data("2018-08-03_Stable_Marriage_Run_8/K5seq100vseq1", 0.015))
#
##Stable Marriage Reverse
#plot_reorder_labels("2018-08-16_Stable_Marriage_Run_8_Reverse/rK5seq100v1")

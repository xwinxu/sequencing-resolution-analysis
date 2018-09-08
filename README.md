# Exploring the Differential Effects of Sequencing Resolution on Semi-Automated Genome Annotations
A project from Summer 2018 that compared the utility of newer ChIP methods ChIP-exo and ChIP-nexus on its effects on Segway's ability to generate annotations from this data of higher signal to noise ratio and near single base pair resolution.

## Pipeline
1. Data Cleaning (data_preprocessing/)
    - Download raw data from ENCODE project and NCBI SRA (getSRR.sh)
    - Convert to bedgraph and sort data based on threshold cut off (fq_to_bam.sh)
    - QC with PhantomPeakQualTools + peak calling with MACS2 to generate bedgraphs (MACS2/ & PhantomPeakQualTools/)
    - Store data in genomedata archive (bedgraph_to_genomedata.sh)
2. Run Segway (segway/)
    - Training then identification rounds (trainsegway.sh & annotate.sh)
    - Set minibatch training of 10 round on 1% of the genome
    - Try with 5 different resolutions: 100bp, 1bp, 2bp, 30bp, 50bp
3. Analyze Results
    - Recolour segway annotations with 10 different colours for visualization in genome browser (segway/)
    - Run stable marriage Hungarian algorithm on annotations (stablemarriage/)
    - Graph heatmaps and bipartite graphs in R. Account for negative/NaNs by adding pseudocount (LOD/2) to all data points prior to normalizing (pseudocount/)
    - All graph generating functions in datavisualization.R file, generated some in R notebook (can find in lab notebook)
4. Miscellaneous
    - Script to clean up on the cluster (segway/seg_cleanup.sh)
    - Alternate attempt at finding the LOD via the genomedata archives that were already generated (segway/runthroughcoords.py)
    - Get average counts from bedgraph file (data_preprocessing/getavg.sh)
    - Optional conversion from bigwig to wiggle format (data_preprocessing/bigwig_to_wiggle.sh)

## Links:
[Lab Notebook](http://mordor/hoffmanlab/people/wxu/internal/2018/notebook.html)
[Final Presentation](https://docs.google.com/presentation/d/1FhPC75eeJJSTKwuKS3tBcom6UNmZ6IY1GL0pMXwbf70/edit?usp=sharing)

###Acknowledgements
The student researcher would like to thank Dr. Hoffman for the opportunity + resources and Francis Nguyen for mentorship. Special thanks to Coby, Sam, and Davide of the Hoffman Lab as well.

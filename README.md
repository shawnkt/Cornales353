# Cornales353
This repository contains scripts and intermediate files for Cornales353 project.

r2t-hyb_manual.pdf details steps on the analysis pipeline.

**scripts**: Contains scripts used for analysis. Also contains the [Angiosperms353](https://academic.oup.com/sysbio/article/68/4/594/5237557) targets file and a list of the gene IDs. The scripts are mostly designed to create and submit multiple job submission scripts on a HPC cluster.

**supercontigs**: Contains multifasta files for each gene target with supercontig sequences output by [HybPiper](https://github.com/mossmatters/HybPiper).

**alignments**: Contains multiple sequence alignments (MSA) from [PASTA](https://github.com/smirarab/pasta) for each gene target.

**ML_trees** Contains maxiumum likelihood gene trees inferred using [IQ-TREE](http://www.iqtree.org/).

**UFboot_trees**: Contains bootstrap replicate trees using the [IQ-TREE](http://www.iqtree.org/) UFboot feature.

**astral_outputs**: Contains outputs from the program [ASTRAL-III](https://github.com/smirarab/ASTRAL).

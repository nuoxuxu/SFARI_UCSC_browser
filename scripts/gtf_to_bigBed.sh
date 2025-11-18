#!/bin/bash
fetchChromSizes hg38 > proc/hg38.chrom.sizes

gtfToGenePred /scratch/nxu/SFARI/nextflow_results/V47/orfanage/UCSC_tracks/orfanage_UCSC.gtf proc/input.genePred

genePredToBed proc/input.genePred proc/input.bed

sort -k1,1 -k2,2n proc/input.bed > proc/input.sorted.bed

bedToBigBed proc/input.sorted.bed proc/hg38.chrom.sizes out/output.bb
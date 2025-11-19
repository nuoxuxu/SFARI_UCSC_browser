#!/bin/bash

# Convert ORFanage GTF to bigBed format
fetchChromSizes hg38 > proc/hg38.chrom.sizes

gtfToGenePred /scratch/nxu/SFARI/nextflow_results/V47/orfanage/UCSC_tracks/orfanage_UCSC.gtf proc/input.genePred

genePredToBed proc/input.genePred proc/input.bed

sort -k1,1 -k2,2n proc/input.bed > proc/input.sorted.bed

bedToBigBed proc/input.sorted.bed proc/hg38.chrom.sizes out/output.bb

# Convert peptide GTF to bigBed format

awk 'BEGIN{OFS="\t"} $3=="exon" {
    # Find the transcript_id
    match($0, /transcript_id "([^"]+)"/, a);
    
    # Print BED6 with Score (Col 5) set to 0
    print $1, $4-1, $5, a[1], "0", $7
}' /scratch/nxu/SFARI/nextflow_results/V47/orfanage/UCSC_tracks/detected_peptides.gtf > proc/output_pep.bed

sort -k1,1 -k2,2n proc/output_pep.bed > proc/output_pep.sorted.bed

bedToBigBed proc/output_pep.sorted.bed proc/hg38.chrom.sizes hg38/pep_output.bb
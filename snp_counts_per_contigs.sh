#!/bin/bash

zcat *.mafs.gz | awk 'NR>1 {count[$1]++} END {for (contig in count) print contig, count[contig]}' > snp_counts.txt

# Step 2: Extract contig lengths
awk '{print $1, $2}' transcriptome_stats_urartu_TrEx_per_sequence.txt > contig_lengths.txt

# Step 3: Merge the files
join -1 1 -2 1 <(sort snp_counts.txt) <(sort contig_lengths.txt) > snp_per_contigs.txt

# Display the result
head snp_per_contigs.txt

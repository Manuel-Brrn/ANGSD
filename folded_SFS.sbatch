#!/bin/bash
#SBATCH --job-name=realSFS_folded_urartu_TrEx_Samtool_no_soft_clipped_reads
#SBATCH --output=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_out.txt
#SBATCH --error=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=9G
#SBATCH --time=10:00:00
#SBATCH --partition=agap_normal

## Step 2: Calculate the Folded Site Frequency Spectrum (SFS)

saf_idx_path=/home/barrientosm/scratch/angsd_analysis/urartu/samtool_GL/saf_no_soft_clipped_reads_TrEx
output_dir=/home/barrientosm/scratch/angsd_analysis/urartu/samtool_GL/saf_no_soft_clipped_reads_TrEx
# Use the realSFS program to calculate the folded SFS
./misc/realSFS $saf_idx_path/urartu.saf.idx \
               -P 10 \
               -fold 1 \
               > $output_dir/urartu_TrMo_folded.sfs

# Explanation of Parameters:

#   -saf.idx: Input file generated from Step 1 containing the site frequency likelihoods.
#   -nThreads 10: Enables parallel processing using 10 threads for faster computation.
#   -fold 1: Calculates the folded SFS since no ancestral information is available.
#   > output.sfs: Saves the calculated SFS to the specified output file.

## output.thetas.gz:
#    This file contains Watterson's theta and other population genetic statistics calculated by ANGSD.
#    It stores the estimated nucleotide diversity (π), Watterson's theta (θW), and Tajima's D per site or per window.
#    The file is compressed in gzip format.

## output.thetas.idx:
  #  This is the index file corresponding to speltoides.thetas.gz.
 #   It allows random access to the compressed data, which is useful when analyzing large datasets or performing window-based analyses.

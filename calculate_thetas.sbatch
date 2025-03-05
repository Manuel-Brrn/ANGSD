#!/bin/bash
#SBATCH --job-name=theta_urartu_TrEx_Samtool_bams_cleaned
#SBATCH --output=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_out.txt
#SBATCH --error=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=9G
#SBATCH --time=10:00:00
#SBATCH --partition=agap_normal

## Step 3: Calculate thetas for each site using realSFS saf2theta

# Run the realSFS saf2theta command to calculate the theta values for each site

saf_idx=/home/barrientosm/scratch/angsd_analysis/urartu/samtool_GL/saf_no_soft_clipped_reads_TrEx/urartu.saf.idx
sfs=/home/barrientosm/scratch/angsd_analysis/urartu/samtool_GL/saf_no_soft_clipped_reads_TrEx/urartu_TrMo_folded.sfs
output_dir=/home/barrientosm/scratch/angsd_analysis/urartu/samtool_GL/saf_no_soft_clipped_reads_TrEx

./misc/realSFS saf2theta $saf_idx \
                        -sfs $sfs \
                        -fold 1 \
                        -P 24 \
                        -outname $output_dir/urartu

# Explanation of Parameters:

#   -saf.idx: The input file from Step 1 containing the SAF likelihoods.
#   -sfs: The folded site frequency spectrum from Step 2.
#   -nThreads 10: Use 10 threads for parallel computation.
#   -outname: Prefix for the output files. This will generate "out.thetas.gz" and "out.thetas.idx".


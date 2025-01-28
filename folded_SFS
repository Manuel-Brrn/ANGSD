#!/bin/bash
#SBATCH --job-name=realSFS_folded
#SBATCH --output=./log_%j_%x_out.txt
#SBATCH --error=./log_%j_%x_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=9G
#SBATCH --time=10:00:00
#SBATCH --partition=agap_normal

## Step 2: Calculate the Folded Site Frequency Spectrum (SFS)

# Use the realSFS program to calculate the folded SFS
./misc/realSFS /home/barrientosm/scratch/angsd_output/Yang_TrMo_saf.saf.idx \
               -nThreads 10 \
               -fold 1 \
               > /home/barrientosm/scratch/angsd_output/Yang_TrMo.sfs

# Explanation of Parameters:

#   -saf.idx: Input file generated from Step 1 containing the site frequency likelihoods.
#   -nThreads 10: Enables parallel processing using 10 threads for faster computation.
#   -fold 1: Calculates the folded SFS since no ancestral information is available. 
#   > output.sfs: Saves the calculated SFS to the specified output file.

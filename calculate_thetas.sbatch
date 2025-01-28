#!/bin/bash
#SBATCH --job-name=realSFS_theta
#SBATCH --output=./log_%j_%x_out.txt
#SBATCH --error=./log_%j_%x_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=9G
#SBATCH --time=10:00:00
#SBATCH --partition=agap_normal

## Step 3: Calculate thetas for each site using realSFS saf2theta

# Run the realSFS saf2theta command to calculate the theta values for each site
./misc/realSFS saf2theta /home/barrientosm/scratch/angsd_output/Yang_TrMo_saf.saf.idx \
                        -sfs /home/barrientosm/scratch/angsd_output/Yang_TrMo.sfs \
                        -nThreads 10 \
                        -outname /home/barrientosm/scratch/angsd_output/Yang_TrMo_theta

# Explanation of Parameters:

#   -saf.idx: The input file from Step 1 containing the SAF likelihoods.
#   -sfs: The folded site frequency spectrum from Step 2.
#   -nThreads 10: Use 10 threads for parallel computation.
#   -outname: Prefix for the output files. This will generate "out.thetas.gz" and "out.thetas.idx".

#!/bin/bash
#SBATCH --job-name=thetaStat_TajimaD
#SBATCH --output=./log_%j_%x_out.txt
#SBATCH --error=./log_%j_%x_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=9G
#SBATCH --time=10:00:00
#SBATCH --partition=agap_normal

## Step 4: Calculate Tajima's D and other statistics using thetaStat

# Run the thetaStat do_stat command to calculate Tajima's D and other statistics
./misc/thetaStat do_stat /home/barrientosm/scratch/angsd_output/Yang_TrMo_theta.thetas.idx \
                        > /home/barrientosm/scratch/angsd_output/Yang_TrMo_tajimaD.txt

# Explanation of Parameters:

#   -thetas.idx: The input file from Step 3 containing the theta values.
#   > output: The output will be saved in a text file containing the Tajima's D and other statistics.

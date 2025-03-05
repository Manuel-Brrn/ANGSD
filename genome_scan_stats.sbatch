#!/bin/bash
#SBATCH --job-name=thetaStat_TajimaD_samtool_urartu_TrEx_bams_cleaned
#SBATCH --output=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_out.txt
#SBATCH --error=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=9G
#SBATCH --time=10:00:00
#SBATCH --partition=agap_normal

## Step 4: Calculate Tajima's D and other statistics using thetaStat

# Run the thetaStat do_stat command to calculate Tajima's D and other statistics
#./misc/thetaStat do_stat /home/barrientosm/scratch/angsd_output/Yang_TrMo_theta.thetas.idx \
#                        > /home/barrientosm/scratch/angsd_output/Yang_TrMo_tajimaD.txt

# Explanation of Parameters:

#   -thetas.idx: The input file from Step 3 containing the theta values.
#   > output: The output will be saved in a text file containing the Tajima's D and other statistics.

# This will calculate per-site statistics, but we can also calculate them over windows of sites
# using the -win and -step parameters to specify the size of the window and the step size between windows.

# By using the -win 50000 and -step 10000, we calculate Tajima's D over windows of 50,000 sites
# with a 10,000-site step between windows. The output is stored in "theta.thetasWindow.gz".

thetas_idx=/home/barrientosm/scratch/angsd_analysis/urartu/samtool_GL/saf_no_soft_clipped_reads_TrEx/urartu.thetas.idx
output_dir=/home/barrientosm/scratch/angsd_analysis/urartu/samtool_GL/saf_no_soft_clipped_reads_TrEx

./misc/thetaStat do_stat $thetas_idx \
    -outnames $output_dir/urartu

# Explanation of Parameters:

#   -do_stat: Calculate statistics (including Tajima's D) from the .thetas.idx file.
#   -win 50000: Specifies that the calculations should be done in windows of 50,000 sites.
#   -step 10000: Specifies that the window should move by 10,000 sites each time (i.e., the step size).
#Window size: 50,000 sites
#Step size: 10,000 sites
#First window: Sites 1 to 50,000
#Second window: Sites 10,001 to 60,000
#Third window: Sites 20,001 to 70,000
#and so on...
#   -outnames: Specifies the name for the output file, which will be saved as "Yang_TrMo.theta.thetasWindow.gz" in the output directory.

# The output will contain Tajima's D and other statistics calculated for each window of 50,000 sites
# with a step size of 10,000 sites, giving you a smoothed estimate of the statistics across the genome.

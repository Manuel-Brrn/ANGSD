#!/bin/bash
#SBATCH --job-name=angsd_sfs
#SBATCH --output=./log_%j_%x_out.txt
#SBATCH --error=./log_%j_%x_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=9G
#SBATCH --time=20:00:00
#SBATCH --partition=agap_normal

# Input: List of BAM files containing the samples
bam_list="/home/barrientosm/scratch/GeCKO/CONFIG/WORKFLOWS_OUTPUTS/READ_MAPPING/speltoides_transcriptome_YANG_2023/bams_list.txt"

# Output: Prefix for the output files
output_prefix="coverage_TrMo_YANG"

# Calculate depth for all individuals across the genome (or specific chromosome)
# Use -doDepth 1 to calculate depth, -doCounts 1 to count number of sites per depth
angsd -bam $bam_list -doDepth 1 -out $output_prefix -doCounts 1

# Example of additional filtering for mapping quality and nucleotide quality:
# Use -minMapQ 30 to filter for reads with a minimum mapping quality of 30
# Use -minQ 20 to filter for reads with a minimum base quality of 20
angsd -bam $bam_list -doDepth 1 -out ${output_prefix}_strict -doCounts 1 -minMapQ 30 -minQ 20

echo "Depth calculation is complete. Check the following output files:"
echo "$output_prefix.depthSample"
echo "$output_prefix.depthGlobal"

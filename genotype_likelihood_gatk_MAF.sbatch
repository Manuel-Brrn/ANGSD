#!/bin/bash
#SBATCH --job-name=urartu_maf_ref
#SBATCH --output=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_out.txt
#SBATCH --error=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=9G
#SBATCH --time=20:00:00
#SBATCH --partition=agap_normal

output_dir="/home/barrientosm/scratch/angsd_analysis/urartu/gatk_GL/maf"
# Input: List of BAM files containing the samples
#bam_list_speltoides="/home/barrientosm/scratch/GeCKO/CONFIG/WORKFLOWS_OUTPUTS/READ_MAPPING/speltoides_transcriptome_YANG_2023/bams_list.txt"
bam_list_urartu="/home/barrientosm/scratch/GeCKO/CONFIG/WORKFLOWS_OUTPUTS/READ_MAPPING/urartu_TrMo_mapping/bams_list_corrected.txt"

./angsd -bam $bam_list_urartu \
  -GL 2 \
  -minMapQ 30 \
  -minQ 20 \
  -only_proper_pairs 1 \
  -remove_bads 1 \
  -ref /home/barrientosm/scratch/GeCKO/Refs/urartu/urartu_transcriptome.fasta \
  -doGlf 2 \
  -out $output_dir/urartu \
  -doMajorMinor 1 \
  -doMaf 1 \
  -minMaf 0.05 \
  -SNP_pval 1e-6 \
  -minInd 7 \
  -setMinDepthInd 10 \
  -P 5

 # -doMajorMinor 1 \
 # use a maximum likelihood approach to choose the major and minor alleles

# -doMaf 1: Known major, and Known minor
# Here both the major and minor allele is assumed to be known (inferred or given by user)
# The allele frequency is the obtained using based on the genotype likelihoods



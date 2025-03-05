#!/bin/bash
#SBATCH --job-name=urartu_maf_syk_ref
#SBATCH --output=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_out.txt
#SBATCH --error=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=9G
#SBATCH --time=20:00:00
#SBATCH --partition=agap_normal

output_dir="/home/barrientosm/scratch/angsd_analysis/urartu/SYK_GL/maf"

# Input: List of BAM files containing the samples
#bam_list_speltoides="/home/barrientosm/scratch/GeCKO/CONFIG/WORKFLOWS_OUTPUTS/READ_MAPPING/speltoides_transcriptome_YANG_2023/bams_list.txt"

bam_list_urartu="/home/barrientosm/scratch/GeCKO/CONFIG/WORKFLOWS_OUTPUTS/READ_MAPPING/urartu_TrMo_mapping/bams_list_corrected.txt"

./angsd -bam $bam_list_urartu \
  -GL 4 \
  -minMapQ 30 \
  -minQ 20 \
  -only_proper_pairs 1 \
  -remove_bads 1 \
  -ref /home/barrientosm/scratch/GeCKO/Refs/urartu/urartu_transcriptome.fasta \
  -doCounts 1 \
  -doGlf 2 \
  -out $output_dir/urartu \
  -doMajorMinor 2 \
  -doMaf 1 \
  -minMaf 0.05 \
  -SNP_pval 1e-6 \
  -minInd 7 \
  -setMinDepthInd 10 \
  -P 5

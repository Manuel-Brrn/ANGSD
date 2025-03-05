#!/bin/bash
#SBATCH --job-name=saf_urartu_GL2_saf
#SBATCH --output=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_out.txt
#SBATCH --error=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=9G
#SBATCH --time=20:00:00
#SBATCH --partition=agap_normal

output_dir="/home/barrientosm/scratch/angsd_analysis/urartu/gatk_GL/saf"

# Input: List of BAM files containing the samples
#bam_list_speltoides="/home/barrientosm/scratch/GeCKO/CONFIG/WORKFLOWS_OUTPUTS/READ_MAPPING/speltoides_transcriptome_YANG_2023/bams_list.txt"

bam_list_urartu="/home/barrientosm/scratch/GeCKO/CONFIG/WORKFLOWS_OUTPUTS/READ_MAPPING/urartu_TrMo_mapping/bams_list_corrected.txt"

./angsd -bam $bam_list_urartu \
  -GL 2 \
  -doGlf 4 \
  -doSaf 1 \
  -anc /home/barrientosm/scratch/GeCKO/Refs/urartu/urartu_transcriptome.fasta \
  -remove_bads 1 \
  -minMapQ 30 \
  -minQ 20 \
  -only_proper_pairs 1 \
  -minInd 7 \
  -setMinDepthInd 10 \
  -P 4 \
  -out $output_dir/urartu

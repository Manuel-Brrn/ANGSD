#!/bin/bash
#SBATCH --job-name=urartu_TrEx_maf_ref_not_soft_clipped_reads
#SBATCH --output=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_out.txt
#SBATCH --error=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=9G
#SBATCH --time=20:00:00
#SBATCH --partition=agap_normal

output_dir="/home/barrientosm/scratch/angsd_analysis/urartu/samtool_GL/maf_no_soft_clipped_reads_TrEx"

# Input: List of BAM files containing the samples
#bam_list_speltoides="/home/barrientosm/scratch/GeCKO/CONFIG/WORKFLOWS_OUTPUTS/READ_MAPPING/speltoides_transcriptome_YANG_2023/bams_list.txt"
bam_list_speltoides="/home/barrientosm/projects/GE2POP/2024_TRANS_CWR/2024_MANUEL_BARRIENTOS/02_results/BAM_cleaned/speltoides/speltoides_TrEx/Bams_no_soft_clipped_reads/bam_list.txt"

#bam_list_urartu="/home/barrientosm/scratch/GeCKO/CONFIG/WORKFLOWS_OUTPUTS/READ_MAPPING/urartu_TrMo_mapping/bams_list_corrected.txt"
bam_list_urartu="/home/barrientosm/projects/GE2POP/2024_TRANS_CWR/2024_MANUEL_BARRIENTOS/02_results/BAM_cleaned/urartu_TrEx/Bams_no_soft_clipped_reads/bam_list.txt"

genome_path_urartu="/home/barrientosm/scratch/GeCKO/Refs/urartu/urartu_TrEx/New_T_urartu_Tr246_URA09.fasta"
genome_path_speltoides="/home/barrientosm/scratch/GeCKO/Refs/speltoides_TrEx/New_Ae_speltoides_Tr290_SPE10.fasta"

./angsd -bam $bam_list_urartu \
  -GL 1 \
  -minMapQ 30 \
  -minQ 20 \
  -only_proper_pairs 1 \
  -remove_bads 1 \
  -ref $genome_path_urartu \
  -doGlf 2 \
  -out $output_dir/urartu \
  -doMajorMinor 1 \
  -doMaf 1 \
  -minMaf 0.05 \
  -SNP_pval 1e-6 \
  -minInd 7 \
  -setMinDepthInd 10 \
  -P 5

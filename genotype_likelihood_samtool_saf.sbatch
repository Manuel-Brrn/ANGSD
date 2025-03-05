#!/bin/bash
#SBATCH --job-name=saf_urartu_TrEx_GL1_no_soft_clipped_reads
#SBATCH --output=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_out.txt
#SBATCH --error=/home/barrientosm/scratch/angsd/logs_jobs/log_%j_%x_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=9G
#SBATCH --time=20:00:00
#SBATCH --partition=agap_normal


output_dir="/home/barrientosm/scratch/angsd_analysis/urartu/samtool_GL/saf_no_soft_clipped_reads_TrEx"

# Input: List of BAM files containing the samples
#bam_list_speltoides="/home/barrientosm/scratch/GeCKO/CONFIG/WORKFLOWS_OUTPUTS/READ_MAPPING/speltoides_transcriptome_YANG_2023/bams_list.txt"
bam_list_speltoides="/home/barrientosm/projects/GE2POP/2024_TRANS_CWR/2024_MANUEL_BARRIENTOS/02_results/BAM_cleaned/speltoides/speltoides_TrEx/Bams_no_soft_clipped_reads/bam_list.txt"

#bam_list_urartu="/home/barrientosm/scratch/GeCKO/CONFIG/WORKFLOWS_OUTPUTS/READ_MAPPING/urartu_TrMo_mapping/bams_list_corrected.txt"
bam_list_urartu="/home/barrientosm/projects/GE2POP/2024_TRANS_CWR/2024_MANUEL_BARRIENTOS/02_results/BAM_cleaned/urartu_TrEx/Bams_no_soft_clipped_reads/bam_list.txt"

genome_path_urartu="/home/barrientosm/scratch/GeCKO/Refs/urartu/urartu_TrEx/New_T_urartu_Tr246_URA09.fasta"
genome_path_speltoides="/home/barrientosm/scratch/GeCKO/Refs/speltoides_TrEx/New_Ae_speltoides_Tr290_SPE10.fasta"

./angsd -bam $bam_list_urartu \
  -GL 1 \
  -doGlf 4 \
  -doSaf 1 \
  -anc $genome_path_urartu \
  -remove_bads 1 \
  -minMapQ 30 \
  -minQ 20 \
  -only_proper_pairs 1 \
  -minInd 7 \
  -setMinDepthInd 10 \
  -P 4 \
  -out $output_dir/urartu

Option Descriptions:
# -bam $bam_list_urartu	Path to the list of BAM files containing the mapped reads for the Urartu individuals. The list must be a text file with one BAM file per line.
# -GL 1	Specifies the genotype likelihood model to use. 1 = SAMtools model.
# -doGlf 4	Outputs genotype likelihoods in beagle format (binary). The value 4 is recommended for downstream analyses like population genetics.
# -doSaf 1	Computes the Site Allele Frequency likelihoods (SAF) needed for demographic inference or population genetic statistics.
# -anc $genome_path_urartu	Path to the ancestral genome FASTA file (reference genome).
# -remove_bads 1	Filters out reads with missing flags or abnormal flags (e.g., unmapped reads).
# -minMapQ 30	Minimum mapping quality required for a read to be considered. This filters out poorly mapped reads (30 is a common threshold).
# -minQ 20	Minimum base quality score to consider a base. Bases with lower quality are ignored (20 corresponds to a 1% error rate).
# -only_proper_pairs 1	Retains only properly paired reads (when both reads in a pair map to the same chromosome with the correct orientation).
# -minInd 7	Minimum number of individuals that must have coverage at a site to include it in the analysis.
# -setMinDepthInd 10	Minimum depth of coverage per individual required for a site to be considered (at least 10 reads per individual).
# -P 4	Number of threads to use for parallel processing (4 threads in this case).
# -out $output_dir/urartu	Prefix for the output files. All generated files will be saved with this prefix in the specified output directory.

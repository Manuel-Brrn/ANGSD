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


# File	Format	Purpose	Usage in Downstream Analysis
####### saf.idx	Binary	Index of SAF file	Automatic indexing for SFS inference
  #  Format: Binary index file.
 #   Content: Index information for the Site Allele Frequency likelihoods (SAF) file.
 #   Purpose: This file stores metadata such as the number of sites and population size, which is necessary to efficiently access the saf.gz file during downstream analyses (e.g., calculating the site frequency spectrum or performing neutrality tests).
 #   Usage: It is automatically read by ANGSD during subsequent analyses.

####### glf.gz	Binary	Genotype likelihoods	Population structure, admixture analysis
#Content: Genotype likelihoods for each individual at each position.
#Structure:
#    Each line represents a genomic position.
#    For each position, it contains the likelihoods of the three possible genotypes: AA, AB, and BB.
 #   Likelihoods are stored in log-scaled probabilities.

######## saf.gz	Binary	Site Allele Frequency likelihoods	SFS estimation, neutrality tests
#Structure:
# Each line corresponds to a site.
 #  The likelihood in saf.gz represents the probability of having k minor alleles out of n chromosomes at a given site.
 #   Used to estimate the Site Frequency Spectrum (SFS) or calculate diversity statistics.
#Usage: Required input for downstream analyses like neutrality tests or demographic inference using tools like realSFS.

##### saf.pos.gz	Binary	Genomic positions	Coordinate reference for saf.gz
# Format: Binary compressed file.
# Content: List of genomic positions corresponding to the sites in saf.gz.
# Structure:
 #   Each line contains a chromosome name and the position of the site.
#Usage: This file helps match the likelihoods in saf.gz to their genomic coordinates.

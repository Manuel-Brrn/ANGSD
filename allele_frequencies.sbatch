#!/bin/bash
#SBATCH --job-name=angsd_sfs
#SBATCH --output=./log_%j_%x_out.txt
#SBATCH --error=./log_%j_%x_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=9G
#SBATCH --time=20:00:00
#SBATCH --partition=agap_normal


# example command:
#./angsd -out outFileName -bam bam.filelist -GL 1 -doMaf 1 -doMajorMinor 1 -nThreads 10


#ANGSD Command for Calculating Allele Frequencies with Filters

#This script uses ANGSD (Analysis of Next Generation Sequencing Data) to calculate allele frequencies
#major and minor alleles, and polymorphic sites from a list of BAM files.
#The following command performs several analyses,
#including filtering based on mapping quality,
#base quality,
#Minor Allele Frequency (MAF),
#and SNP p-value
# and ensuring a minimum number of 5 individuals with data for each site

#Command:
./angsd -out /home/barrientosm/scratch/angsd_output/Yang_TrMo -bam /home/barrientosm/scratch/GeCKO/CONFIG/WORKFLOWS_OUTPUTS/READ_MAPPING/speltoides_transcriptome_YANG_2023/bams_list.txt -GL 1 -doMajorMinor 1 -doMaf 1 -minMapQ 30 -minQ 20 -minMaf 0.05 -SNP_pval 1e-6 -minInd 5 -nThreads 10

#Explanation of Command:

# -out /home/barrientosm/scratch/angsd_output/Yang_TrMo

#Purpose: Specifies the directory and prefix for the output files.
#Details: All output files will be saved in the specified directory with the prefix Yang_TrMo.
# For example, the MAF file will be named Yang_TrMo.mafs.gz.

#-b bam.filelist
#Purpose: Specifies the input file (bam.filelist) which contains a list of BAM file paths to be analyzed.
#Details: Each line in bam.filelist should contain the full path to a BAM file for each sample you want to include in the analysis.

# -GL 1
#Purpose: Specifies the genotype likelihood model to use.
#Details: -GL 1 means unphased genotypes are used.

#   -doMajorMinor 1
#Purpose: Tells ANGSD to calculate major and minor allele frequencies for each SNP.
#Details: This will give you the most frequent (major) and the least frequent (minor) allele at each site.

#    -doMaf 2
#Purpose: Calculate Minor Allele Frequency (MAF) for each site using all reads.
#Details: This option calculates the frequency of the minor allele across all samples.
#It is helpful for identifying common variants and filtering out rare variants.

########Filters Applied:

#    -minMapQ 30
#Purpose: Filter out reads with a mapping quality less than 30.
#Justification: Mapping quality indicates how confidently a read is aligned to the reference genome.
#Lower values suggest that the read may be incorrectly mapped or aligned ambiguously.
#By setting a threshold of 30, we only including high-confidence reads in your analysis.

#    -minQ 20
#Purpose: Filter out bases with base quality less than 20.
#Justification: Base quality reflects the confidence in a base call at a specific position.
#A score of 20 indicates a 99% chance that the base call is correct.
#Filtering out bases with lower quality helps ensure that only reliable base calls contribute to allele frequency estimates.

#    -minMaf 0.05
#Purpose: Filter out sites with Minor Allele Frequency (MAF) below 0.05.
#Justification: Variants with very low MAFs are rare and might not be biologically relevant or could be due to sequencing noise.
#A threshold of 5% (0.05) ensures that only variants that are more common in the population are included in the analysis,
#focusing on those with a higher chance of being biologically meaningful.

#    -SNP_pval 1e-6
#Purpose: Filter out SNPs with a p-value for the Likelihood Ratio Test (LRT) greater than 1e-6.
#Justification: The LRT is used to assess whether a site is likely to be polymorphic (variable).
#A p-value of 1e-6 ensures that only sites with strong evidence of polymorphism are retained,
#filtering out sites that are very likely invariant or have a high probability of being false positives.

#Expected Output Files:

#    angsdput.mafs.gz: Contains the Minor Allele Frequency (MAF) for each site, after applying the filters.
#    angsdput.majorMinor.gz: Contains the major and minor allele frequencies for each site.
#    angsdput.saf.gz: Contains the allele frequencies in sample format (per sample).
#    angsdput.glf.gz: Contains genotype likelihoods in a compressed format.
#    angsdput.geno.gz: Contains the genotypic data at each site.
#    angsdput.fstat.gz: Contains F-statistics that can be used for population structure analysis.



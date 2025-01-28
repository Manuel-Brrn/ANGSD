# Step 1: Calculate per-population SAF files (Site Allele Frequency) for each population

# For Population 1
../angsd -b list1 -anc hg19ancNoChr.fa -out pop1 -dosaf 1 -gl 1

# For Population 2
../angsd -b list2 -anc hg19ancNoChr.fa -out pop2 -dosaf 1 -gl 1

# Step 2: Calculate the 2D SFS prior using realSFS (between pop1 and pop2)
../misc/realSFS pop1.saf.idx pop2.saf.idx > pop1.pop2.ml

# Step 3: Prepare the Fst analysis for easy window analysis, etc.
../misc/realSFS fst index pop1.saf.idx pop2.saf.idx -sfs pop1.pop2.ml -fstout here

# Step 4: Get the global Fst estimate
../misc/realSFS fst stats here.fst.idx

# Example output:
# FST.Unweight: 0.069395 Fst.Weight: 0.042349

# Step 5: Perform sliding window analysis for Fst across windows (optional)
../misc/realSFS fst stats2 here.fst.idx -win 50000 -step 10000 > slidingwindow


########## Step 1: Calculate per-population SAF files for each of the three populations

# For Population 1
./angsd -b list10 -anc hg19ancNoChr.fa -out pop1 -dosaf 1 -gl 1

# For Population 2
./angsd -b list11 -anc hg19ancNoChr.fa -out pop2 -dosaf 1 -gl 1

# For Population 3
./angsd -b list12 -anc hg19ancNoChr.fa -out pop3 -dosaf 1 -gl 1

# Step 2: Calculate the 2D SFS for all pairwise combinations of populations (for each pair)
./misc/realSFS pop1.saf.idx pop2.saf.idx -P 24 > pop1.pop2.ml
./misc/realSFS pop1.saf.idx pop3.saf.idx -P 24 > pop1.pop3.ml
./misc/realSFS pop2.saf.idx pop3.saf.idx -P 24 > pop2.pop3.ml

# Step 3: Prepare the Fst analysis for all populations (pairwise Fst)
./misc/realSFS fst index pop1.saf.idx pop2.saf.idx pop3.saf.idx -sfs pop1.pop2.ml -sfs pop1.pop3.ml -sfs pop2.pop3.ml -fstout here

# Step 4: Get the global Fst estimate between the populations
./misc/realSFS fst stats here.fst.idx

# Example output:
# FST.Unweight[nObs:1666245]: 0.022063 Fst.Weight: 0.034513

# Step 5: Get the PBS values for each population
# The PBS will be calculated for each population automatically:
# -> pbs.pop1 0.023145
# -> pbs.pop2 0.005088
# -> pbs.pop3 0.009367

# Step 6: Perform sliding window analysis for Fst across windows (optional)
../misc/realSFS fst stats2 here.fst.idx -win 50000 -step 10000 > slidingwindow

Explanation:

    list1, list2, list10, list11, list12: Replace these with your BAM file lists. Each list should contain the file paths to BAM files for each individual in a population.
    hg19ancNoChr.fa: Replace this with your reference genome (make sure it's appropriate for your species).
    -dosaf 1: Tells ANGSD to compute Site Allele Frequencies (SAF).
    -gl 1: Specifies the use of genotype likelihoods.
    realSFS: Used for generating 2D SFS files and calculating Fst and PBS statistics.
    -P 24: Sets the number of threads (adjust depending on your system's available resources).
    -win 50000 -step 10000: Specifies the window size (50kb) and step size (10kb) for sliding window analysis of Fst across regions of the genome.

PBS Calculation:

    PBS statistics will be automatically calculated for each population when working with three populations.
    The program will calculate the PBS values for each population based on the pairwise Fst and the 3-population comparison.

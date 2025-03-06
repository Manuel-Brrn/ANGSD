# ANGSD

## output fo -doSaf

#### outputs
# SAF files are files that contain sample allele frequency. 
# These are generated with -doSaf in main ANGSD. 
# These contains either the loglikelihood ratio to the most likely category. 


Saf files now contains two raw files and an index file. 

PREFIX.saf.gz:
    PREFIX.saf.gz: Contains allele frequency likelihoods for each site as floating-point numbers, used to estimate site frequency spectra.
    This file contains raw data representing allele frequency likelihoods.
    It is compressed using bgzip (a common compression format in bioinformatics).

PREFIX.saf.pos.gz:
    PREFIX.saf.pos.gz: Stores the genomic positions corresponding to the likelihoods, allowing mapping between data and genome coordinates.
    This file contains genomic positions where the likelihoods are computed.
    It is also compressed with bgzip.

PREFIX.saf.idx:
    PREFIX.saf.idx: Contains metadata and index information, including the number of categories (allele frequency bins) and offsets to navigate the compressed data efficiently.
    This file is uncompressed and contains indexing information to help read the compressed files efficiently.
    It starts with a size_t value, which tells you how many categories (allele frequency bins) are present.
    After that, it contains blocks of data that describe where information is located inside the compressed files.

Table 1: Content of entry for a single reference name in the PREFIX.saf.idx file.

Col Field Type Brief description
1 CLEN size t Length of CHR (not including terminating null)
2 CHR char* Reference sequence name. Length is CLEN
3 NSITES size t Number of sites with coverage from reference CHR
4 OFF1 long int CHR oset into the PREFIX.saf.pos.gz
5 OFF2 long int CHR oset into the PREFIX.saf.gz

Since the .saf.gz and .saf.pos.gz files are compressed, their size alone does not tell you how many genomic sites are stored.
Instead, you would need to read the index file (.saf.idx) to know how many sites are present.

    Float (Floating-point number):
        A float represents decimal numbers (numbers with fractions like 3.14 or 0.001).
        It allows storing non-integer values with varying degrees of precision.
        In most programming languages (like C, Python, or Java), a standard float uses 4 bytes (32 bits) of memory.

    Byte:
        A byte is the basic unit of digital data storage, typically made of 8 bits.
        It represents small numbers (0 to 255) or characters in text files.
        Larger data types (like floats or integers) are stored across multiple bytes (e.g., 4 bytes for floats, 4 bytes for integers).

For example:

    The number 3.14 stored as a float would take 4 bytes.
    The integer 100 stored as an int would also take 4 bytes.

## output thetas

Theta Files:
    PREFIX.thetas.idx: Stores chromosome name, number of sites, number of chromosomes, and offsets to access theta estimates in the main file.
    
    Table 6: Content of entry for a single reference name in the
Col Field Type Brief description
1 CLEN size t Length of CHR (inferred by strlen)
2 CHR char* Reference sequence name. Length is CLEN
3 NSITES size t Number of sites with coverage from reference CHR
4 NCHR size t number of possible derived/minor allels. (2*nInd for the unfolded, nInd for the folded)
5 OFF long int CHR oset into the thetas.gz

    PREFIX.thetas.gz: Contains per-site theta estimates (population genetic diversity statistics) along with chromosome name, number of sites, and number of chromosomes.
    
    Table 7: Content of the PREFIX.thetas.gz le. Note that there exists a 8byte magicnumber in the beginning of the file.
Col Field      Type   Brief description
1   CLEN      size t Length of CHR (inferred by strlen)
2   CHR       char* Reference sequence name. Length is CLEN
3   NSITES    size t Number of sites with coverage from reference CHR
4   NCHR      size t number of possible derived/minor allels. (2*nInd for the unfolded, nInd for the folded)
5   POSI      int[NSITES] zero indexed positions for CHR
5   Watterson float[NSITES] logscaled persite estimates of Watterson theta estimator (number of segregating sites)
5   pi        float[NSITES] logscaled persite estimates of the Tajima theta estimator (pairwise dierences)
5 FuLi        float[NSITES] logscaled persite estimates of the fuli theta estmator (singleton category)
5 FayH        float[NSITES] logscaled persite estimates of the FayH theta estimator
L L           float[NSITES] logscaled persite estimates of the L theta estimator


    

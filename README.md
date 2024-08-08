The deeptools Docker container is based on Ubuntu 20.04 and includes deeptools. It provides three key scripts to facilitate its usage in HPC clusters:

**BAM Coverage**: bamCoverage.sh runs the deeptools bamCoverage command

*Usage*: docker run --rm -v $(pwd):/workspace deeptools:v1 /scripts/bamCoverage.sh

**Bigwig Compare**: bwCompare.sh runs the deeptools bwCompare command

*Usage*: docker run --rm -v $(pwd):/workspace deeptools:v1/scripts/bwCompare.sh <sample_ID>

**Normalization based on edger normfactors**: edgerbw.sh normalize samples based on the normalization factors calculated during DE analysis with edgeR.

*Usage*: docker run --rm -v $(pwd):/workspace deeptools:v1 /scripts/edgerbw.sh <mutant_ID> <wt_ID>

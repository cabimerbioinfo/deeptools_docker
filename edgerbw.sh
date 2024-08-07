#!/bin/bash

# Check that the correct arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <mutant> <wt>"
  exit 1
fi

# Assign argument values
mutant="$1"
wt="$2"

# Build the comparison name
comp="${mutant}_vs_${wt}"

# List of BAM files
bamFiles=($(ls *${wt}*.bam *${mutant}*.bam))

# Iterate over BAM files
for bamFile in "${bamFiles[@]}"; do
  # Get the filename without extension
  bam_name=$(basename "$bamFile" .bam)
  # Get the corresponding normalization factor
  nf=$(awk -v bn="$bam_name" '$1 ~ bn {print $2}' "${comp}_normfactors_bamcov.txt")
  # Build the BW file name
  bw_file="${bam_name}_normfactors.bw"
  # Run bamCoverage to generate the BW file
  cmd="bamCoverage -b $bamFile -bs 1 -p max -o $bw_file --scaleFactor $nf"
  echo "Executing: $cmd"
  $cmd
done

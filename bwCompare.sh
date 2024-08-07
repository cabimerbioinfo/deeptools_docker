#!/bin/bash

# Function to show script usage
function usage() {
    echo "Usage: $0 <sample> <bin size> <operation>"
    echo "Example: $0 sample 10 mean"
    exit 1
}

# Check if the 'sample', 'bin size', and 'operation' arguments are provided
if [ $# -ne 3 ]; then
  usage
fi

# Assign the arguments to variables
sample="$1"
BIN_SIZE="$2"
OPERATION="$3"

# Find .bw files corresponding to the value of 'sample' and store them in an array
mapfile -t sample_bw < <(find . -maxdepth 1 -type f -name "${sample}*.bw" 2>/dev/null)

# Check if .bw files are found
if [ ${#sample_bw[@]} -lt 2 ]; then
  echo "Not enough .bw files found for '${sample}'"
  exit 1
fi

# Perform the bigwig comparison
output_file="${sample}_${OPERATION}_bs${BIN_SIZE}.bw"
cmd="bigwigCompare -b1 ${sample_bw[0]} -b2 ${sample_bw[1]} -bs ${BIN_SIZE} -p max --operation ${OPERATION} -o ${output_file}"
echo "Executing: ${cmd}"
eval "${cmd}"

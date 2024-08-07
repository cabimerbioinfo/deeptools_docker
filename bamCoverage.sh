#!/bin/bash

# Function to show script usage
function usage() {
    echo "Usage: $0 <bam file> <bin size> <normalization method>"
    echo "Example: $0 file.bam 10 CPM"
    exit 1
}

# Check that the expected arguments are provided
if [ "$#" -ne 3 ]; then
    usage
fi

# Assign arguments to variables
BAM_FILE="$1"
BIN_SIZE="$2"
NORMALIZATION_METHOD="$3"

# Check that the BAM file exists
if [ ! -f "$BAM_FILE" ]; then
    echo "The file $BAM_FILE does not exist."
    exit 1
fi

# Get the filename without the extension
filename=$(basename -- "$BAM_FILE")
filename_no_ext="${filename%.*}"

# Run bamCoverage from Deeptools to generate the bigwig file
bamCoverage \
    --bam "$BAM_FILE" \
    -o "${filename_no_ext}_bs${BIN_SIZE}_${NORMALIZATION_METHOD}.bw" \
    --binSize "$BIN_SIZE" -p max \
    --normalizeUsing "$NORMALIZATION_METHOD"

# Check if the execution was successful
if [ $? -eq 0 ]; then
    echo "BigWig file created: ${filename_no_ext}_bs${BIN_SIZE}_${NORMALIZATION_METHOD}.bw"
else
    echo "Error creating the BigWig file."
fi

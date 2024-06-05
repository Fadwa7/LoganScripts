#!/bin/bash

echo "~~~ Downloading unitigs from Logan bucket in S3 ~~~"
# Verification of argument number
if [ $# -lt 2 ]; then
    echo "Usage: $0 <ACCESSIONS_LIST> <DESTINATION_DIRECTORY>"
    exit 1
fi

# Arguments
ACCESSIONS_LIST=$1 # Text file containing ID accession for your data (make sure that your data have been published before December 2023)
DESTINATION_DIRECTORY=$2 # Path to your output directory

# Checking the existence of paths 
if [ ! -f "$ACCESSIONS_LIST" ]; then
    echo "The file $ACCESSIONS_LIST is not found"
    exit 1
fi

if [ ! -d "$DESTINATION_DIRECTORY" ]; then
    echo "Please identify the output directory"
    exit 1
fi 

# Function to check if file exists in S3
check_file_exists_in_s3() {
    local file=$1
    if aws s3 ls "s3://logan-pub/u/${file}/${file}.unitigs.fa.zst" --no-sign-request > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Reading the ACCESSIONS_LIST and downloading files if they exist
while IFS= read -r accession; do
    if check_file_exists_in_s3 "$accession"; then
        echo ""
        echo "Downloading ${accession}.unitigs.fa.zst..."
        aws s3 cp "s3://logan-pub/u/${accession}/${accession}.unitigs.fa.zst" "$DESTINATION_DIRECTORY" --no-sign-request
        echo ""
    else
        echo ""
        echo "WARNING: The ID ${accession} does not exist in the S3 bucket."
        echo ""
    fi
done < "$ACCESSIONS_LIST"

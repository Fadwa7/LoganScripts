#!/bin/bash

echo "~~~ Downloading sequences from Logan bucket in S3 ~~~"
# Verification of argument number
if [ $# -lt 3 ]; then
    echo "Usage: $0 <ACCESSIONS_LIST> <DESTINATION_DIRECTORY> <DATA_TYPE>"
    exit 1
fi

# Arguments
ACCESSIONS_LIST=$1 # Text file containing ID accession for your data (make sure that your data have been published before December 2023)
DESTINATION_DIRECTORY=$2 # Path to your output directory
DATA_TYPE=$3

# Checking the existence of paths 
if [ ! -f "$ACCESSIONS_LIST" ]; then
    echo "The file $ACCESSIONS_LIST is not found"
    exit 1
fi

if [ ! -d "$DESTINATION_DIRECTORY" ]; then
    echo "Please identify the output directory"
    exit 1
fi 

# Checking the value of DATA_TYPE
if [ "$DATA_TYPE" != "unitigs" ] && [ "$DATA_TYPE" != "contigs" ]; then
    echo "DATA_TYPE must be either 'unitigs' or 'contigs'"
    exit 1
fi

# Function to check if file exists in S3
check_file_exists_in_s3() {
    local file=$1
    local s3_prefix=$2
    if aws s3 ls "s3://logan-pub/$s3_prefix/${file}/${file}.$DATA_TYPE.fa.zst" --no-sign-request > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Determine S3 prefix based on DATA_TYPE
if [ "$DATA_TYPE" == "unitigs" ]; then
    S3_PREFIX="u"
else
    S3_PREFIX="c"
fi

# Reading the ACCESSIONS_LIST and downloading files if they exist
while IFS= read -r accession; do
    if check_file_exists_in_s3 "$accession" "$S3_PREFIX"; then
        echo ""
        echo "Downloading ${accession}.$DATA_TYPE.fa.zst..."
        aws s3 cp "s3://logan-pub/$S3_PREFIX/${accession}/${accession}.$DATA_TYPE.fa.zst" "$DESTINATION_DIRECTORY" --no-sign-request
        echo ""
    else
        echo ""
        echo "WARNING: The ID ${accession} does not exist in the S3 bucket."
        echo ""
    fi
done < "$ACCESSIONS_LIST"

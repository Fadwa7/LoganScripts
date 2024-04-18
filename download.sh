#!/bin/bash

# Verification of argument number
if [ $# -lt 2 ]; then
    echo "Usage: $0 <ACCESSIONS_LIST> <DESTINATION_DIRECTORY>"
    exit 1
fi

# Arguments
ACCESSIONS_LIST=$1 # Text file containing ID accession for your data (make sure that your data have been published before december 2023)
DESTINATION_DIRECTORY=$2 #Path to your output director or . for the current directory. 

# Checking the existence of paths 
if [ ! -f "$ACCESSIONS_LIST" ]; then
    echo "The file $ACCESSIONS_LIST is not found"
    exit 1
fi


if [ ! -d "$DESTINATION_DIRECTORY" ]; then
    echo "Please identify the output directory"
fi 



# Downloading files from S3
cat "$ACCESSIONS_LIST" | xargs -I{} aws s3 cp s3://logan-pub/u/{}/{}.unitigs.fa.zst "$DESTINATION_DIRECTORY" --no-sign-request 

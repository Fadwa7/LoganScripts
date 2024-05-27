#!/bin/bash 

#Verfication of argument number 
if [ $# -lt 3 ]; then 
    echo "Usage: $0 <ACCESSIONS_LIST> <GENE_SEQUENCE> <DESTINATION_DIRECTORY>"
    exit 1
fi 

# Arguments
ACCESSIONS_LIST=$1 # Text file containing ID accesion for your data (data should have been published before december 2023)
GENE_SEQUENCE=$2 # fasta sequence of gene of interest
DESTINATION_DIRECTORY=$3 # Output Directory 


# Checking 
if [ ! -f "$ACCESSIONS_LIST" ]; then
    echo "The file $ACCESSIONS_LIST is not found"
    exit 1
fi 

if [ ! -f "$GENE_SEQUENCE" ]; then 
    echo "The file $GENE_SEQUENCE is not found"
    exit 1
fi 

if [ ! -d "$DESTINATION_DIRECTORY" ]; then
    echo "Please identify the output directory"
    exit 1
fi 

# Loop over the ID 
while IFS= read -r ID; do
    if  [ -f "$DESTINATION_DIRECTORY/$ID.minimap2_output" ]; then
       echo " The $ID is already processed. Skipping "
    else
       if aws s3 ls "s3://logan-pub/c/$ID/" --no-sign-request > /dev/null 2>&1; then
          echo "Procssing sample : $ID"
          echo ""
          /opt/minimap2/bin/minimap2-2.17-r941 -t 8 -a "$GENE_SEQUENCE" <(aws s3 cp s3://logan-pub/c/"$ID"/"$ID".contigs.fa.zst --no-sign-request - | zstdcat) | samtools view -hF4 - > "$DESTINATION_DIRECTORY"/"$ID".minimap2_output 
       else
          echo "ERROR: sample $ID is not found in logan bucket"
       fi 
    fi 
done < "$ACCESSIONS_LIST"

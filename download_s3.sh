#!/bin/bash 

#Arguments number verification 

if [ $# -lt 4 ]; then 
	echo "Usage: $0 <AWS_ACCESS_KEY_ID> <AWS_SECRET_ACCESS_KEY> <ACCESSION_LIST> <DESTINATION_DIRECTORY_NAME>"
	exit 1
fi


# AWS KEY and AWS SECRET ACCESS KEY

AWS_ACCESS_KEY_ID=$1
AWD_SECRET_ACCESS_KEY=$2
ACCESSIONS_LIST=$3
DESTINATION_DIRECTORY=$4

#AWS configuration

/shared/home/felkhaddar/aws-cli/bin/aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
/shared/home/felkhaddar/aws-cli/bin/aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY


if [ ! -f "$ACCESSIONS_LIST" ]; then
	echo "The file is $ACCESSIONS_LIST is not found"
	exit 1
fi


if [ ! -d "$DESTINATION_DIRECTORY" ]; then
	mkdir -p "$DESTINATION_DIRECTORY"
fi 


cat "$ACCESSIONS_LIST" | xargs -I{} /shared/home/felkhaddar/aws-cli/bin/aws s3 cp s3://logan-pub/u/{}/{}.unitigs.fa.zst "$DESTINATION_DIRECTORY/"


echo "Decompressing .zst files..."
cd "$DESTINATION_DIRECTORY"
for file in *.zst; do
    zstd -d "$file"
done

# Remove .zst files
echo "Removing .zst files..."
rm -f *.zst

echo "Process completed successfully."

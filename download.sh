#!/bin/bash

# Vérification du nombre d'arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <ACCESSIONS_LIST> <DESTINATION_DIRECTORY_NAME>"
    exit 1
fi

# Récupération des arguments
ACCESSIONS_LIST=$1
DESTINATION_DIRECTORY=$2

# Vérification de l'existence du fichier d'accessions
if [ ! -f "$ACCESSIONS_LIST" ]; then
    echo "The file $ACCESSIONS_LIST is not found"
    exit 1
fi


# Création du répertoire de destination s'il n'existe pas
if [ ! -d "$DESTINATION_DIRECTORY" ]; then
    mkdir -p "$DESTINATION_DIRECTORY"
fi 



# Téléchargement des fichiers depuis S3
cat "$ACCESSIONS_LIST" | xargs -I{} aws s3 cp s3://logan-pub/u/{}/{}.unitigs.fa.zst "$DESTINATION_DIRECTORY/" --no-sign-request 



# Décompression des fichiers .zst et recherche des k-mers
echo "Decompressing .zst files..."
cd "$DESTINATION_DIRECTORY"
for file in *.zst; do
    # Extraction du nom de fichier sans extension
    UNITIG_ID=$(basename "$file" .unitigs.fa.zst)
    ID=${UNITIG_ID%%.*}
    zstd -d "$file"
    echo "All files are decompressed"
done

fasta="FASTA"
mkdir -p "$fasta"
mv *.fa  $fasta

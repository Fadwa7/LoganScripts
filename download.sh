#!/bin/bash

# Vérification du nombre d'arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <ACCESSIONS_LIST> <DESTINATION_DIRECTORY>"
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
    echo "Please identify the output directory"
fi 



# Téléchargement des fichiers depuis S3
cat "$ACCESSIONS_LIST" | xargs -I{} aws s3 cp s3://logan-pub/u/{}/{}.unitigs.fa.zst "$DESTINATION_DIRECTORY" --no-sign-request

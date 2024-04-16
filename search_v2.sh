#!/bin/bash

# Nombre d'arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <FASTA_FOLDER> <KMER_FILE>"
    exit 1
fi

# Arguments
FASTA_FOLDER=$1
KMER_FILE=$2

# Vérification de l'existence du fichier de k-mers
if [ ! -f "$KMER_FILE" ]; then
    echo "The file $KMER_FILE is not found"
    exit 1
fi

# Vérification de l'existence du répertoire FASTA
if [ ! -d "$FASTA_FOLDER" ]; then
    echo "The directory $FASTA_FOLDER does not exist"
    exit 1
fi 

# Liste de k-mers 
KMER_LIST=$(sed 's/^/ -q /' "$KMER_FILE" | tr -d '\r\n')
KMER=$(cat "$KMER_FILE")
echo -e "List of query : \n$KMER"

# Déplacement vers le répertoire FASTA
echo "Searching for queries..."
cd "$FASTA_FOLDER" || exit

# Boucle sur les fichiers FASTA dans le répertoire
for file in *.fa; do
    UNITIG_ID=$(basename "$file" .unitigs.fa)
    ID=${UNITIG_ID%%.*}
    echo ""
    echo "~~~~~~ Query result for $ID ~~~~~~~"
    echo ""
    echo ""
    result=$(rcgrep "$ID.unitigs.fa" $KMER_LIST --grepargs "-B 1 --no-group-separator")
    if [ -z "$result" ]; then
       echo "No occurences found." 
    else
       echo "$result"
    fi
done

echo ""
echo "Process completed successfully."

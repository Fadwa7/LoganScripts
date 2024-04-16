#!/bin/bash

# Vérification du nombre d'arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <DATA_FOLDER> <QUERY_FILE>"
    exit 1
fi

# Assignation des arguments
if [ "$1" = "." ]; then
    DATA_FOLDER=$(pwd)
else
    DATA_FOLDER="$1"
fi
QUERY_FILE="$2"

# Vérification de l'existence du fichier de k-mers
if [ ! -f "$QUERY_FILE" ]; then
    echo "The file $QUERY_FILE is not found"
    exit 1
fi

# Liste des k-mers 
QUERY_LIST=$(sed 's/^/ -q /' "$QUERY_FILE" | tr -d '\r\n')
QUERY=$(cat "$QUERY_FILE")
echo -e "List of queries:\n$QUERY"

# Déplacement vers le répertoire DATA
echo "Searching for queries..."
cd "$DATA_FOLDER" || exit

# Boucle sur les fichiers DATA dans le répertoire
for file in *; do
    if [[ $file == *.unitigs.fa ]]; then
        UNITIG_ID=$(basename "$file" .unitigs.fa)
    elif [[ $file == *.unitigs.fa.zst ]]; then
        UNITIG_ID=$(basename "$file" .unitigs.fa.zst)
    else
        continue
    fi
    
    ID=${UNITIG_ID%%.*}
    echo ""
    echo "~~~~~~ Query result for $ID ~~~~~~~"
    echo ""
    echo ""
    if [[ $file == *.zst ]]; then
        zstdcat "$file" | rcgrep $QUERY_LIST --grepargs "-B 1 --no-group-separator" -
    elif [[ $file == *.fa ]]; then
        rcgrep "$file" $QUERY_LIST --grepargs "-B 1 --no-group-separator"
    fi
done

echo ""
echo "Process completed successfully."

#!/bin/bash

# Vérification du nombre d'arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <LIST_PATH_FILES> <QUERY_FILE>"
    exit 1
fi

# Assignation des arguments
LIST_PATH_FILES="$1"
QUERY_FILE="$2"

# Vérification de l'existence du fichier de k-mers
if [ ! -f "$QUERY_FILE" ]; then
    echo "The file $QUERY_FILE is not found"
    exit 1
fi

if [ ! -f "$LIST_PATH_FILES" ]; then
    echo "The file $LIST_PATH_FILES is not found"
    exit 1
fi

# Liste des k-mers 
QUERY_LIST=$(sed 's/^/ -q /' "$QUERY_FILE" | tr -d '\r\n')
QUERY=$(cat "$QUERY_FILE")
echo -e "List of queries:\n$QUERY"

echo "Searching for queries..."

# Boucle sur les fichiers DATA dans le répertoire
while IFS= read -r file; do
    if [ ! -f "$file" ]; then
        echo "File $file not found, skipping..."
        continue
    fi

    echo ""
    echo "~~~~~~ Query result for $file ~~~~~~~"
    echo ""

    if [[ $file == *.zst ]]; then
        zstdcat "$file" | rcgrep $QUERY_LIST --grepargs "-B 1 --no-group-separator" -
    elif [[ $file == *.fa ]]; then
        rcgrep "$file" $QUERY_LIST --grepargs "-B 1 --no-group-separator"
    else
        echo "Unsupported file format: $file"
    fi
done < "$LIST_PATH_FILES"

echo ""
echo "Process completed successfully."

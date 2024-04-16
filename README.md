# Custom scripts to interact with the Logan database.

## Requirements: 
Prior to using this script, ensure you have installed the following:
- Aws CLI
- rcgrep

### To install aws CLI, please follow the instractions via :
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

### To install rcgrep please execute the command line 
`pip install rcgrep`
  
### Tutorial :
Execute the command line : 
- ` git clone https://github.com/Fadwa7/Scripts_Logan.git `
- ` cd Scripts_Logan ` 

To test the script, you'll need two files: id_accessions.txt and query_test.txt.
- id_accessions.txt: contains SRR Identifiers for your samples, with each ID on a separate line.
- query_test.txt: contains queries to search each query on a separate line.
  
### Downloading files using id_accessions.txt:

Execute the following command:

` ./download.sh $PATH/TO/ID_ACCESSIONS_FILE $NAME_OF_OUTPUT_DIRECTORY `

- $ACCESSIONS_LIST : id_accessions.txt
- $NAME_OF_OUTPUT_DIRECTORY : The desired name of the output directory, e.g., Test.
  
this script create this tree :
```
|-- COMPRESSED
|   -- SRR10030979.unitigs.fa.zst
|-- FASTA
    -- SRR10030979.unitigs.fa
```

### Search for queries:

Use the script: search_v2.sh.
Execute the following command:

` ./search.sh  $PATH/TO/FASTA/FOLDER $PATH/TO/QUERY_LIST_FILE `

In the example: 
- FASTA_FOLDER : "Test/FASTA"
- QUERY_LIST_FILE: query_test.txt

In the terminal you should have this output

```
List of query : 
AAAAAAAAAAAAAAAAAAAAAAGACAGAGACTCTTAAAAACAATAGCACTATTATCACCCCTTAAAAATTGTTTAGTTTCTTAATATCATTAATATAGAGTGTTAAAACGTTCCCAATGATTTTAG 
AAAAAAAAAAAAAAAAAAAAAAACCAGGCCTGACTG
AAAAAAAAAAAAAAAAAAAAAAACCAGCAGGG
Searching for queries...

~~~~~~ Query result for SRR10030979 ~~~~~~~


>SRR10030979_1 ka:f:5.2   L:-:6208439:- L:-:6316834:-  L:+:26:+ 
AAAAAAAAAAAAAAAAAAAAAAACCAGCAGGG
>SRR10030979_2 ka:f:2.8    L:-:6316837:- 
AAAAAAAAAAAAAAAAAAAAAAACCAGGCCTGACTG
>SRR10030979_3 ka:f:3.3    L:-:6320217:- 
AAAAAAAAAAAAAAAAAAAAAAGACAGAGACTCTTAAAAACAATAGCACTATTATCACCCCTTAAAAATTGTTTAGTTTCTTAATATCATTAATATAGAGTGTTAAAACGTTCCCAATGATTTTAG

Process completed successfully.

```





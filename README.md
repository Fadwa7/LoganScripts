# Custom scripts to interact with the Logan database.

## Requirements: 
Prior to using this script, ensure you have installed the following:
- Aws CLI
- rcgrep
- zstd

### To install aws CLI, please follow the instractions via :
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

### To install rcgrep please execute the command line 
`pip install rcgrep`

Execute the command line : 
- ` git clone https://github.com/Fadwa7/Scripts_Logan.git `
- ` cd Scripts_Logan `
- 
### Tutorial :
In this example we download unitigs for 5 pancreatic cancer samples and search them for KRAS oncogenic variants using 33-nt sequence queries.

### Downloading files using id_accessions.txt:

To execute **download.sh** script, you'll need two files: id_accessions.txt and a directory
- id_accessions.txt: contains SRR Identifiers for your samples, with each ID on a separate line.
- directory : The absolute path to the output directory, e.g : . (current directory)
  
Execute the following command:

` ./download.sh $PATH/TO/ID_ACCESSIONS_FILE . `
  
Output :
```
ERR1880167.unitigs.fa.zst
ERR1880168.unitigs.fa.zst
ERR1880169.unitigs.fa.zst
ERR1880170.unitigs.fa.zst
ERR1880172.unitigs.fa.zst
```

### Search for queries:

To execute **search.sh** script, you'll need two files: paths.txt and query.fa
- paths.txt: contains abolute path to your samples (.zst or .fa)
- query.fa:  contains queries to search each query on a separate line. (make sure you use the .fasta or .fa extension)
  *N.B: you can use a simple file instead of the fasta format, with each query on its own line.*

Execute the following command:

` ./search.sh  . $PATH/TO/QUERY_LIST_FILE `

In the terminal you should have this output

```
List of queries:
ACTCTTGCCTACGCCATCAGCTCCAACTACCAC
ACTCTTGCCTACGCCAACAGCTCCAACTACCAC
CTCTTGCCTACGCCACAAGCTCCAACTACCACA
CTCTTGCCTACGCCACGAGCTCCAACTACCACA
GGCACTCTTGCCTACGTCACCAGCTCCAACTAC
ACTCTTGCCTACGCCAGCAGCTCCAACTACCAC
Searching for queries...

~~~~~~ Query result for ERR1880167.unitigs.fa.zst ~~~~~~~

>ERR1880167_199416 ka:f:41.6   L:-:1359598:+ L:-:1660377:+  L:+:4332788:+ 
AGGCCTGCTGAAAATGACTGAATATAAACTTGTGGTAGTTGGAGCTGTTGGCGTAGGCAAGAGTGCCTTGACGATACAGCTAATTCAGAATCATTTTGTGGACGAATATGATCCAACAATAGAGGATTCCTACAGGAAGCAAGTAGTAAT

~~~~~~ Query result for ERR1880168.unitigs.fa.zst ~~~~~~~

>ERR1880168_1809982 ka:f:34.8   L:+:2372536:+  L:-:1037400:+ L:-:1042496:+ 
AGGCCTGCTGAAAATGACTGAATATAAACTTGTGGTAGTTGGAGCTGTTGGCGTAGGCAAGAGTGCCTTGACGATACAGCTAATTCAGAATCATTTTGTGGACGAATATGATCCAACAATAGAGGATTCCTACAGGAAGCAAGTAGTAATTGATGGAGAAACCTGTCTC

~~~~~~ Query result for ERR1880169.unitigs.fa.zst ~~~~~~~

>ERR1880169_1443447 ka:f:31.3   L:-:2508470:-  L:+:1352292:- 
CTGAATATAAACTTGTGGTAGTTGGAGCTGATGGCGTAGGCAAGAGTGCCTTGACGATACA

~~~~~~ Query result for ERR1880170.unitigs.fa.zst ~~~~~~~

>ERR1880170_2665195 ka:f:29.5   L:-:2236668:-  L:+:251215:- 
CTGAATATAAACTTGTGGTAGTTGGAGCTGATGGCGTAGGCAAGAGTGCCTTGACGATACA

~~~~~~ Query result for ERR1880172.unitigs.fa.zst ~~~~~~~

>ERR1880172_9459260 ka:f:168.9   L:-:3582700:+  L:+:6737383:+ 
CTGAATATAAACTTGTGGTAGTTGGAGCTGATGGCGTAGGCAAGAGTGC

Process completed successfully.

```





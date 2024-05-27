# Custom scripts to interact with the Logan dataset.

Logan is a dataset comprising DNA and RNA sequences derived from a December 2023 snapshot of the entire NCBI Sequence Read Archive through genome assembly. It offers two sets of related sequences: unitigs and contigs. Unitigs retain nearly all original sample information, while contigs minimize variation to increase sequence lengths. Both datasets are available on a public S3 bucket provided by the Registry of Open Data at AWS, in compressed form. Downloading either unitigs or contigs enables users to access the extensive information within the SRA 10x (40x for contigs) more efficiently in terms of time and disk space compared to raw reads, albeit with minor sensitivity loss and enhanced contiguity.

For more informations : https://github.com/IndexThePlanet/Logan 

## Requirements: 
Prior to using this script, ensure you have installed the following:
- aws CLI
- rcgrep (v0.1.0)
- zstd (v1.5.5)
  * For mapping :
- minimap2
- samtools

### To install aws CLI, please follow the instractions via :
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

### To install rcgrep please execute the command line 
`pip install rcgrep`

### To install zstd please execute the command line 
We recommand installing zstd via conda.<br>
` conda install anaconda::zstd `
### To install minimap2, please follow the instruction: 
https://github.com/lh3/minimap2?tab=readme-ov-file#install

### Cloning
Execute the command line : 
- ` git clone https://github.com/Fadwa7/Scripts_Logan.git ` && ` cd Scripts_Logan `
  
## Tutorial :
In this example we download unitigs for 5 pancreatic cancer samples and search them for KRAS oncogenic variants using 33-nt sequence queries.

### Downloading files using id_accessions.txt:

To execute **download.sh** script, you'll need two files: id_accessions.txt and a directory
- **id_accessions.txt**: contains SRR Identifiers for your samples, with each ID on a separate line.
- **directory** : The absolute path to the output directory, e.g : . (current directory)
  
Execute the following command:

` ./download.sh id_accessions.txt . `
  
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
- **paths.txt**: contains absolute path to your samples (.zst or .fa)
- **query.fa**:  contains queries in fasta format. (make sure you use .fasta or .fa extension). <br>
  *N.B: you can use a simple file instead of the fasta format, with each query on its own line.*

Execute the following command:

` ./search.sh  paths.txt query.fa `

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
### Mapping 


If you have any suggestions, please feel free to reach out to us at fadwa.el-khaddar@i2bc.paris-saclay.fr.




# GeneOntologySupplement
Supplemental data and code used for the article "Towards the Gene Ontology of eukaryotic cilia and flagella" Roncaglia, et al. [DRAFT]

For full disclosure and information see:

[Full reference pending]

The provided files and scripts should allow you to rerun the analyses as described in the article. Below are links to source files used in this analysis that can not be part of the repository due to licencing and ownership.

# Ontologizer
The workflow uses the Ontologizer version 2.1, which can be obtained here: http://ontologizer.de/. Download the command line java jar file: Ontologizer.jar

# Gene ontology files
The relevant .OBO formatted files that were used can be obtained via:

2012-12-01:

2016-10-18:

# Gene annotation files
The relevant time matched Gene Annotation files where obtained from:

2012-12-01:ftp://ftp.ebi.ac.uk/pub/databases/GO/goa/old/HUMAN/gene_association.goa_human.116.gz

2016-10-18:

# How to rerun the analyses
In linux:

1. Clone this repository by executing 'git clone https://github.com/JohnvanDam/GeneOntologySupplement.git'
2. Download the Ontologizer jar file into the same directory as the repository
3. Download the gene annotation and gene ontology files into the same directory
5. 'cd' to your local cloned directory
4. Unzip the downloaded gene annotation and gene ontology files
5. execute 'make'




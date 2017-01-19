# GeneOntologySupplement
Supplemental data and code used for the article "Towards the Gene Ontology of eukaryotic cilia and flagella" Roncaglia, et al. [DRAFT]

For full disclosure and information see:

[Full reference pending]

The provided files and scripts should allow you to rerun the analyses as described in the article. Below are links to source files used in this analysis that can not be part of the repository due to licencing and ownership. However running the makefile, by simply executing 'make' will download all required files automatically.

# Ontologizer
The workflow uses the Ontologizer version 2.1, which can be obtained here: http://ontologizer.de/.

# Gene ontology files
The relevant .OBO formatted files that were used can be obtained via:

2012-12-01: ftp://ftp.geneontology.org/go/ontology-archive/gene_ontology_edit.obo.2012-12-01.gz

2017-01-01: ftp://ftp.geneontology.org/go/ontology-archive/gene_ontology_edit.obo.2017-01-01.gz

# Gene annotation files
The relevant time matched Gene Annotation files where obtained from:

2012-12-01: ftp://ftp.ebi.ac.uk/pub/databases/GO/goa/old/HUMAN/gene_association.goa_human.116.gz

2017-01-16: ftp://ftp.ebi.ac.uk/pub/databases/GO/goa/old/HUMAN/goa_human.gaf.164.gz

# How to rerun the analyses
In linux:

1. Clone this repository by executing 'git clone https://github.com/JohnvanDam/GeneOntologySupplement.git'
2. cd to the cloned repo directory.
3. Execute 'make'.

All relevant files not present will be downloaded, and all analyses will be run automatically.

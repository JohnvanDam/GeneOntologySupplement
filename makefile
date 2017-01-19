# This is a makefile to describe (and execute) a number of GO term enrichment
# analysis. The purpose of this makefile is to allow instant execution of a
# reanalysis of the go term enrichment analyses described in our article:
# [reference pending]
# Author: John van Dam
# Email: t.j.p.vandam at uu dot nl

# Variables


# Ontologizer command
# Multiple testing method
MTC=Bonferroni
# GO annotation perculation in GO tree
METHOD=Parent-Child-Union
# Base Ontologizer command
PROG=java -jar Ontologizer.jar -c $(METHOD) -mtc $(MTC)

all: compare_all

# Main dependencies
Ontologizer.jar:
	echo Downloading the Ontologizer software
	curl --progress-bar http://ontologizer.de/cmdline/Ontologizer.jar -o Ontologizer.jar

gene_association.goa_human.116:
	echo Downloading the 2012 GO annotations
	curl --progress-bar ftp://ftp.ebi.ac.uk/pub/databases/GO/goa/old/HUMAN/gene_association.goa_human.116.gz -o gene_association.goa_human.116.gz
	gunzip gene_association.goa_human.116.gz

gene_association.goa_human.164:
	# For some reason EBI GOA has changed the filename format since version 158. I rename the file here to the old naming format
	echo Downloading the 2017 GO annotations
	curl --progress-bar ftp://ftp.ebi.ac.uk/pub/databases/GO/goa/old/HUMAN/goa_human.gaf.164.gz -o gene_association.goa_human.164.gz
	gunzip gene_association.goa_human.164.gz

gene_ontology_edit.obo.2012-12-01:
	echo Downloading the 2012 GO
	curl --progress-bar ftp://ftp.geneontology.org/go/ontology-archive/gene_ontology_edit.obo.2012-12-01.gz -o gene_ontology_edit.obo.2012-12-01.gz
	gunzip gene_ontology_edit.obo.2012-12-01.gz

gene_ontology_edit.obo.2017-01-01:
	echo Downloading the 2017 GO
	curl --progress-bar ftp://ftp.geneontology.org/go/ontology-archive/gene_ontology_edit.obo.2017-01-01.gz -o gene_ontology_edit.obo.2017-01-01.gz
	gunzip gene_ontology_edit.obo.2017-01-01.gz

background2012.txt: gene_association.goa_human.116
	cut -f 3 gene_association.goa_human.116 | grep -v -P "^\!"> background2012.txt

background2017.txt: gene_association.goa_human.164
	cut -f 3 gene_association.goa_human.164 | grep -v -P "^\!"> background2017.txt

# Run individual analyses
# scgs
scgs_analysis: scgs_go_analysis_old.txt scgs_go_analysis_new.txt scgs_go_analysis_oldGO_newGOA.txt scgs_go_analysis_newGO_oldGOA.txt
# Only old GO and old GOA
scgs_go_analysis_old.txt: background2012.txt gene_association.goa_human.116 gene_ontology_edit.obo.2012-12-01 scgs.txt Ontologizer.jar
	$(PROG) -p background2012.txt -a gene_association.goa_human.116 -g gene_ontology_edit.obo.2012-12-01 -s scgs.txt
	mv table-scgs-$(METHOD)-$(MTC).txt scgs_go_analysis_old.txt
# Only new GO and new GOA
scgs_go_analysis_new.txt: background2017.txt gene_association.goa_human.164 gene_ontology_edit.obo.2017-01-01 scgs.txt Ontologizer.jar
	$(PROG) -p background2017.txt -a gene_association.goa_human.164 -g gene_ontology_edit.obo.2017-01-01 -s scgs.txt
	mv table-scgs-$(METHOD)-$(MTC).txt scgs_go_analysis_new.txt
# Old GO new GOA
scgs_go_analysis_oldGO_newGOA.txt: background2017.txt gene_ontology_edit.obo.2012-12-01 gene_association.goa_human.164 scgs.txt Ontologizer.jar
	$(PROG) -p background2017.txt -a gene_association.goa_human.164 -g gene_ontology_edit.obo.2012-12-01 -s scgs.txt
	mv table-scgs-$(METHOD)-$(MTC).txt scgs_go_analysis_oldGO_newGOA.txt
# New GO old GOA
scgs_go_analysis_newGO_oldGOA.txt: background2012.txt gene_ontology_edit.obo.2017-01-01 gene_association.goa_human.116 scgs.txt Ontologizer.jar
	$(PROG) -p background2012.txt -a gene_association.goa_human.116 -g gene_ontology_edit.obo.2017-01-01 -s scgs.txt
	mv table-scgs-$(METHOD)-$(MTC).txt scgs_go_analysis_newGO_oldGOA.txt

# Ross et al
ross_analysis: ross_go_analysis_old.txt ross_go_analysis_new.txt ross_go_analysis_oldGO_newGOA.txt ross_go_analysis_newGO_oldGOA.txt
# Only old GO and old GOA
ross_go_analysis_old.txt: background2012.txt gene_association.goa_human.116 gene_ontology_edit.obo.2012-12-01 ross.txt Ontologizer.jar
	$(PROG) -p background2012.txt -a gene_association.goa_human.116 -g gene_ontology_edit.obo.2012-12-01 -s ross.txt
	mv table-ross-$(METHOD)-$(MTC).txt ross_go_analysis_old.txt
# Only new GO and new GOA
ross_go_analysis_new.txt: background2017.txt gene_association.goa_human.164 gene_ontology_edit.obo.2017-01-01 ross.txt Ontologizer.jar
	$(PROG) -p background2017.txt -a gene_association.goa_human.164 -g gene_ontology_edit.obo.2017-01-01 -s ross.txt
	mv table-ross-$(METHOD)-$(MTC).txt ross_go_analysis_new.txt
# Old GO new GOA
ross_go_analysis_oldGO_newGOA.txt: background2017.txt gene_ontology_edit.obo.2012-12-01 gene_association.goa_human.164 ross.txt Ontologizer.jar
	$(PROG) -p background2017.txt -a gene_association.goa_human.164 -g gene_ontology_edit.obo.2012-12-01 -s ross.txt
	mv table-ross-$(METHOD)-$(MTC).txt ross_go_analysis_oldGO_newGOA.txt
# New GO old GOA
ross_go_analysis_newGO_oldGOA.txt: background2012.txt gene_ontology_edit.obo.2017-01-01 gene_association.goa_human.116 ross.txt Ontologizer.jar
	$(PROG) -p background2012.txt -a gene_association.goa_human.116 -g gene_ontology_edit.obo.2017-01-01 -s ross.txt
	mv table-ross-$(METHOD)-$(MTC).txt ross_go_analysis_newGO_oldGOA.txt

# Make comparissons
compare_all: compare_all_scgs compare_all_ross

compare_all_scgs: compare_scgs_oldall_vs_newall compare_scgs_oldall_vs_newGO_oldGOA compare_scgs_oldall_vs_oldGO_newGOA
# Old versus New GO and GOA scgs
compare_scgs_oldall_vs_newall: go_enrichment_analysis_comparisson.r scgs_go_analysis_old.txt scgs_go_analysis_new.txt
	Rscript go_enrichment_analysis_comparisson.r -a scgs_go_analysis_old.txt -b scgs_go_analysis_new.txt
# Old versus New GO and old GOA scgs
compare_scgs_oldall_vs_newGO_oldGOA: go_enrichment_analysis_comparisson.r scgs_go_analysis_old.txt scgs_go_analysis_newGO_oldGOA.txt
	Rscript go_enrichment_analysis_comparisson.r -a scgs_go_analysis_old.txt -b scgs_go_analysis_newGO_oldGOA.txt
# Old versus old GO and new GOA scgs
compare_scgs_oldall_vs_oldGO_newGOA: go_enrichment_analysis_comparisson.r scgs_go_analysis_old.txt scgs_go_analysis_oldGO_newGOA.txt
	Rscript go_enrichment_analysis_comparisson.r -a scgs_go_analysis_old.txt -b scgs_go_analysis_oldGO_newGOA.txt

compare_all_ross: compare_ross_oldall_vs_newall compare_ross_oldall_vs_newGO_oldGOA compare_ross_oldall_vs_oldGO_newGOA
# Old versus New GO and GOA ross
compare_ross_oldall_vs_newall: go_enrichment_analysis_comparisson.r ross_go_analysis_old.txt ross_go_analysis_new.txt
	Rscript go_enrichment_analysis_comparisson.r -a ross_go_analysis_old.txt -b ross_go_analysis_new.txt
# Old versus New GO and old GOA ross
compare_ross_oldall_vs_newGO_oldGOA: go_enrichment_analysis_comparisson.r ross_go_analysis_old.txt ross_go_analysis_newGO_oldGOA.txt
	Rscript go_enrichment_analysis_comparisson.r -a ross_go_analysis_old.txt -b ross_go_analysis_newGO_oldGOA.txt
# Old versus old GO and new GOA ross
compare_ross_oldall_vs_oldGO_newGOA: go_enrichment_analysis_comparisson.r ross_go_analysis_old.txt ross_go_analysis_oldGO_newGOA.txt
	Rscript go_enrichment_analysis_comparisson.r -a ross_go_analysis_old.txt -b ross_go_analysis_oldGO_newGOA.txt

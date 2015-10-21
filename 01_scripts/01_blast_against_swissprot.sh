#!/bin/bash

# Global variables
SEQUENCE_FILE=03_sequences/analyzed_genes.fasta
SWISSPROT_RESULT=04_blast_results/analyzed_genes.swissprot
SWISSPROT_HITS=04_blast_results/analyzed_genes.hits
SWISSPROT_DB=~/Software/blastplus_databases/swissprot

# Blast all sequences against swissprot (must be installed locally)
cat $SEQUENCE_FILE | parallel -k --block 1k --recstart '>' --pipe 'blastx -db '$SWISSPROT_DB' -query - -evalue 1e-3 -outfmt 6 -max_target_seqs 1' > $SWISSPROT_RESULT

# Extract analyzed_genes.hits
awk '{print $1,$2}' $SWISSPROT_RESULT | uniq > $SWISSPROT_HITS


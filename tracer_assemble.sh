#!/bin/bash

set -euo pipefail

#fastqs R1 and R2
FQ1=$1
FQ2=$2

#sample name
SAMPLE=$3

#output direcotry
OUTDIR=$4

mkdir -p "${SAMPLE}/${OUTDIR}/out-${SAMPLE}"
cd $SAMPLE
zcat ${FQ1} > ${SAMPLE}.R1.fastq 
zcat ${FQ2} > ${SAMPLE}.R2.fastq
tracer assemble --loci A B D G -p 4 -s Hsap -c /home/.tracerrc ${FQ1} ${FQ2} out-${SAMPLE} $OUTDIR
rm ${SAMPLE}.R1.fastq
rm ${SAMPLE}.R2.fastq

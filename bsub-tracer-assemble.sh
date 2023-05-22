#!/bin/bash

set -euo pipefail

IMAGE=/nfs/cellgeni/singularity/images/tracer-ubuntu-20_04-trinityrnaseq-2_14_0-igblast-1_19_0-kallisto-0_48_0-grch38-transcript_41-grcm38-transcript_m30.sif

#fastq directory
FQDIR=$1

#sample file containing sample directories within FQDIR
SAMPLE_FILE=$2

#output directory
OUTDIR=$3

SCRIPT=./tracer_assemble.sh
MEM=30000

cat $SAMPLE_FILE | while read SAMPLE; do
  mkdir -p "${SAMPLE}/logs"
  for fq in "${FQDIR}/${SAMPLE}/"*"fastq.gz"; do 
    if [[ "$fq" == *"R1"* ]]; then
      FQ1=`readlink -f ${fq}`
    elif [[ "$fq" == *"R2"* ]]; then
      FQ2=`readlink -f ${fq}`
    fi
  done
  bsub -G cellgeni -n 1 -q long -M $MEM -R"select[mem>${MEM}] rusage[mem=${MEM}]" \
    -o "${SAMPLE}/logs/ooo.${SAMPLE}.%J.txt" -e "${SAMPLE}/logs/eee.${SAMPLE}.%J.txt" \
    /software/singularity-v3.9.0/bin/singularity exec -B /lustre,/nfs $IMAGE \
    $SCRIPT $FQ1 $FQ2 $SAMPLE $OUTDIR
done

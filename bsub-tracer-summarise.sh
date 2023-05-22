#!/bin/bash

set -euo pipefail

IMAGE=/nfs/cellgeni/singularity/images/tracer-ubuntu-20_04-trinityrnaseq-2_14_0-igblast-1_19_0-kallisto-0_48_0-grch38-transcript_41-grcm38-transcript_m30.sif

#location containing tracer output sample subdirectories
INDIR=$1

#output directory for tracer summarise
OUTDIR=$2

#outdir for tracer assemble
ASSEMBLEDIR=$3

SCRIPT=./tracer_summarise.sh
MEM=30000

mkdir -p "${OUTDIR}/logs"
for SAMPLEDIR in ${INDIR}/*; do
  cp -r "${SAMPLEDIR}/${ASSEMBLEDIR}/"* $OUTDIR
done

bsub -G cellgeni -n 16 -q long -M $MEM -R"select[mem>${MEM}] rusage[mem=${MEM}]" \
  -o "${OUTDIR}/logs/ooo.%J.txt" -e "${OUTDIR}/logs/eee.%J.txt" \
  /software/singularity-v3.9.0/bin/singularity exec -B /lustre,/nfs $IMAGE \
  $SCRIPT $OUTDIR

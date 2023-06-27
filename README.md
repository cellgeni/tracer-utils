# tracer-utils

### Scripts

This repository contains scripts for running the Teichlab/tracer package.

`bsub-tracer-assemble.sh` - submits tracer assemble to be executed on the farm (do first)

`bsub-tracer-summarise.sh` - submits tracer summarise to be executed on the farm (do second)

### Dockerfile 

To build a working singularity image for tracer, ensure your environment has docker and singularity installed. Then do the following:
1) `git clone https://github.com/SimonDMurray/tracer.git` (this pull request is yet to be merged)
2) `cd tracer`
3) `docker build -t tracer:v0.6 .`
4) `sudo singularity build tracer_v0.6.sif docker-daemon://tracer:v0.6`

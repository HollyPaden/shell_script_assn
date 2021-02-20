#!/bin/bash
#SBATCH --account=PAS1855
#SBATCH --time=20
#SBATCH --node=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
set -e -u -o pipefail

#Add date
date

#Let script accept 4 arguments that can be passed to it on the command-line
forward_fastq=
output_directory=results_trim
forward_primer=GAGTG[CT]CAGC[AC]GCCGCGGTAA
reverse_primer=TTACCGCGGC[GT]GCTG[AG]CACTC  

forward_fastq="$1"
output_directory="$2"
forward_primer="$3"
reverse_primer="$4"

#Check that arguments are properly provided
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
forward_primer="GAGTG[CT]CAGC[AC]GCCGCGGTAA"
reverse_primer="TTACCGCGGC[GT]GCTG[AG]CACTC"  

forward_fastq="$1"
output_directory="$2"
forward_primer="$3"
reverse_primer="$4"

# Create and assign output directory
mkdir -p $output_directory

#Check whether the FASTQ file exists, if it is a regular file, and if it can be read
if [ ! -f "$forward_fastq" ] || [ ! -r "$forward_fastq" ] || [ ! -e "$fprward_fastq" ]; then

    echo "Error: either is not file, does not exist, or cannot be read"
    echo "You provided $forward_fastq"
    exit 1

fi

# check number of arguments pushed to command line
if [ ! "$#" -eq 4 ]; then

    echo "Error: number of arguments is too great"
    echo "You provided $#"
    exit 1
fi

#Compute the reverse complements of each primer
fp_complement=$(echo "$forward_primer" | tr ATGC[] TACG][ | rev)
rp_complement=$(echo "$reverse_primer" | tr ATGC[] TACG][ | rev)
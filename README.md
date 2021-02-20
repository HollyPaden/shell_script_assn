This README file is the repository to document the **week 06 shell assn**

Copy FASTQ files from `/fs/ess/PAS1855/data/week05/fastq`

`cp -r /fs/ess/PAS1855/data/week05/fastq ./`

Create .gitignore and make it ignore all .fastq files

`touch .gitignore
echo ".fastq" > .gitignore
cat .gitignore`

Load Conda module and create environment for Cutadapt

`module load python/3.6-conda5.2
conda config --get channels
conda create -n cutadaptenv cutadapt
conda activate cutadaptenv
cutadapt --version`

Export Conda environment to YAML file

`conda env export > environment.yml`

Add shebang line, pipe sets, and SLURM directives for project number, 20-minute wall-time limit, one node, one process, and one core.

`#!/bin/bash
#SBATCH --account=PAS1855
#SBATCH --time=20
#SBATCH --node=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
set -e -u -o pipefail`

Load OSC Conda module (see steps above) and activate Cutadapt Conda environment

`source activate cutadaptenv`

Add 4 arguments for command line

`#Let script accept 4 arguments that can be passed to it on the command-line
forward_fastq=
output_directory=results_trim
forward_primer="GAGTG[CT]CAGC[AC]GCCGCGGTAA"
reverse_primer="TTACCGCGGC[GT]GCTG[AG]CACTC"  

forward_fastq="$1"
output_directory="$2"
forward_primer="$3"
reverse_primer="$4"`

Add in the date

`#Add date
date`

Make the output directory

`# Create and assign output directory
mkdir -p $output_directory`

Check and confirm arguments

`#Check whether the FASTQ file exists, if it is a regular file, and if it can be read
if [ ! -f "$forward_fastq" ] || [ ! -r "$forward_fastq" ] || [ ! -e "$fprward_fastq" ]; then

    echo "Error: either is not file, does not exist, or cannot be read"
    echo "You provided $forward_fastq"
    exit 1

fi

#check number of arguments pushed to command line
if [ ! "$#" -eq 4 ]; then

    echo "Error: number of arguments is too great"
    echo "You provided $#"
    exit 1
fi`

Use `tr` and `rev` to generate primer complements

`#Compute the reverse complements of each primer
fp_complement=$(echo "$forward_primer" | tr ATGC[] TACG][ | rev)
rp_complement=$(echo "$reverse_primer" | tr ATGC[] TACG][ | rev)`

Infer the reverse reads FASTQ file name from the forward reads FASTQ file name

`#Infer reverse reads FASTQ file from forward reads FASTQ file
##########reverse_fastq=$(echo "$forward_fastq" )`

**Note: come back to this step, still incomplete**
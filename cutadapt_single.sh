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
forward_fastq=./201-S4-V4-V5_S53_L001_R1_001.fastq
output_directory=./results_trim
forward_primer="GAGTG[CT]CAGC[AC]GCCGCGGTAA"
reverse_primer="TTACCGCGGC[GT]GCTG[AG]CACTC"  

#forward_fastq="$1"
#output_directory="$2"
#forward_primer="$3"
#reverse_primer="$4"

# Create and assign output directory
mkdir -p "$output_directory"

#Message to indicate the script has initiated
echo "Script running...please wait"

#Check whether the FASTQ file exists, if it is a regular file, and if it can be read
if [ ! -f "$forward_fastq" ] || [ ! -r "$forward_fastq" ] || [ ! -e "$forward_fastq" ]; then

    echo "Error: either is not file, does not exist, or cannot be read"
    echo "You provided $forward_fastq"
    exit 1

fi

# check number of arguments pushed to command line
if [ ! "$#" -eq 4 ]; then

    echo "Error: number of arguments is incorrect"
    echo "You provided $#"
    exit 1
fi

#Indicate quality check complete
echo "Control checks complete, files and arguments accepted"

#Compute the reverse complements of each primer
fp_complement=$(echo "$forward_primer" | tr ATGC[] TACG][ | rev)
rp_complement=$(echo "$reverse_primer" | tr ATGC[] TACG][ | rev)

#Indicate complements calculated
echo "Primer compliments computed"

#Infer reverse reads FASTQ file from forward reads FASTQ file
reverse_fastq="$(echo "$forward_fastq" | grep  _R1_ | sed 's/R1/R2/' )"

#Indicate reverse FASTQ inferred
echo "Reverse reads FASTQ initiated"

#Change output file name
trimmed_fastq_f="$(basename "$forward_fastq" .fastq)-_trimmed.fastq"
echo "$trimmed_fastq_f"
trimmed_fastq_r="$(basename "$reverse_fastq" .fastq)-_trimmed.fastq"
echo "$trimmed_fastq_r"

#Indicate trimmed FASTQ arguments created
echo "Trimmed sequences completed...assigning to directory"

#Assign output file paths
"$forward_fastq" > "$output_directory"/"$trimmed_fastq_f"
"$reverse_fastq" > "$output_directory"/"$trimmed_fastq_r"

#Indicate assignment complete
echo "Directory assignment complete...calling Cutadapt"

#Call Cutadapt
cutadapt -a "$forward_primer"..."$rp_complement" \
    -A "$reverse_primer"..."$fp_complement" \
    --discard-untrimmed --pair-filter=any \
    -o "$trimmed_fastq_f" -p "$trimmed_fastq_r" "$forward_fastq" "$reverse_fastq"

#Report completion of Cutadapt run
echo "Cutadapt complete at..."

#Follow up with date
date
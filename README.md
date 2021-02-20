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
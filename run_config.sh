#!/usr/bin/bash
set -e ;
trap 'exit' INT ;
source ~/.bashrc ;

echo "init done..."

conda activate metaprism_python ;
echo "conda env is activated..."

# /mnt/beegfs/userdata/j_wang/.conda/envs/snakemake/bin/snakemake --unlock ;
# echo "snake unlocked..."

/mnt/beegfs/userdata/j_wang/.conda/envs/snakemake/bin/snakemake \
        --cluster 'sbatch --output=logs/slurm/slurm.%j.%N.out --cpus-per-task={threads} --mem={resources.mem_mb}M -p {resources.queue}' \
        --jobs 20 --latency-wait 50 --rerun-incomplete --use-conda \
        -s workflow/adapter/sting_unlock_entry_point.smk \
        --config bilan_table=/home/j_wang@intra.igr.fr/sting_docs/bilan.xlsx dataset_table=/home/j_wang@intra.igr.fr/sting_docs/metadata.csv batch_num=19 ;

# conda deactivate ; 

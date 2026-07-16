#!/bin/bash
#SBATCH --job-name=e1d_create_init
#SBATCH --partition=compute
#SBATCH --nodes=1
#SBATCH --mem=40G
#SBATCH --time=00:10:00
#SBATCH --mail-user=clara.bayley@mpimet.mpg.de
#SBATCH --mail-type=FAIL
#SBATCH --account=mh1126
#SBATCH --output=/work/mh1126/m300950/rain-evap-nils/sdm-eurec4a-CLEO/data/logfiles/create_init_files/mpi4py/.%j_out.out
#SBATCH --error=/work/mh1126/m300950/rain-evap-nils/sdm-eurec4a-CLEO/data/logfiles/create_init_files/mpi4py/.%j_err.out

### --------------------- Version --------------------- ###
echo "git hash: $(git rev-parse HEAD)"
echo "git branch: $(git symbolic-ref --short HEAD)"
echo "date: $(date)"
echo "============================================"
### ---------------------------------------------------- ###``

source ${HOME}/.bashrc

### ------------------ Load Modules -------------------- ###
env=/home/m/m300950/mamba/envs/sdm_eurec4a_cleo_env
# module purge
micromamba activate ${env}

python=${env}/bin/python
echo "Using Python: ${python}"
### ---------------------------------------------------- ###

### ------------------ Input Parameters ---------------- ###
# microphysics="null_microphysics"
# microphysics="condensation"
microphysics="collision_condensation"
# microphysics="coalbure_condensation_small"
# microphysics="coalbure_condensation_large"
# microphysics="coalbure_condensation_cke"

path2eurec4a1d=/home/m/m300950/rain-evap-nils/sdm-eurec4a-CLEO/examples/eurec4a1d/
path2input=/work/mh1126/m300950/rain-evap-nils/sdm-eurec4a/data/model/input_v4.2/
path2output=/work/mh1126/m300950/rain-evap-nils/sdm-eurec4a-CLEO/data/output_v4.2/${microphysics}

echo "============================================"
echo "microphysics: ${microphysics}"
echo "path2eurec4a1d: ${path2eurec4a1d}"
echo "path2input: ${path2input}"
echo "path2output: ${path2output}"

path2pythonscript=${path2eurec4a1d}/scripts/create_model_input_mpi4py.py
echo "path2pythonscript: ${path2pythonscript}"

echo "============================================"
echo "path2output: ${path2output}"
echo "path2input: ${path2input}"

echo "============================================"
default_config_path=${path2eurec4a1d}/default_config/eurec4a1d_config_stationary.yaml

# validate the breakup file path exists
if [ ! -f ${default_config_path} ]; then
    echo "config file path does not exist: ${default_config_path}"
    exit 1
fi

echo "default config path: ${default_config_path}"
if [ "${microphysics}" == "null_microphysics" ] || [ "${microphysics}" == "condensation" ] || [ "${microphysics}" == "collision_condensation" ]; then
    breakup_file_path=${path2eurec4a1d}/default_config/breakup.yaml
else
    breakup_file_path=${path2eurec4a1d}/stationary_${microphysics}/src/breakup.yaml
fi

# validate the breakup file path exists
if [ ! -f ${breakup_file_path} ]; then
    echo "breakup file path does not exist: ${breakup_file_path}"
    exit 1
fi

echo "breakup file path: ${breakup_file_path}"


### ---------------------------------------------------- ###
echo "============================================"

### ---- Creation of init files
echo "srun ${python} ${path2pythonscript} --input_dir_path ${path2input} --output_dir_path ${path2output} --breakup_config_file_path ${breakup_file_path} --default_config_file_path ${default_config_path}"
srun ${python} ${path2pythonscript} --input_dir_path ${path2input} --output_dir_path ${path2output} --breakup_config_file_path ${breakup_file_path} --default_config_file_path ${default_config_path}

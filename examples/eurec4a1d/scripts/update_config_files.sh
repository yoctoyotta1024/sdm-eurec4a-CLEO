#!/bin/bash
#SBATCH --job-name=eurec4a1d_update_config
#SBATCH --partition=compute
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=128
#SBATCH --exclusive
#SBATCH --time=01:00:00
#SBATCH --mail-user=clara.bayley@mpimet.mpg.de
#SBATCH --mail-type=FAIL
#SBATCH --account=mh1126
#SBATCH --output=/work/mh1126/m300950/rain-evap-nils/sdm-eurec4a-CLEO/data/logfiles/update_config/log.%j_out.out
#SBATCH --error=/work/mh1126/m300950/rain-evap-nils/sdm-eurec4a-CLEO/data/logfiles/update_config/log.%j_err.out

### ---------------------------------------------------- ###
### ------------------ Input Parameters ---------------- ###
### ------ You MUST edit these lines to set your ------- ###
### ----- environment, build type, directories, the ---- ###
### --------- executable(s) to compile and your -------- ###
### --------------  python script to run. -------------- ###
### ---------------------------------------------------- ###

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "START RUN"
date
echo "git hash: $(git rev-parse HEAD)"
echo "git branch: $(git symbolic-ref --short HEAD)"
echo "============================================"

# set paths
path2data=/work/mh1126/m300950/rain-evap-nils/sdm-eurec4a-CLEO/data/debug_output/
path2eurec4a1d=/home/m/m300950/rain-evap-nils/sdm-eurec4a-CLEO/examples/eurec4a1d/
subdir_pattern=cluster_

# python script to run
pythonscript=${path2eurec4a1d}scripts/eurec4a1d_update_config.py

### ---------- Setup for the EUREC4A1D model ---------- ###
# Use the stationary setup of the model

# # NO PHYSICS
# rawdirectory=${path2data}stationary_no_physics/

# CONDENSTATION
# rawdirectory=${path2data}stationary_condensation/

# # COLLISION AND CONDENSTATION
rawdirectory=${path2data}/

### ---------------------------------------------------- ###



### ------------------ Load Modules -------------------- ###
sdm_eurec4a_cleo_env=/home/m/m300950/mamba/envs/sdm_eurec4a_cleo_env
python=${sdm_eurec4a_cleo_env}/bin/python3
micromamba activate ${sdm_eurec4a_cleo_env}
### ---------------------------------------------------- ###

### -------------------- print inputs ------------------ ###
echo "----- Update Config Files -----"
echo "pythonscript: ${pythonscript}"
echo "---------------------------"
### --------------------------------------------------- ###


echo "Update Config Files"
for exp_folder in ${rawdirectory}/${subdir_pattern}*; do
    echo "::::::::::::::::::::::::::::::::::::::::::::"
    echo "UPDATE CONFIG FILE"
    echo "in ${exp_folder}"
    {
        ${python}  ${pythonscript} ${exp_folder}
    } || {
        echo "============================================"
        echo "EXCECUTION ERROR: in ${exp_folder}"
        echo "============================================"
    }
    echo "::::::::::::::::::::::::::::::::::::::::::::"
done
### ---------------------------------------------------- ###

echo "--------------------------------------------"
date
echo "END RUN"
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"

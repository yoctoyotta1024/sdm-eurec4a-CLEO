#!/bin/bash
#SBATCH --job-name=inputfiles
#SBATCH --partition=compute
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=940M
#SBATCH --time=00:05:00
#SBATCH --mail-user=clara.bayley@mpimet.mpg.de
#SBATCH --mail-type=FAIL
#SBATCH --account=mh1126
#SBATCH --output=./build/bin/inputfiles_out.%j.out
#SBATCH --error=./build/bin/inputfiles_err.%j.out

### ----- You need to edit these lines to set your ----- ###
### ----- default compiler and python environment   ---- ###
### ----  and paths for CLEO and build directories  ---- ###
path2sdmeurec4aCLEO=${2:-/home/m/m300950/rain-evap-nils/sdm-eurec4a-CLEO}
path2scripts=${path2sdmeurec4aCLEO}/scripts
mambaenv=/home/m/m300950/mamba/envs/sdm_eurec4a_cleo_env
python=${mambaenv}/bin/python
### ---------------------------------------------------- ###

configfile=$1
path2build=${3:-${path2sdmeurec4aCLEO}/build}

if [ "${configfile}" == "" ]
then
  echo "Please specify config file"
else

  echo "config file: ${configfile}"
  echo "path to build directory: ${path2build}"

  ### --------------- create gbx boundaries -------------- ###
  echo "${python} create_gbxboundariesbinary_script.py ${path2sdmeurec4aCLEO} ${path2build} ${configfile}"
  ${python} ${path2scripts}/create_gbxboundariesbinary_script.py ${path2sdmeurec4aCLEO} ${path2build} ${configfile}
  ### ---------------------------------------------------- ###

  ### -------- create superdrop initial conditions ------- ###
  echo "${python} create_initsuperdropsbinary_script.py ${path2sdmeurec4aCLEO} ${path2build} ${configfile}"
  ${python} ${path2scripts}/create_initsuperdropsbinary_script.py ${path2sdmeurec4aCLEO} ${path2build} ${configfile}
  ### ---------------------------------------------------- ###

  ### --------- create thermodynamics (optional) --------- ###
  echo "${python} create_thermobinaries_script.py ${path2sdmeurec4aCLEO} ${path2build} ${configfile}"
  ${python} ${path2scripts}/create_thermobinaries_script.py ${path2sdmeurec4aCLEO} ${path2build} ${configfile}
  ### ---------------------------------------------------- ###
fi

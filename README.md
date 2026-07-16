<!-- /*
 * ----- CLEO -----
 * File: README.md
 * Project: sdm-eurec4a-CLEO
 * Created Date: 2023/01/12 (yyyy/mm/dd)
 * Author: Clara Bayley (CB)
 * Additional Contributors: Nils Niebaum (NN)
 * -----
 * Last Modified: 2023/01/12
 * Modified By: CB
 * -----
 * License: BSD 3-Clause "New" or "Revised" License
 * https://opensource.org/licenses/BSD-3-Clause
 * -----
 * Copyright (c) 2023 MPI-M, Clara Bayley
 */ -->

# sdm-eurec4a-CLEO

This repository was renamed from CLEO -> CLEO-sdm-eurec4a -> sdm-eurec4a-CLEO after two "forking events":
first was a fork of the original [CLEO](https://github.com/yoctoyotta1024/CLEO) repository created by Clara Bayley;
and then the resultant forked repository by Nils Niebaum, [CLEO-sdm-eurec4a](https://github.com/nilsnevertree/CLEO-sdm-eurec4a),
was forked again by Clara Bayley to make this repo.

## Cloning this repo
To make this repository work properly, make sure to not just simply clone the repository, but clone it into the directory ``CLEO`` in your ``$Home`` directory.
This makes everything much easier!

````bash
git clone https://github.com/yoctoyotta1024/sdm-eurec4a-CLEO /your/path/to/sdm-eurec4a-CLEO
````

# Original CLEO part
CLEO is a library for Super-Droplet Model microphysics.
You can read more about CLEO in its
documentation: <https://yoctoyotta1024.github.io/CLEO/>.

# Installing mpi4py Levante

On Levante, you may have trouble using ``mpi4py`` within a micromamba/conda environment. E.g. the
following Python script will fail:

``` python
from mpi4py import MPI

comm = MPI.COMM_WORLD
print(f"Rank: {comm.Get_rank()}, Size: {comm.Get_size()}")
```

with the error ``RuntimeError: cannot load MPI library``.

If so, you need to re-install ``mpi4py`` with the correct links to Levante's openmpi modules:

``` bash
### load relevant packages on Levante
$ module load python3 gcc/11.2.0-gcc-11.2.0 openmpi/4.1.2-gcc-11.2.0
$ export MPI4PY_BUILD_MPICC=/sw/spack-levante/openmpi-4.1.2-mnmady/bin/mpicc
$ export MPI4PY_BUILD_MPILD=/sw/spack-levante/openmpi-4.1.2-mnmady/lib

### uninstall and re-install mpi4py
$ mamba install mpi=*=*
$ python -m pip uninstall mpi4py
$ python -m pip install --no-cache-dir --no-binary=mpi4py mpi4py

### (optional but good to remove if they've been installed)
$ rm  /path/to/your/env/sdm_eurec4a_cleo_env/lib/libmpi.so
$ rm  /path/to/your/env/sdm_eurec4a_cleo_env/lib/libmpi.so.40

### check the installation worked
$ python -c 'import ctypes.util; print(ctypes.util.find_library("mpi"))'
```

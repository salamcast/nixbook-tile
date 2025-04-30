#!/bin/bash
# didn't work in my build script

curl -LsSf https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o conda.sh

sh conda.sh -b -p $HOME/miniconda3 || exit 1
rm conda.sh

PATH=$HOME/bin:$HOME/.local/bin:$HOME/miniconda3/bin:/usr/local/bin:$PATH


conda install pandas

conda install numpy

conda install matplotlib

conda install seaborn

conda install -c conda-forge jupyterlab

conda install cx_Oracle

conda install pymysql
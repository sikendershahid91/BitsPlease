#!/bin/bash

export PATH=$PATH:~/intelFPGA_lite/17.1/modelsim_ase/bin

echo "COPYING THESE FILES OVER TO SIM"
for files in *; do
	echo $files
	cp -r $files ../sim/
done

rm ../sim/copy2sim.sh

# add to your path PATH=$PATH:~/intelFPGA_lite/17.1/modelsim_ase/bin

cd ../sim/

echo "**********  COMPILING FILES IN THE DIRECTORIES"
vlog */*.v
echo "**********  COMPILING FILES IN THE FOLDERS"
vlog *.v

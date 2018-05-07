#!/bin/bash

export PATH=$PATH:~/intelFPGA_lite/17.1/modelsim_ase/bin

echo "COPYING THESE FILES OVER TO SIM"
for files in */*.v; do
	echo $files
	cp $files ../sim/
done

# add to your path PATH=$PATH:~/intelFPGA_lite/17.1/modelsim_ase/bin

cd ../sim/
vlog *.v

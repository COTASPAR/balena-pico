#!/bin/bash

#Get the repo (if there is a repo argument) otherwise assume we already are in the directory where we want to flash the code
if [ $# -eq 0 ]
  then
    echo "Flashing local repo"
  else
    echo "External epo supplied, cloning ..."
    git clone $1
    cd $1
fi
#-----------------------------------------------------------------------------

#Build .uf2 file
DIR="/build/"
if [ -d "$DIR" ]; then
  # Get rid of old build junk #
  rm -rf $DIR
fi
mkdir build
cd build
cmake ..
make
echo "Build finished"
#------------------------------------------------------------------------------


#Flashing pico
UF2=$(find . -name '*.elf')
echo "UF2 file is at: ${UF2}"
openocd -f interface/raspberrypi-swd.cfg -f target/rp2040.cfg -c 'program '"$UF2"' verify reset exit'
#------------------------------------------------------------------------------

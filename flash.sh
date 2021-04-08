#!/bin/bash

#sudo apt install pciutils
#sudo apt-get install usbutils
#apt-get install udev

#Build .uf2 file
mkdir build
cd build
cmake ..
make
echo "Build finished"
#ls

#cd /pico_detect

#Flashing pico

DIR="/mnt/pico"
if [ -d "$DIR" ]; then
  echo "Pico is already mounted at ${DIR}..."
else
  #echo "Pico has not been mounted. Mounting now at ${DIR}"
  sudo mkdir -p /mnt/pico
  sudo mount /dev/sda1 /mnt/pico
  #sudo mount /dev/ttyACM0 /mnt/pico
fi

echo "Pico has not been mounted. Mounting now at ${DIR}"

UF2=$(find . -name '*.uf2')

echo "UF2 file is at: ${UF2}"

sudo cp "${UF2}" /mnt/pico
sudo sync

#Reading pico output
minicom -b 115200 -o -D /dev/ttyACM0

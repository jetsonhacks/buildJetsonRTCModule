#!/bin/sh
# Prepare to build the RTC DS3232 module  for LT4 21.4 on the NVIDIA Jetson TK1
if [ $(id -u) != 0 ]; then
   echo "This script requires root permissions"
   echo "$ sudo "$0""
   exit
fi
# Get the kernel source for LT4 21.4
cd /usr/src/
wget http://developer.download.nvidia.com/embedded/L4T/r21_Release_v4.0/source/kernel_src.tbz2
# Decompress
tar -xvf kernel_src.tbz2
cd kernel
# Get the kernel configuration file
zcat /proc/config.gz > .config
# Enable DS3232 compilation
sudo sed -i 's/# CONFIG_RTC_DRV_DS3232 is not set/CONFIG_RTC_DRV_DS3232=m/' .config
# Make sure that the local kernel version is set
LOCALVERSION=$(uname -r)
# vodoo incantation; This removes everything from the beginning to the last occurrence of "-"
# of the local version string i.e. 3.10.40 is removed
release="${LOCALVERSION##*-}"
CONFIGVERSION="CONFIG_LOCALVERSION=\"-$release\""
# Replace the empty local version with the local version of this kernel
sudo sed -i 's/CONFIG_LOCALVERSION=""/'$CONFIGVERSION'/' .config
# Prepare the module for compilation
make prepare
make modules_prepare
# Compile the module
make M=drivers/rtc/
# After compilation, copy the compiled module to the system area
cp drivers/rtc/rtc-ds3232.ko /lib/modules/$(uname -r)/kernel
depmod -a
/bin/echo -e "\e[1;32mFTDI Driver Module Installed.\e[0m"


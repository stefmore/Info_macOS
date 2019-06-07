#!/bin/sh

#Computer Name
CN=`networksetup -getcomputername`

#cpuinfo = model+clock
cpuinfo=`sysctl -n machdep.cpu.brand_string | awk '{print$2}'`
core=`sysctl hw.physicalcpu | awk '{print$2}'`

#Mac model
model=`curl -s https://support-sp.apple.com/sp/product?cc=$(
  system_profiler SPHardwareDataType \
    | awk '/Serial/ {print $4}' \
    | cut -c 9-
) | sed 's|.*<configCode>\(.*\)</configCode>.*|\1|'`

# Distro
distro="macOS"
version=`sw_vers -productVersion`

#memory info
memory=`system_profiler SPHardwareDataType | grep "Memory" | awk '{print$2,$3}'`

#storage info
storage=`system_profiler SPStorageDataType | grep "Capacity" | awk '{print$2,$3}'NR==1{exit}`
medium=`system_profiler SPStorageDataType | grep "Medium" | awk '{print$3}'`
device=`system_profiler SPStorageDataType | grep "Device" | awk '{print$3}'`
file=`system_profiler SPStorageDataType | grep "File" | awk '{print$3}'`
available=`system_profiler SPStorageDataType | grep "Available" | awk '{print$2,$3}'`

echo "$CN|$model|$distro $version|$cpuinfo|$core cores|$memory|$file|$device|$storage|$medium|$available"

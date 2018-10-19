#!/bin/sh

#Computer Name
CN=`networksetup -getcomputername`

#cpuinfo = model+clock
cpuinfo=`sysctl -n machdep.cpu.brand_string`

# Distro
distro="macOS"
version=`sw_vers -productVersion`

#memory info
memory=`system_profiler SPHardwareDataType | grep "Memory" | awk '{print$2,$3}'`

#storage info
storage=`system_profiler SPStorageDataType | grep "Capacity" | awk '{print$2,$3}'NR==1{exit}`
medium=`system_profiler SPStorageDataType | grep "Medium" | awk '{print$3}'
device=`system_profiler SPStorageDataType | grep "Device" | awk '{print$4,$5}'`
file=`system_profiler SPStorageDataType | grep "File" | awk '{print$3}'`
available=`system_profiler SPStorageDataType | grep "Available" | awk '{print$2,$3}'`

echo "$CN|$distro $version|$cpuinfo|$memory|$file|$storage $medium|$available"

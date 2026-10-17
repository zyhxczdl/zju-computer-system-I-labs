#!/bin/sh

# Change to Your spike and pk path 
# For example: 
# SPIKE_PATH="/home/sys1-sp25/repo/build/spike/spike"
# PK_PATH="/home/sys1-sp25/repo/build/riscv-pk/pk"
SPIKE_PATH=/mnt/c/Users/huangshuyan/riscv-isa-sim/build/spike
PK_PATH=/home/huangshuyan258/riscv-pk/build/pk

$SPIKE_PATH $PK_PATH $*
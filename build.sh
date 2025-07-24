#!/bin/bash

set -e

START_TIME=$(date +%s)
BUILD_LOG="build-$(date '+%Y%m%d-%H%M%S').log"

echo "[$(date '+%H:%M:%S')] Starting build..."

if [ ! -f "Vagrantfile" ]; then
    echo "Error: Vagrantfile not found. Please run this script from the project root."
    exit 1
fi


log_message() {
    echo "$1" | tee -a "$BUILD_LOG"
}

log_message "[$(date '+%H:%M:%S')] Creating VMs and provisioning..."

if command -v unbuffer >/dev/null 2>&1; then

    unbuffer vagrant up --parallel 2>&1 | tee -a "$BUILD_LOG"

else

    log_message "[$(date '+%H:%M:%S')] Install unbuffer for colour output"
    vagrant up --parallel 2>&1 | tee -a "$BUILD_LOG"

fi 


END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))
MINUTES=$((DURATION / 60))
SECONDS=$((DURATION % 60))

log_message "[$(date '+%H:%M:%S')] Build completed in ${MINUTES}m ${SECONDS}s"
log_message "Build log: $BUILD_LOG"


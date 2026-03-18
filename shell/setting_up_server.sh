#!/bin/bash

# ----------------------------------------
# Setup script for MLOps workshop
# Run AFTER cloning the repository
# ----------------------------------------

echo "=== Starting setup ==="

# Exit immediately if something fails
set -e

# ----------------------------------------
# 1. Update system
# ----------------------------------------
echo "=== Updating system ==="
sudo apt update && sudo apt upgrade -y

# ----------------------------------------
# 2. Install required packages
# ----------------------------------------
echo "=== Installing dependencies ==="
sudo apt install -y python3 python3-venv python3-pip

# ----------------------------------------
# 3. Create virtual environment (only if not exists)
# ----------------------------------------
if [ ! -d "venv" ]; then
    echo "=== Creating virtual environment ==="
    python3 -m venv venv
else
    echo "=== Virtual environment already exists ==="
fi

# ----------------------------------------
# 4. Activate environment
# ----------------------------------------
source venv/bin/activate

# ----------------------------------------
# 5. Upgrade pip
# ----------------------------------------
echo "=== Upgrading pip ==="
pip install --upgrade pip

# ----------------------------------------
# 6. Install requirements (if present)
# ----------------------------------------
if [ -f "requirements.txt" ]; then
    echo "=== Installing Python requirements ==="
    pip install -r requirements.txt
else
    echo "=== No requirements.txt found ==="
fi

# ----------------------------------------
# 7. Create standard folders
# ----------------------------------------
echo "=== Creating folders ==="
mkdir -p logs data outputs scripts

# ----------------------------------------
# 8. Done
# ----------------------------------------
echo "=== Setup complete ==="

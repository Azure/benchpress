#!/bin/sh

# Install Mega Linter
npm install -g mega-linter-runner

# Install Pester
pwsh -command Install-Module -Name Pester -Force -SkipPublisherCheck

# Installs the gRPC Tools
python -m pip install grpcio-tools

# Configures benchpress Python module
pip install --editable ./framework/python/

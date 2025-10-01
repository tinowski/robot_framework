#!/bin/bash

# Create Screenshots directory if it doesn't exist
mkdir -p Screenshots
chmod 777 Screenshots

# Clean up any selenium screenshots from previous runs
find . -type f -name "selenium-screenshot-*.png" -delete
rm -rf ./NONE

# Run tests
robot --outputdir Results Tests/

# Clean up any new selenium screenshots
find . -type f -name "selenium-screenshot-*.png" -delete
rm -rf ./NONE
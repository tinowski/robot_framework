#!/bin/bash
# Create Screenshots directory if it doesn't exist
mkdir -p Screenshots
chmod 777 Screenshots

# Clean up any selenium screenshots
rm -f selenium-screenshot-*.png
rm -f ./NONE/selenium-screenshot-*.png
rm -rf ./NONE

# Run tests
robot --outputdir Results Tests/

# Clean up any new selenium screenshots
rm -f selenium-screenshot-*.png
rm -f ./NONE/selenium-screenshot-*.png
rm -rf ./NONE
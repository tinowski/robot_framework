#!/bin/bash
# Run tests and clean up automatically
robot Tests/ && find . -name "selenium-screenshot-*.png" -delete
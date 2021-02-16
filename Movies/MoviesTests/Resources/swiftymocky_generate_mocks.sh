#!/bin/bash

# This script runs the swiftymocky command directly from the executable located in this directory
# Make sure to update the command whenever you update SwiftyMocky pod version
# Check how to install the swiftymocky command on your system here: 
# https://github.com/MakeAWishFoundation/SwiftyMocky

PATH=$PATH:$(cd ./../../Movies/MoviesTests/Resources && pwd)
swiftymocky generate

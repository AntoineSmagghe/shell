#!/bin/bash

# Script to remove a pattern in multiple filenames

patternToRemove=$1

for i in "*$patternToRemove*"
    do mv $i ${i/$patternToRemove/}
done
#!/bin/sh

# Simple script to get random hash

if [ -n "$1" ]; then
	length=$1;
else
	length=15;
fi

tr -dc A-Za-z0-9 </dev/urandom | head -c $length; echo ''

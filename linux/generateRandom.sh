#!/bin/sh

length=$1;

random=</dev/urandom tr -dc A-Za-z0-9 | head -c $length; echo ''

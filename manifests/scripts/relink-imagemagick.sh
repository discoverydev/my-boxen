#!/bin/bash

convert > /dev/null 

if [[ $? == 127 ]]; then
    brew link --force imagemagick@6
fi

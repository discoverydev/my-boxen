#!/bin/bash

convert > /dev/null 

if [[ $? == 127 ]]; then
    echo "it ain't linked"
fi

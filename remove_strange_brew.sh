#!/bin/bash

if [ -d /usr/local/Cellar ]; then
    echo "Found Cellar directory under /usr/local/Cellar - removing"
    rm -rf /usr/local/Cellar
fi

# Find and eliminate broken links, under the assumption that they are linked to the old Cellar
if [ -x /usr/local/bin/brew ]; then
    echo "Found brew executable in /usr/local/bin, pruning old links and executables"
    for thing in $(find /usr/local/bin -type l -exec sh -c "file -b {} | grep -q ^broken" \; -print); do
        echo "Removing ${thing}"
        rm -f $thing
    done

    rm -f brew stree genyshell
fi


#!/bin/bash

set -Eeuo pipefail

# Script to be run at the top level of the Charite diagnostics tree. Pass
# directory names as arguments and a pipelines/standard directory will be
# created in each of those directories (unless it already exists), with a
# copy of the standard pipeline. This can also be used to update the
# pipeline scripts in each directory.

case $# in
	0) echo "Usage: $(basename $0) dir1 [dir2...]"; exit 1;;
esac

cwd=$(/bin/pwd)

for dir in "$@"
do
    echo "Setting up $dir"

    if [ ! -d $dir/pipelines/standard ]
    then
        echo "  Making pipelines/standard sub-directory"
        mkdir -p $dir/pipelines/standard
    else
        echo "  pipelines/standard sub-directory already exists"
    fi

    echo "  Copying pipeline files"
    tar -C csd3-pipeline -c -f - . | tar -C $dir/pipelines/standard -x -f -
done

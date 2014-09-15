#!/bin/bash

NAME="2014-09-25_gputalk"

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
BUILD_PATH=$SCRIPTPATH/build
OUTPUT_FILE=$SCRIPTPATH/${NAME}.pdf
REPO_PATH="$SCRIPTPATH/${NAME}"

if [ "$1" = "clean" ]; then
    rm -rf $BUILD_PATH $OUTPUT_FILE
    exit 0
fi

if [ ! -d "$BUILD_PATH" ]; then
    mkdir -p "$BUILD_PATH"
    cd "$BUILD_PATH"

    fi

# the actual build command
cd "$BUILD_PATH"

pdflatex $REPO_PATH/presentation.tex

# cleanup on failure
rc=$?
if [[ $rc != 0 ]] ; then
    cd "$SCRIPTPATH"
    rm -rf "$BUILD_PATH"
    exit $rc
fi

cp presentation.pdf $OUTPUT_FILE


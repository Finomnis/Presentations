#!/bin/bash



if [ "$#" -ne 1 ]; then
    PRES_NAMES=`find . -maxdepth 1 -type d -not -path '*/.*' -not -name "." | sed 's#.*/##' | grep -v build`
    echo "Usage: $0 <presentation_name>"
    echo
    echo "  Available Presentations:"
    for NAME in $PRES_NAMES; do
        echo "      $NAME"
    done
    exit 2
fi


NAME="$1"

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
BUILD_PATH=$SCRIPTPATH/build
OUTPUT_FILE=$SCRIPTPATH/${NAME}.pdf
REPO_PATH="$SCRIPTPATH/${NAME}"

if [ "$1" = "clean" ]; then
    rm -rf $BUILD_PATH
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

pdflatex $REPO_PATH/presentation.tex

cp $BUILD_PATH/presentation.pdf $OUTPUT_FILE


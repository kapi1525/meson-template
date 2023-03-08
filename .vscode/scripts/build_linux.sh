#!/bin/bash

BUILD_DIR="$1"      # ${config:mesonbuild.buildFolder} or eg: "bin"
BUILD_TYPE="$2"     # ${command:cpptools.activeConfigName} or "debug", "release" etc

if [[ -z $BUILD_DIR || -z $BUILD_TYPE ]]; then
    echo "Something went wrong ¯\_(ツ)_/¯"
    exit
fi


clear

if [[ ! -e "$BUILD_DIR/meson-info/meson-info.json" ]]; then
    meson setup "$BUILD_DIR" --buildtype "$BUILD_TYPE"
fi

LAST_BUILD_TYPE=`cat "$BUILD_DIR/meson-info/intro-buildoptions.json" | sed -r -e 's/.*"name": "buildtype", "value": "(release|debug|debugoptimized)".*/\1/g'`

if [[ $LAST_BUILD_TYPE != $BUILD_TYPE ]]; then
    echo "Build type changed, reconfiguring... ($LAST_BUILD_TYPE -> $BUILD_TYPE)"
    meson setup --reconfigure "$BUILD_DIR" --buildtype "$BUILD_TYPE"
fi


meson compile -C "$BUILD_DIR"

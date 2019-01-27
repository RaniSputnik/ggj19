#!/bin/bash

BUILD_DIR=build/osx
APP=SilenceAndFingerFood.app
PLIST_LOCATION=src/assets/misc/Info.plist

echo "Cleaning build directory"
rm -R $BUILD_DIR
mkdir $BUILD_DIR

echo "Copying love.app into build directory"
cp -a /Applications/love.app $BUILD_DIR
mv $BUILD_DIR/love.app $BUILD_DIR/$APP

echo "Generating silence.love"
pushd src; zip -9 -r ../$BUILD_DIR/$APP/Contents/Resources/silence.love .; popd

echo "Copying info.plist from $PLIST_LOCATION"
cp src/assets/misc/Info.plist $BUILD_DIR/$APP/Contents/
#!/bin/sh

rm -R -f FsprgEmbeddedStoreSDK
./build_project.sh "FsprgEmbeddedStore" "Release 10.4" "FsprgEmbeddedStoreSDK/MacOS 10.5+"
./build_project.sh "FsprgEmbeddedStore" "Release 10.5+" "FsprgEmbeddedStoreSDK/MacOS 10.4"
./build_project.sh "TestApp" "Release" "FsprgEmbeddedStoreSDK"
./build_project.sh "FsprgEmbeddedStore" "Source" "FsprgEmbeddedStoreSDK/src"
./build_project.sh "Example1" "Source" "FsprgEmbeddedStoreSDK/src"
./build_project.sh "Example2" "Source" "FsprgEmbeddedStoreSDK/src"

# FsprgEmbeddedStoreStyle.zip
zip -r FsprgEmbeddedStoreStyle FsprgEmbeddedStoreStyle -x *.svn* *.DS_Store*

# README.html
mkdir -p FsprgEmbeddedStoreSDK/README
cp -R -f README/* FsprgEmbeddedStoreSDK/README
perl ./Markdown_1.0.1/Markdown.pl --html4tags README.mdown >> ./FsprgEmbeddedStoreSDK/README.html

# License.txt
cp -R License.txt FsprgEmbeddedStoreSDK

# Package and remove temp directory
tar -zcf FsprgEmbeddedStoreSDK.tar.gz FsprgEmbeddedStoreSDK
rm -R -f FsprgEmbeddedStoreSDK
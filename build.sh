#!/bin/sh

rm -R -f FsprgEmbeddedStoreMacSDK
./build_project.sh "FsprgEmbeddedStore" "Release 10.4" "FsprgEmbeddedStoreMacSDK/MacOS 10.4"
./build_project.sh "FsprgEmbeddedStore" "Release 10.5+" "FsprgEmbeddedStoreMacSDK/MacOS 10.5+"
./build_project.sh "TestApp" "Release" "FsprgEmbeddedStoreMacSDK"
./build_project.sh "FsprgEmbeddedStore" "Source" "FsprgEmbeddedStoreMacSDK/src"
./build_project.sh "Example1" "Source" "FsprgEmbeddedStoreMacSDK/src"
./build_project.sh "Example2" "Source" "FsprgEmbeddedStoreMacSDK/src"

# FsprgEmbeddedStoreStyle.zip
zip -r FsprgEmbeddedStoreStyle FsprgEmbeddedStoreStyle -x *.svn* *.DS_Store*
mv FsprgEmbeddedStoreStyle.zip FsprgEmbeddedStoreMacSDK 

# README.html
mkdir -p FsprgEmbeddedStoreMacSDK/README
cp -R -f README/* FsprgEmbeddedStoreMacSDK/README
perl ./Markdown_1.0.1/Markdown.pl --html4tags README.mdown >> ./FsprgEmbeddedStoreMacSDK/README.html

# License.txt
cp -R License.txt FsprgEmbeddedStoreMacSDK

# Package and remove temp directory
tar -zcf FsprgEmbeddedStoreMacSDK.tar.gz FsprgEmbeddedStoreMacSDK
rm -R -f FsprgEmbeddedStoreMacSDK
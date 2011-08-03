#!/bin/sh

rm -R -f FsprgEmbeddedStoreMacSDK
./build_project.sh "FsprgEmbeddedStore" "Release 10.4" "FsprgEmbeddedStoreMacSDK/MacOS 10.4"
./build_project.sh "FsprgEmbeddedStore" "Release 10.5+" "FsprgEmbeddedStoreMacSDK/MacOS 10.5+"
./build_project.sh "TestApp" "Release" "FsprgEmbeddedStoreMacSDK"
./build_project.sh "FsprgEmbeddedStore" "Source" "FsprgEmbeddedStoreMacSDK/src"
./build_project.sh "Example1" "Source" "FsprgEmbeddedStoreMacSDK/src"
./build_project.sh "Example2" "Source" "FsprgEmbeddedStoreMacSDK/src"

# FsprgEmbeddedStoreStyle.zip
zip -r FsprgEmbeddedStoreStyle FsprgEmbeddedStoreStyle -x *.DS_Store*
mv FsprgEmbeddedStoreStyle.zip FsprgEmbeddedStoreMacSDK 

# HOW_TO.html
mkdir -p FsprgEmbeddedStoreMacSDK/HOW_TO
cp -R -f HOW_TO/* FsprgEmbeddedStoreMacSDK/HOW_TO
perl ./Markdown_1.0.1/Markdown.pl --html4tags HOW_TO.mdown >> ./FsprgEmbeddedStoreMacSDK/HOW_TO.html

# RELEASE_NOTES.html
perl ./Markdown_1.0.1/Markdown.pl --html4tags RELEASE_NOTES.mdown >> ./FsprgEmbeddedStoreMacSDK/RELEASE_NOTES.html

# License.txt
cp -R License.txt FsprgEmbeddedStoreMacSDK

# Package and remove temp directory
tar -zcf FsprgEmbeddedStoreMacSDK.tar.gz FsprgEmbeddedStoreMacSDK
rm -R -f FsprgEmbeddedStoreMacSDK
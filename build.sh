#!/bin/sh

rm -R -f FsprgEmbeddedStoreSDK
./build_project.sh FsprgEmbeddedStore Release FsprgEmbeddedStoreSDK copy_src
./build_project.sh TestApp Release FsprgEmbeddedStoreSDK
./build_project.sh Example1 Release FsprgEmbeddedStoreSDK copy_src
./build_project.sh Example2 Release FsprgEmbeddedStoreSDK copy_src

cp -R ./README ./FsprgEmbeddedStoreSDK
perl ./Markdown_1.0.1/Markdown.pl --html4tags README.mdown > ./FsprgEmbeddedStoreSDK/README.html

tar -zcf FsprgEmbeddedStoreSDK.tar.gz FsprgEmbeddedStoreSDK
rm -R -f FsprgEmbeddedStoreSDK
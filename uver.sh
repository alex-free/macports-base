#!/bin/bash

base_sec=~/dev/tigerports-keys/tigerports-base-2027.sec
version=2.12.6.001

if [[ ! -e "$base_sec" ]]; then
    echo "Error: can not find $base_sec"
    exit 1
fi

sudo port install -N docbook2X docbook-xml docbook-xsl-ns autoconf automake asciidoc openssh

read -p "this will commit a $version tag and new commit to git, press any key to procceed"

echo "Using version: $1"

echo "Updating tigerports-base version in config/macports_version..."
echo -e "$version" > config/macports_version
cat config/macports_version

echo "Updating tigerports-base version in config/RELEASE_URL..."
echo -e "https://github.com/alex-free/tigerports-base/releases/tag/v$version" > config/RELEASE_URL
cat config/RELEASE_URL

echo "Building configure and manpages..."
./autogen.sh
./standard_configure.sh
make -C doc/ clean all \
    ASCIIDOC=/opt/local/bin/asciidoc \
    XSLTPROC=/opt/local/bin/xsltproc \
    DOCBOOK_XSL=/opt/local/share/xsl/docbook-xsl-nons/manpages/docbook.xsl

echo "Building release tarballs..."
rm configure~
# Delete any dupe tag (if force push is needed, this wouldn't affect macports tags)
git tag -d v$version
git push -d origin v$version
git add .
git commit -m "v$version"
git push -f 
git tag v$version
git push -f origin v$version 

echo "Building release tarballs..."
make -C vendor
make dist DISTVER=$version DISTKEY=$base_sec

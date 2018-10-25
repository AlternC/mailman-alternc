#!/bin/sh

echo "INFO: your /etc/apt/sources.list MUST contain the following line (or equivalent): "
echo "deb-src http://debian.octopuce.fr/debian stretch main contrib non-free"

set -e

sudo apt update
sudo apt build-dep mailman

apt source mailman

cd mailman-2.1.23
for patch in ../patches/*
do
    patch -p1 <$patch
done

echo "press enter to launch debuild. Please ensure debian/changelog has your email for PGP signing"
read 
debuild

echo "Please use dput to upload your package"


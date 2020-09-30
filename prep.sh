#!/bin/bash

# 
# This script will attempt to download the sources for nginx's source RPM and
# the nginx shibboleth module. It will then apply patches to create
# SPECS/nginx.spec ready for the build system. When version numbers are changed
# these spec patch will usually have to be updated/inspected manually.
#
NGX_VERSION="1.18.0-1"
NGX_SHIB_VERSION="v2.0.1"
CENTOS_RELEASE="7"
RELEASEVER="el${CENTOS_RELEASE}"
ARCH="x86_64"

rm -rf SRPMS SOURCES

SRPM=nginx-$NGX_VERSION.${RELEASEVER}.ngx.src.rpm

mkdir ./SRPMS && cd ./SRPMS && \
    curl -LO "http://nginx.org/packages/centos/${CENTOS_RELEASE}/SRPMS/${SRPM}" 
mkdir ../SOURCES && cd ../SOURCES
rpm2cpio ../SRPMS/${SRPM} | cpio -i

curl -Lo nginx-http-shibboleth-${NGX_SHIB_VERSION}.tar.gz \
    https://github.com/nginx-shib/nginx-http-shibboleth/archive/${NGX_SHIB_VERSION}.tar.gz

cd ..
chown -R mockbuild SRPMS SOURCES

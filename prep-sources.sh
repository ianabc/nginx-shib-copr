#!/bin/bash
set -e

COLOR_END='\e[0m'
COLOR_RED='\e[0;31m'

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

SRPM="nginx-${NGX_VERSION}.${RELEASEVER}.ngx.src.rpm"

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Exit msg
msg_exit() {
    printf "${COLOR_RED}@${COLOR_END}"
    printf "\n"
    printf "Exiting...\n"
    exit 1
}

# Trap
cleanup() {
    rm -rf "${DIR}/SRPMS" "${DIR}/SOURCES"
    msg_exit "Source preparation failed. Check for missing download locations."
}
trap "cleanup" ERR INT TERM

rm -rf "${DIR}/SRPMS" "${DIR}/SOURCES"

# Check rpm2cpio
[[ -z "$(which rpm2cpio)" ]] && msg_exit "rpm2cpio not installed or not in your path"

# Check cpio
[[ -z "$(which cpio)" ]] && msg_exit "cpio not installed or not in your path"

# Check cpio
[[ -z "$(which curl)" ]] && msg_exit "curl not installed or not in your path"


mkdir -p "${DIR}/SRPMS" && cd "${DIR}/SRPMS" && \
    curl -LO "http://nginx.org/packages/centos/${CENTOS_RELEASE}/SRPMS/${SRPM}" 

mkdir -p "${DIR}/SOURCES" && cd "${DIR}/SOURCES"

rpm2cpio "${DIR}/SRPMS/${SRPM}" | cpio -i

curl -Lo nginx-http-shibboleth-${NGX_SHIB_VERSION}.tar.gz \
    https://github.com/nginx-shib/nginx-http-shibboleth/archive/${NGX_SHIB_VERSION}.tar.gz

if [ "${EUID}" -eq 0 ] ; then
    cd "${DIR}"
    chown -R mockbuild "${DIR}/SRPMS" "${DIR}/SOURCES"
fi

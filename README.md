<a href="https://copr.fedorainfracloud.org/coprs/ianabc/nginx-shibboleth/package/nginx/"><img src="https://copr.fedorainfracloud.org/coprs/ianabc/nginx-shibboleth/package/nginx/status_image/last_build.png" /></a>

# Nginx + nginx-http-shibboleth

This repository contains a spec file to build nginx rpms which include the
[nginx-http-shibboleth](https://github.com/nginx-shib/nginx-http-shibboleth)
module. It is intended to be used via [copr](https://copr.fedorainfracloud.org)
which should react to tags in this repository and build new RPMS. 

## Using the packages

You can use the packages (at your own risk) by enabling the copr repository

```bash
$ yum install yum-plugin-copr
$ yum copr enable ianabc/nginx-shibboleth
$ yum --enablerepo=copr:copr.fedorainfracloud.org:ianabc:nginx-shibboleth install nginx
```

## Overview

Nginx is based on the [nginx projects
rpms](http://nginx.org/en/linux_packages.html#RHEL-CentOS), and the tagged
releases of
[nginx-http-shibboleth](http://github.com/nginx/nginx-http-shibboleth). The
`./prep-sources.sh` script downloads the sources and prepares some build
directories. The `nginx.spec` is a lightly modified version of that found in
the upstream srpm which includes the shibboleth configuration.

## Generating new Packages

When upstream makes a new release the versions numbers in `prep-sources.sh`
should be updated and a new nginx.spec created. Generally the new nginx will be
identical to upstream with the following exceptions

  1. Add `--add-module=%{bdir}/src/http/modules/shibboleth` to the `BASE_CONFIGURE_ARGS`
  1. Update `Source100` with the value of the new nginx-http-shibboleth tarball
  1. In the `%prep` section
      1. `mkdir -p %{bdir}/src/http/modules/shibboleth`
      1. `tar --strip-components=1 -C %{bdir}/src/http/modules/shibboleth -zxvf %{SOURCE100}`
  1. Update the release number, upstream uses `1%{dist}` so we generally use
     `1.x%{dist}` and increment x as needed.

When this repository is tagged (using the format  vX.Y.Z), a github workflow
creates a new release and triggers copr via a webhook. There are two steps in
the rebuild process: `make-srpm` will build an `.src.rpm` then copr will
compile that into the nginx packages.

## Manual Build

On a machine with the usual [rpm build
environment](https://wiki.centos.org/HowTos/SetupRpmBuildEnvironment) nginx is
very easy to build.
```bash
rpmbuild -bs SPECS/nginx.spec
```
Should build an SRPM or 
```bash
rpmbuild -ba SPECS/nginx.spec
```
Should build everything, the nice thing about copr is that the results are
hosted and ready for yum to consume.

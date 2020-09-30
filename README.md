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



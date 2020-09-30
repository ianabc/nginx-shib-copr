srpm:
	su -c ./prep.sh - mockbuild
	rpmbuild --define "_topdir `pwd`" -bs SPECS/nginx.spec - mockbuild
	cp SRPMS/*.src.rpm $(outdir)/ - mockbuild

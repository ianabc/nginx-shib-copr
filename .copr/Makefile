srpm:
	./prep.sh
	rpmbuild --define "_topdir `pwd`" -bs SPECS/nginx.spec
	cp SRPMS/*.src.rpm $(outdir)/

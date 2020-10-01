srpm:
	./prep-sources.sh
	echo '%dist %{nil}' > ~/.rpmmacros
	rpmbuild --define "_topdir `pwd`" -bs SPECS/nginx.spec
	cp SRPMS/nginx*ngx.src.rpm $(outdir)/

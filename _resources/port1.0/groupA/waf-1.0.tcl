# -*- coding: utf-8; mode: _tcl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- vim:fenc=utf-8:ft=tcl:et:sw=2:ts=2:sts=2

options waf.python
default waf.python {${prefix}/bin/python3.7}

depends_build-append    port:python37

configure.cmd           ${waf.python} ./waf configure
configure.args          --nocache

configure.universal_args-delete --disable-dependency-tracking

build.cmd               ${waf.python} ./waf
build.target            build

destroot.destdir        --destdir=${destroot}

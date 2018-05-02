# -*- coding: utf-8; mode: _tcl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- vim:fenc=utf-8:ft=tcl:et:sw=2:ts=2:sts=2
#
# This portgroup provides access to many missing library functions for 
# Snow Leopard (Mac OS X 10.6.8) and earlier.
# adding the header is sometimes needed, but sometimes incompatible

options snowleopard_fixes.addheader
default snowleopard_fixes.addheader no

proc add_libsnowleopardfixes {} {
    global snowleopard_fixes.addheader
    global prefix

    depends_lib-append          port:snowleopardfixes
    configure.ldflags-append   -lsnowleopardfixes

    if {${snowleopard_fixes.addheader} eq "yes"} {
        configure.cppflags-append -include ${prefix}/include/snowleopardfixes.h
    }
}

# do not force all Portfiles to switch from depends_lib to depends_lib-append
if {${os.platform} eq "darwin" && ${os.major} < 11} {
    port::register_callback add_libsnowleopardfixes
}

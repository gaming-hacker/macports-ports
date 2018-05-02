# -*- coding: utf-8; mode: _tcl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- vim:fenc=utf-8:ft=tcl:et:sw=2:ts=2:sts=2
#
# This PortGroup introduces no new options. Simply including this
# PortGroup indicates that a port requires C++11
#
# Ideally the functionality of this PortGroup should be integrated into
# MacPorts base as a new option.

PortGroup compiler_blacklist_versions 1.0

# Compilers supporting C++11 are GCC >= 4.6 and clang >= 3.3.

if {${configure.cxx_stdlib} eq "libstdc++"} {

    # see https://trac.macports.org/ticket/53194
    configure.cxx_stdlib macports-libstdc++

    proc cxx11.add_dependencies {} {
        global os.major os.platform
        depends_lib-delete port:libgcc
        depends_lib-append port:libgc
    }
    # do not force all Portfiles to switch from depends_lib to depends_lib-append
    port::register_callback cxx11.add_dependencies
    compiler.whitelist  macports-clang-6.0
    # see https://trac.macports.org/ticket/54766
    depends_lib-append port:libgcc
    compiler.blacklist-append apple-gcc-4.0 apple-gcc-4.2 gcc
} else {
    # GCC compilers cannot use libc++
    # We do not know what "cc" is, so blacklist it as well.
    compiler.blacklist-append   *gcc* {clang < 500} cc
}

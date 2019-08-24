# -*- coding: utf-8; mode: _tcl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- vim:fenc=utf-8:ft=tcl:et:sw=2:ts=2:sts=2

# This portgroup is to help prevent circular dependencies for ports that
# recent clang builds depend on, by blacklisting any clang compiler not already
# installed

# call this if an older clang version depends on the port
proc clang_dependency.extra_versions {versions} {
    global prefix
    foreach ver $versions {
        if {![file exists ${prefix}/bin/clang-mp-${ver}]} {
            compiler.blacklist-append macports-clang-${ver}
        }
    }
}

clang_dependency.extra_versions {8.0 7.0 6.0 5.0}

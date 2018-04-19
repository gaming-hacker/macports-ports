# -*- coding: utf-8; mode: _tcl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- vim:fenc=utf-8:ft=tcl:et:sw=2:ts=2:sts=2
# This file contains the livecheck defaults for PyPI.

if {${livecheck.name} eq "default"} {
    if {[exists python.rootname]} {
        livecheck.name [option python.rootname]
    } else {
        livecheck.name ${name}
    }
}
if {!$has_homepage || ${livecheck.url} eq ${homepage}} {
    livecheck.url \
            https://pypi.org/pypi/${livecheck.name}/json
}
if {${livecheck.regex} eq ""} {
    livecheck.regex {"version":"([^"]+)"[,\}]}
}
set livecheck.type "regex"

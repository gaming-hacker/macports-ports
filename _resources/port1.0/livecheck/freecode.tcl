# -*- coding: utf-8; mode: _tcl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- vim:fenc=utf-8:ft=tcl:et:sw=2:ts=2:sts=2
# This file contains the livecheck defaults for freecode.

if {${livecheck.name} eq "default"} {
    set livecheck.name ${name}
}
if {${livecheck.distname} eq "default"} {
    set livecheck.distname ${livecheck.name}
}
if {!$has_homepage || ${livecheck.url} eq ${homepage}} {
    set livecheck.url "http://freecode.com/projects/${livecheck.name}/releases.atom"
}
if {${livecheck.regex} eq ""} {
    set livecheck.regex [list "(?i)<title>[quotemeta ${livecheck.distname}] (.*)</title>"]
}
set livecheck.type "regex"

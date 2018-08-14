# -*- coding: utf-8; mode: _tcl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- vim:fenc=utf-8:ft=tcl:et:sw=2:ts=2:sts=2
# This file contains the defaults for gnome.

if {${livecheck.name} eq "default"} {
    set livecheck.name ${name}
}
if {!$has_homepage || ${livecheck.url} eq ${homepage}} {
    set livecheck.url "https://download.gnome.org/sources/${livecheck.name}/cache.json"
}
if {${livecheck.regex} eq ""} {
    set livecheck.regex {LATEST-IS-(\\d+\\.\\d*[0-9](?:\\.\\d+)*)}
}
set livecheck.type "regex"

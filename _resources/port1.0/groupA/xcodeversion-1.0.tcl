# -*- coding: utf-8; mode: _tcl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- vim:fenc=utf-8:ft=tcl:et:sw=2:ts=2:sts=2
#
# This PortGroup lets a port check that the user's Xcode is sufficiently new.
#
# Usage:
#
#   PortGroup               xcodeversion 1.0
#   minimum_xcodeversions   {darwin_major minimum_xcodeversion}
#
# where darwin_major is the major version of the underlying Darwin OS (e.g. 16
# for macOS 10.12 Sierra) and minimum_xcodeversion is the minimum version
# of Xcode the port requires (e.g. 3.1).

options minimum_xcodeversions
default minimum_xcodeversions {}
# Xcode should be used for this port
if {[info exists use_xcode]} {
    use_xcode yes
}

platform macosx {
    pre-extract {
        foreach {darwin_major minimum_xcodeversion} [join ${minimum_xcodeversions}] {
            if {${darwin_major} == ${os.major}} {
                if {![info exists xcodeversion] || $xcodeversion == "none"} {
                    ui_error "Couldn't determine your Xcode version (from '/usr/bin/xcodebuild -version')."
                    ui_error ""
                    ui_error "If you have not installed Xcode, install it now; see:"
                    ui_error "https://guide.macports.org/chunked/installing.xcode.html"
                    ui_error ""
                    return -code error "unable to find Xcode"
                }
                if {[vercmp ${xcodeversion} ${minimum_xcodeversion}] < 0} {
                    ui_error "On macOS ${macosx_version}, ${name} @${version} requires Xcode ${minimum_xcodeversion} or later but you have Xcode ${xcodeversion}."
                    ui_error "See https://guide.macports.org/chunked/installing.xcode.html for download links."
                    return -code error "incompatible Xcode version"
                }
            }
        }
    }
}

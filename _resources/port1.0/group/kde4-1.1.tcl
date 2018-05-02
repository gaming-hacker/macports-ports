# -*- coding: utf-8; mode: _tcl; c-basic-offset: 2; indent-tabs-mode: nil; tab-width: 2; truncate-lines: t -*- vim:fenc=utf-8:et:sw=2:ts=2:sts=2
#
# Usage:
# PortGroup     kde4 1.1

# Use CMake and Qt4 port groups
PortGroup               cmake 1.0
PortGroup               qt4 1.0

# Make sure to not use any already installed headers and libraries;
# these are set in CPATH and LIBRARY_PATH anyway.
configure.ldflags-delete  -L${prefix}/lib
configure.cppflags-delete -I${prefix}/include

# setup all KDE4 ports to build in a separate directory from the source:
cmake.out_of_source         yes

# Automoc added as build dependency here as most, if not all kde
# programs currently need it. The automoc port, which includes this
# PortGroup overrides depends_build, removing "port:automoc" to
# prevent a cyclic dependency
depends_build-append    port:automoc

# Phonon added as library dependency here as most, if not all KDE
# programs current need it.  The phonon port, which includes this
# PortGroup overrides depends_lib, removing "port:phonon" to prevent a
# cyclic dependency
depends_lib-append      port:phonon

# Install the kdelibs headerfiles in their own directory to prevent clashes with KF5 headers
set kde4.include_prefix KDE4
set kde4.include_dirs   ${prefix}/include/${kde4.include_prefix}
set kde4.cmake_module_dir \
                        ${prefix}/lib/cmake/${kde4.include_prefix}

set kde4.mirror         http://mirrors.mit.edu/kde/stable/

# augment the CMake module lookup path, if necessary depending on
# where Qt4 is installed.
if {${qt_cmake_module_dir} ne ${cmake_share_module_dir}} {
    set cmake_module_path ${kde4.cmake_module_dir}\;${cmake_share_module_dir}\;${qt_cmake_module_dir}
} else {
    # prepend our own (new) install location for cmake modules:
    set cmake_module_path ${kde4.cmake_module_dir}\;${cmake_share_module_dir}
}
configure.args-delete -DCMAKE_MODULE_PATH=${cmake_share_module_dir}
configure.args-append -DCMAKE_MODULE_PATH="${cmake_module_path}" \
                        -DCMAKE_PREFIX_PATH="${cmake_module_path}"


# standard configure args; virtually all KDE ports use CMake and Qt4.
configure.args-append   -DBUILD_doc=OFF \
                        -DBUILD_docs=OFF \
                        -DBUILD_SHARED_LIBS=ON \
                        -DBUNDLE_INSTALL_DIR=${applications_dir}/KDE4 \
                        -DKDE_DISTRIBUTION_TEXT=\"MacPorts\/Mac OS X\" \
                        ${qt_cmake_defines}

# explicitly define certain headers and libraries, to avoid
# conflicts with those installed into system paths by the user.
configure.args-append   -DDOCBOOKXSL_DIR=${prefix}/share/xsl/docbook-xsl-nons \
                        -DGETTEXT_INCLUDE_DIR=${prefix}/include \
                        -DGETTEXT_LIBRARY=${prefix}/lib/libgettextlib.dylib \
                        -DGIF_INCLUDE_DIR=${prefix}/include \
                        -DGIF_LIBRARY=${prefix}/lib/libgif.dylib \
                        -DJASPER_INCLUDE_DIR=${prefix}/include \
                        -DJASPER_LIBRARY=${prefix}/lib/libjasper.dylib \
                        -DJPEG_INCLUDE_DIR=${prefix}/include \
                        -DJPEG_LIBRARY=${prefix}/lib/libjpeg.dylib \
                        -DLBER_LIBRARIES=${prefix}/lib/liblber.dylib \
                        -DLDAP_INCLUDE_DIR=${prefix}/include \
                        -DLDAP_LIBRARIES=${prefix}/lib/libldap.dylib \
                        -DLIBEXSLT_INCLUDE_DIR=${prefix}/include \
                        -DLIBEXSLT_LIBRARIES=${prefix}/lib/libexslt.dylib \
                        -DLIBICALSS_LIBRARY=${prefix}/lib/libicalss.dylib \
                        -DLIBICAL_INCLUDE_DIRS=${prefix}/include \
                        -DLIBICAL_LIBRARY=${prefix}/lib/libical.dylib \
                        -DLIBINTL_INCLUDE_DIR=${prefix}/include \
                        -DLIBINTL_LIBRARY=${prefix}/lib/libintl.dylib \
                        -DLIBXML2_INCLUDE_DIR=${prefix}/include/libxml2 \
                        -DLIBXML2_LIBRARIES=${prefix}/lib/libxml2.dylib \
                        -DLIBXML2_XMLLINT_EXECUTABLE=${prefix}/bin/xmllint \
                        -DLIBXSLT_INCLUDE_DIR=${prefix}/include \
                        -DLIBXSLT_LIBRARIES=${prefix}/lib/libxslt.dylib \
                        -DOPENAL_INCLUDE_DIR=/System/Library/Frameworks/OpenAL.framework/Headers \
                        -DOPENAL_LIBRARY=/System/Library/Frameworks/OpenAL.framework \
                        -DPNG_INCLUDE_DIR=${prefix}/include \
                        -DPNG_PNG_INCLUDE_DIR=${prefix}/include \
                        -DPNG_LIBRARY=${prefix}/lib/libpng.dylib \
                        -DTIFF_INCLUDE_DIR=${prefix}/include \
                        -DTIFF_LIBRARY=${prefix}/lib/libtiff.dylib

# see https://trac.macports.org/ticket/55104
if { ${os.platform} eq "darwin" && ${os.major} >= 17 } {
    configure.cxxflags-append -D__KDE_HAVE_GCC_VISIBILITY
}


# standard variant for building documentation
variant docs description "Build documentation" {
    depends_build-append    path:bin/doxygen:doxygen
    configure.args-delete   -DBUILD_doc=OFF -DBUILD_docs=OFF
}

notes "
Don't forget that dbus needs to be started as the local\
user (not with sudo) before any KDE programs will launch.
To start it run the following command:
 launchctl load -w /Library/LaunchAgents/org.freedesktop.dbus-session.plist
"

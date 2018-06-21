#!/bin/sh
# This test needs macports to be installed to work
# start as tcl \
exec tclsh "$0" "$@"

set prefix                    [file dirname [file dirname [exec which port]]]
set os.platform               i686-darwin

# mock the commands the ruby group uses
proc name p0                  {
	global name.found
	set name.found $p0
}
proc version p0               {
	global version.found
	set version.found $p0
}
proc categories p0	      {}
proc distname p0	      {}
proc dist_subdir p0	      {}
proc depends_lib p0	      {
	global depends_lib.found
	set depends_lib.found $p0
}
proc post-extract p0	      {}
proc configure.cmd {p0 p1 p2} {}
proc configure.pre_args p0    {}
proc build.target p0	      {
	global build.target.found
	set build.target.found $p0
}
proc build.cmd {p0 p1 p2}     {}
proc pre-destroot p0	      {}
proc destroot.cmd {p0 p1 p2}  {}
proc destroot.target p0	      {}
proc destroot.destdir {}      {}
proc post-destroot p0	      {}

proc use_configure p0	      {}
proc extract.suffix p0	      {}
proc depends_lib-append p0    {}
proc extract p0		      {}
proc build p0		      {}
proc destroot p0	      {}

# directory which contains test file
set testdir [file dirname ${argv0}]

namespace eval tests {
	# Backwards compatible behaviour, assumes ruby1.8
	proc test_rubysetup_ruby18_default {} {
	}

	proc test_rubysetup_type_gem {} {
		if {[catch {ruby.setup {test_module tmod} 9.9 gem {README INSTALL}}]} {
			error "gem type port fails"
		}
	}

	proc test_rubysetup_ruby19 {} {
	}

	proc test_variables_exported_without_rubysetup_call {} {
		global prefix
		global ruby.bin ruby.rdoc ruby.gem
		global ruby.version ruby.arch ruby.lib ruby.archlib
		if {"${prefix}/bin/ruby" ne ${ruby.bin}} { error "variable ruby.bin missing" }
		if {"${prefix}/bin/rdoc" ne ${ruby.rdoc}} { error "variable ruby.rdoc missing" }
		if {"${prefix}/bin/gem" ne ${ruby.gem}} { error "variable ruby.gem missing" }
		if {"1.8" ne ${ruby.version}} { error "variable ruby.version missing" }
		if {"" eq ${ruby.arch}} { error "variable ruby.arch missing" }
		if {"${prefix}/lib/ruby/vendor_ruby/1.8" ne ${ruby.lib}} { error "variable ruby.lib missing" }
		if {"" eq ${ruby.archlib}} { error "variable ruby.archlib missing" }
	}

	# run all tests
	if {![file executable $prefix/bin/ruby]} {
		puts "WARNING: No ruby found, can't run ruby port group tests without installed ruby port; skipping."
	} else {
		foreach test [info procs test_*] {
			# evaluate port group file in global context
			# to reset global variables
			uplevel {source "${testdir}/../ruby-1.0.tcl"}
			$test
		}
	}
}

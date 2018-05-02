# -*- coding: utf-8; mode: _tcl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -\*- vim:fenc=utf-8:ft=tcl:et:sw=2:ts=2:sts=2

PortSystem	1.0
+++ doinstall.tcl	Tue Sep 14 15:58:34 2004
@@ -30,7 +30,7 @@
   } else {
     set BINDIR [file join $INSTALLROOT bin]
     set LIBDIR [file join $INSTALLROOT lib]
-    set MANDIR [file join $INSTALLROOT man man1]
+    set MANDIR [file join $INSTALLROOT share man man1]
   }
 }
 

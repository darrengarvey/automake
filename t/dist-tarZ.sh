#! /bin/sh
# Copyright (C) 2013-2015 Free Software Foundation, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Trying to use removed option 'dist-tarZ' should trigger a clear
# error message.

. test-init.sh

errmsg=".*legacy .*'compress'.* removed"

echo AUTOMAKE_OPTIONS = dist-tarZ > Makefile.am
$ACLOCAL
AUTOMAKE_fails -Wnone -Wno-error
grep "^Makefile\\.am:1:.*$errmsg" stderr

cat > configure.ac <<END
AC_INIT([$me], [1.0])
AM_INIT_AUTOMAKE([no-dist-gzip dist-tarZ])
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
END
: > Makefile.am

rm -rf autom4te*.cache
$ACLOCAL
AUTOMAKE_fails -Wnone -Wno-error
grep "^configure\\.ac:2:.*$errmsg" stderr

:

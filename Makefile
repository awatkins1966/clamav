#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END

#
# Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
#
BUILD_BITS=64
COMPILER=gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=         clamav
COMPONENT_VERSION=      0.102.3
COMPONENT_SRC=          $(COMPONENT_NAME)-$(COMPONENT_VERSION)
IPS_COMPONENT_VERSION=  $(COMPONENT_VERSION)
BUILD_VERSION=          1

COMPONENT_PROJECT_URL=  http://www.clamav.net
#COMPONENT_BUGDB=       video/ffmpeg
#COMPONENT_ANITYA_ID=    1865

COMPONENT_ARCHIVE=      clamav-$(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_URL=  http://www.clamav.net/downloads/production/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=
COMPONENT_MAKE_JOBS=    1

BUILD_STYLE=    configure

# configure does not accept many of the options set in
# configure.mk (CC=, CXX=, --bindir, --libdir, --sbindir).
#CONFIGURE_DEFAULT_DIRS set to NO since we need "--libdir=/usr/lib/amd64" set otherwise it could have been YES
CONFIGURE_DEFAULT_DIRS= no
CONFIGURE_OPTIONS += --prefix=/usr
CONFIGURE_OPTIONS += --mandir=/usr/share/man
CONFIGURE_OPTIONS += --bindir=/usr/bin
CONFIGURE_OPTIONS += --libdir=/usr/lib/amd64

# Need to add all config options by hand
CONFIGURE_OPTIONS += --with-user=defang8
CONFIGURE_OPTIONS += --with-group=nogroup
CONFIGURE_OPTIONS += --enable-readdir_r
CONFIGURE_OPTIONS += -enable-milter
#CONFIGURE_OPTIONS += --enable-strni
CONFIGURE_OPTIONS += --sysconfdir=/etc/clamav
CONFIGURE_OPTIONS += --with-dbdir=/var/clamav
CONFIGURE_OPTIONS += --datarootdir=/var/clamav
CONFIGURE_OPTIONS += --sbindir=/usr/lib/inet
#CONFIGURE_OPTIONS += --enable-shared
#CONFIGURE_OPTIONS += --strip=gstrip 
#CONFIGURE_OPTIONS += --disable-x86asm
#CONFIGURE_OPTIONS += --mandir=/usr/share/man
#CONFIGURE_OPTIONS += --bindir=/usr/bin
#CONFIGURE_OPTIONS += --libdir=/usr/lib/amd64

#COMPONENT_POST_BUILD_ACTION= \
#	(cd $(PROTO_DIR) ; $(MKDIR) -p var/spool/MIMEDefang var/clamav)

TEST_TARGET= $(NO_TESTS)
include $(WS_MAKE_RULES)/common.mk

# remove warnings that packages are missing 
IPS_PKG_NAME=         storage/clamav
REQUIRED_PACKAGES += library/security/openssl
REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += system/library/gcc/gcc-c++-runtime
REQUIRED_PACKAGES += library/json-c 
REQUIRED_PACKAGES += web/curl
REQUIRED_PACKAGES += library/ncurses
REQUIRED_PACKAGES += library/libmilter
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += library/pcre2

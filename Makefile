# New ports collection makefile for:   mosh
# Date created:                2008-07-06
# Whom:                        Katsuji ISHIKAWA <katsuji.ishikawa@gmail.com>
#
# $FreeBSD: ports/lang/mosh/Makefile,v 1.6 2009/04/30 22:54:30 miwi Exp $
#

PORTNAME=	mosh
PORTVERSION=	0.2.7
CATEGORIES=	lang
MASTER_SITES=	GOOGLE_CODE

MAINTAINER=	katsuji.ishikawa@gmail.com
COMMENT=	A Fast R6RS Scheme interpreter

LIB_DEPENDS=	gmp.10:${PORTSDIR}/math/gmp \
		onig.2:${PORTSDIR}/devel/oniguruma5

USE_GCC=	4.2+
USE_GMAKE=	yes
GNU_CONFIGURE=	yes
MAKE_JOBS_SAFE=	yes
CFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

PROJECTHOST=	mosh-scheme
MAN1=	mosh.1 mosh_config.1

INSTALL_TARGET=	install-exec install-man

.if !defined(NOPORTDATA)
PORTDATA=	*
INSTALL_TARGET+=	install-dataDATA install-nobase_dataDATA
.endif

PLIST_FILES=	bin/mosh bin/mosh_config bin/nmosh

post-patch:
	${REINPLACE_CMD} 's|mosh-$$PACKAGE_VERSION|mosh|' ${WRKSRC}/configure

.include <bsd.port.mk>

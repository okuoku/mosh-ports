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

MAINTAINER=	mjt@cltn.org
COMMENT=	A Fast R6RS Scheme interpreter

LIB_DEPENDS=	gmp.10:${PORTSDIR}/math/gmp \
		onig.2:${PORTSDIR}/devel/oniguruma5

USE_GCC=	4.2+
USE_GMAKE=	yes
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--datadir=${PREFIX}/lib
MAKE_JOBS_SAFE=	yes
CFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

PROJECTHOST=	mosh-scheme
MAN1=	mosh.1 mosh_config.1

.include <bsd.port.pre.mk>

.if ${OSVERSION} < 800000
BROKEN=	Does not build on FreeBSD 7.x
.endif

post-patch:
	${REINPLACE_CMD} 's|mosh-$$PACKAGE_VERSION|mosh|' ${WRKSRC}/configure

x-generate-plist:
	@${ECHO} bin/mosh > pkg-plist.new
	@${ECHO} bin/mosh_config >> pkg-plist.new
	@${ECHO} bin/nmosh >> pkg-plist.new
	@${FIND} ${LOCALBASE}/lib/mosh -type f | ${SORT} | ${SED} 's|${LOCALBASE}/||' >> pkg-plist.new
	@${FIND} ${LOCALBASE}/lib/mosh -type d | ${SORT} -r | ${SED} 's|${LOCALBASE}/|@dirrm |' >> pkg-plist.new

.include <bsd.port.post.mk>

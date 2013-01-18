#!/bin/sh

# Make sure to add following buildpacks to your .buildpacks file.
# Once added, push changes to persist installations.
#
# https://github.com/iphoting/heroku-buildpack-php-tyler

set -e

# "Install" perl buildpack
echo "Installing Perl buildpack"
curl -L -O https://raw.github.com/miyagawa/heroku-buildpack-perl/master/bin/compile
chmod +x ./compile
export BUILD_DIR=/app
export PATH=$PATH:$BUILD_DIR/local/bin:/usr/local/bin:/usr/bin:/bin
./compile $BUILD_DIR

# Build perl's XML::Parser 
echo "Installing XML::Parser module"
export PERL5LIB=$PERL5LIB:/app/local/lib/perl5
/app/local/bin/cpanm --local-lib=/app/local/lib/perl5/ -f -n XML::Parser

# Build intltool
echo "Installing intltool"
PREFIX=$HOME/intltool
INTLTOOL=intltool-0.50.2
INTLTOOL_PKG=$INTLTOOL.tar.gz
curl -L -O https://launchpad.net/intltool/trunk/0.50.2/+download/$INTLTOOL_PKG
tar -xzvf $INTLTOOL_PKG
export PERL5LIB=/app/local/lib/perl5/lib/perl5/x86_64-linux-gnu-thread-multi/
cd $INTLTOOL && ./configure --prefix=$PREFIX; make install
cd -
export PATH=$PATH:$PREFIX/bin

# TODO Create tarball from built binaries and upload it to S3

# Build gettext
echo "Installing gettext"
PREFIX=$HOME/gettext
GETTEXT=gettext-0.18.2
GETTEXT_PKG=$GETTEXT.tar.gz
curl -L -O http://ftp.gnu.org/pub/gnu/gettext/$GETTEXT_PKG
tar -xzvf $GETTEXT_PKG
cd $GETTEXT && ./configure --prefix=$PREFIX; make install
cd - 
export PATH=$PATH:$PREFIX/bin

# TODO Create tarball from built binaries and upload it to S3

# Build libgda
echo "Installing libgda"
PREFIX=$HOME/libgda
LIBGDA=libgda-4.2.12
LIBGDA_PKG=$LIBGDA.tar.xz
curl -L -O http://ftp.gnome.org/pub/GNOME/sources/libgda/4.2/$LIBGDA_PKG
tar -xvf $LIBGDA_PKG
cd $LIBGDA 
export PATH=$PATH:/app/intltool/bin:/app/gettext/bin
./configure --prefix=$PREFIX --without-postgres  --without-mysql --without-libsoup --without-bdb  --without-oracle  --without-ldap --without-firebird --without-mdb --without-java --without-gnome-keyring --without-ui --enable-system-sqlite --disable-crypto --disable-gtk-doc
make 
make install
cd -
export PATH=$PATH:$PREFIX/bin

# TODO Create tarball from built binaries and upload it to S3

# Build midgard2-core
echo "Installing midgard2-core"
PREFIX=$HOME/midgard2
MIDGARD2=midgard2-core-10.05.7.1
MIDGARD2_PKG=$MIDGARD2.tar.gz
curl -L -O https://github.com/downloads/midgardproject/midgard-core/$MIDGARD2_PKG
tar -xzvf $MIDGARD2_PKG
cd $MIDGARD2
export PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig:$HOME/libgda/lib/pkgconfig
./configure --prefix=$PREFIX --with-dbus-support=no
make
make install

# TODO Create tarball from built binaries and upload it to S3

# Build PHP5
curl -L http://pl1.php.net/get/php-5.3.21.tar.gz/from/this/mirror -o php-5.3.21.tar.gz
tar -xzf php-5.3.21.tar.gz
cd php-5.3.21
./configure --without-pear --prefix=/app/vendor/php 
make ; make install

# TODO Create tarball from built binaries and upload it to S3


# Build php5-midgard2 extension
echo "Installing php5-midgard2"
PHP5_MIDGARD2=midgard-php5-10.05.7
PHP5_MIDGARD2_PKG=10.05.7.tar.gz
curl -L -O https://github.com/midgardproject/midgard-php5/archive/$PHP5_MIDGARD2_PKG
tar -xvf $PHP5_MIDGARD2_PKG
cd $PHP5_MIDGARD2
/app/vendor/php/bin/phpize
export PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig:$HOME/midgard2/lib/pkgconfig
./configure --with-php-config=/app/vendor/php/bin/php-config
make
make install

# WARNING! Keep in mind while creating buildpack. There's no way to check this directory automatically.
# Installing shared extensions:     /app/vendor/php/lib/php/extensions/no-debug-non-zts-20090626/

# TODO Create tarball from built binaries and upload it to S3

# Build pcre
curl -L-O ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.32.tar.gz
tar -xzvf pcre-8.32.tar.gz
cd pcre-8.32
./configure --prefix=/app/vendor/pcre
make; make install

# TODO Create tarball from built binaries and upload it to S3

# Build lighttpd
curl -O http://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-1.4.32.tar.gz
tar -xzvf lighttpd-1.4.32.tar.gz 
cd lighttpd-1.4.32
export PATH=$PATH:/app/vendor/pcre/bin
./configure --prefix=/app/vendor/lighttpd --with-pcre=/app/vendor/pcre/bin/pcre-config
make ; make install

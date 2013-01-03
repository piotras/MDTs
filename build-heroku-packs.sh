#!/bin/sh

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




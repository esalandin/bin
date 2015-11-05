#!/bin/bash
set -a
if [ -f ~/dev-activate-bia-debug ]; then set -x; fi

DESTDIR=$HOME/server
SRCDIR_BASE=$HOME/biadev
STACKS_DIR=/tek/stacks/V6.15.3.0.1b5

activate_dir() 
    {
    local SRC=$1
    local DEST=$2
    if [ ! -d $SRC ]; then
        echo "directory $SRC does not exist, skipping" >&2
        return
    fi
    mkdir -p $DEST
    local FNAME
    local SRCF
    for FNAME in `ls $SRC`; do
            SRCF=$SRC/$FNAME
            if [ -f $SRCF -o -L $SRCF ]; then
                ln -f -s $SRCF $DEST
            elif [ -d $SRCF ]; then
                activate_dir $SRCF $DEST/$FNAME
            fi
    done
    }

for PROD in platform platform_drutils datacast irisgen; do
    for PLATFORM in x86-sunos-solaris-10 sparc-sunos-solaris-10 x64-linux-deb-6; do
        for DIR in bin64 lib64; do
            activate_dir $SRCDIR_BASE/$PROD/install/$PLATFORM/$DIR $DESTDIR/$PLATFORM/$DIR
        done
    done
    activate_dir $SRCDIR_BASE/$PROD/install/etc $DESTDIR/etc
done

for DIR in lib bin; do
#   activate_dir $STACKS_DIR/sparc-sunos-solaris-10/${DIR} $DESTDIR/sparc-sunos-solaris-10/${DIR}
    activate_dir $STACKS_DIR/sparc64-sunos-solaris-10/${DIR} $DESTDIR/sparc-sunos-solaris-10/${DIR}64
#   activate_dir $STACKS_DIR/x86-sunos-solaris-10/${DIR} $DESTDIR/x86-sunos-solaris-10/${DIR}
    activate_dir $STACKS_DIR/x86_64-sunos-solaris-10/${DIR} $DESTDIR/x86-sunos-solaris-10/${DIR}64
    activate_dir $STACKS_DIR/x64-linux-deb-6/${DIR} $DESTDIR/x64-linux-deb-6/${DIR}64
done

mkdir -p $DESTDIR/site
mkdir -p $DESTDIR/logs

ARCH=`arch-name`;
case $ARCH in
    *linux*) ARCHDIR=x64-linux-deb-6;;
    x86-sunos-solaris*) ARCHDIR=x86-sunos-solaris-10;;
    sparc*) ARCHDIR=sparc-sunos-solaris-10;;
    *) echo "unknown arch $ARCH" >&2
esac
ln -s $DESTDIR/$ARCHDIR/bin64 $DESTDIR/bin64
ln -s $DESTDIR/$ARCHDIR/lib64 $DESTDIR/lib64

echo LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DESTDIR/lib64
echo PATH=$PATH:$DESTDIR/bin64

#!/bin/bash
NDK=/home/alireza/ndk/android-ndk-r12b/
SYSROOT=$NDK/platforms/android-9/arch-arm/
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64
function build_one
{
./configure \
    --prefix=$PREFIX \
    --disable-everything \
    --enable-decoder=aac,h264,mpeg4 \
    --enable-encoder=libx264 \
    --enable-protocol=file \
    --enable-gpl \
    --enable-demuxer=aac,h264,pcm_s16le,mov \
    --enable-muxer=h264,mp4 \
    --enable-parser=aac,h264,mjpeg,mpeg4video,mpegaudio,mpegvideo \
    --enable-bsf=aac_adtstoasc \
    --enable-filter=transpose \
    --disable-avdevice \
    --disable-doc \
    --disable-symver \
    --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
    --target-os=linux \
    --arch=arch \
    --enable-cross-compile \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic $ADDI_CFLAGS" \
    --extra-ldflags="$ADDI_LDFLAGS" \
    $ADDITIONAL_CONFIGURE_FLAG 
make clean
make
make install
}
CPU=arm
PREFIX=$(pwd)/android/$CPU 
ADDI_CFLAGS="-marm"
build_one

##
## Key Pecker
##
## Script to set source of llvm, clang and other tools for MacOS
## This script sets up sources from master branch, v7.0 and v6.0
##
## Usage:
## ./get_llvm.sh # will setup master branch
## ./get_llvm.sh 7 # will setup llvm 7.0
## ./get_llvm.sh 6 # will setup llvm 6.0
## ./get_llvm.sh <any number> # will default to master branch
##

#!/bin/bash

LLVM_GIT_LOC=https://github.com/llvm-mirror/llvm.git
CLANG_GIT_LOC=https://github.com/llvm-mirror/clang.git
LLD_GIT_LOC=https://github.com/llvm-mirror/lld.git
POLLY_GIT_LOC=https://github.com/llvm-mirror/polly.git
LIBCXX_GIT_LOC=https://github.com/llvm-mirror/libcxx.git
LIBCXXABI_GIT_LOC=https://github.com/llvm-mirror/libcxxabi.git
COMPILERRT_GIT_LOC=https://github.com/llvm-mirror/compiler-rt.git
LIBCLC_GIT_LOC=https://github.com/llvm-mirror/libclc.git

CMAKE=/Applications/CMake.app/Contents/bin/cmake

BRANCH=master
VERSION=80

if [ "$1" == "6" ]
then
    BRANCH=release_60
    VERSION=60
fi

if [ "$1" == "7" ]
then
    BRANCH=release_70
    VERSION=70
fi

CLONE_SRC_DIR="llvm"$VERSION"_src"
BUILD_DIR="llvm"$VERSION"_build_osx"
INSTALL_DIR="~/llvm"$VERSION
echo $CLONE_SRC_DIR
echo $BUILD_DIR
echo $INSTALL_DIR

echo "Cloning branch: "$BRANCH" to: "$CLONE_SRC_DIR
echo "Build files are located in: "$BUILD_DIR
echo "LLVM will be installed to: "$INSTALL_DIR

echo "Continue? (y/n)"
read start_build
if [ $start_build == "y" ]
then
echo "Started cloning Clang, LLVM"

git clone $LLVM_GIT_LOC -b $BRANCH $CLONE_SRC_DIR
cd $CLONE_SRC_DIR/tools
git clone $CLANG_GIT_LOC -b $BRANCH
git clone $LLD_GIT_LOC -b $BRANCH
git clone $POLLY_GIT_LOC -b $BRANCH
cd ../projects
git clone $LIBCXX_GIT_LOC -b $BRANCH
git clone $LIBCXXABI_GIT_LOC -b $BRANCH
git clone $COMPILERRT_GIT_LOC -b $BRANCH
git clone $LIBCLC_GIT_LOC
cd ../../

mkdir $BUILD_DIR
cd $BUILD_DIR

$CMAKE ../$CLONE_SRC_DIR -DLLVM_TARGETS_TO_BUILD="X86;AMDGPU;NVPTX" -DCMAKE_OSX_ARCHITECTURES:STRING=x86_64 -DCLANG_DEFAULT_CXX_STDLIB:STRING=libc++ -DCMAKE_INSTALL_PREFIX=~/$INSTALL_DIR

fi


#!/usr/bin/env sh

LIB_ZIP_FILENAME="Linux-x86.zip"

echo Checking presence of Morpheus shared library binary
if [ ! -e libmorpheus_core.so ]; then
  echo Downloading Morpheus shared library binary
  curl --proto '=https' --tlsv1.2 -#L -o $LIB_ZIP_FILENAME \
    https://github.com/Internet-of-People/morpheus-rust/releases/latest/download/$LIB_ZIP_FILENAME
  unzip $LIB_ZIP_FILENAME
  rm $LIB_ZIP_FILENAME
fi

echo Running tests
pub run test --concurrency=1
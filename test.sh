#!/usr/bin/env sh

echo Checking presence of Morpheus shared library binary
if [ ! -e libiop_sdk_ffi_linux.so ]; then
  cp iop_sdk/0.0.17-snapshot/libiop_sdk_ffi_linux.so libiop_sdk_ffi_linux.so
fi

echo Running tests
dart test --concurrency=1
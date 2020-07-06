import 'dart:core';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';
import 'package:morpheus_sdk/crypto/disposable.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';

class PublicKey implements IDisposable {
  Pointer<Void> _ffi;
  bool _owned;

  PublicKey(this._ffi, this._owned);

  static PublicKey fromString(String str) {
    final nativeStr = Utf8.toUtf8(str);
    try {
      final pk = DartApi.native
          .mpublic_key_fromstring(nativeStr)
          .extract((res) => res.asPointer());
      return PublicKey(pk, true);
    } finally {
      free(nativeStr);
    }
  }

  bool validateId(KeyId keyId) {
    return DartApi.native.mpublic_key_validate_id(_ffi, keyId._ffi) != 0;
  }

  // TODO
  /*bool verify() {
    return DartApi.native.mpublic_key_verify(_ffi, data, sig) != 0;
  }*/

  @override
  String toString() {
    return DartApi.native.mpublic_key_tostring(_ffi).intoString();
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_mpublic_key(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class KeyId implements IDisposable {
  Pointer<Void> _ffi;
  bool _owned;

  KeyId(this._ffi, this._owned);

  static KeyId fromString(String str) {
    final nativeStr = Utf8.toUtf8(str);
    try {
      final key = DartApi.native
          .mkeyid_fromstring(nativeStr)
          .extract((res) => res.asPointer());
      return KeyId(key, true);
    } finally {
      free(nativeStr);
    }
  }

  @override
  String toString() {
    return DartApi.native.mkeyid_tostring(_ffi).intoString();
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_mkeyid(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

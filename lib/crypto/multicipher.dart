import 'dart:core';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/crypto/secp.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';
import 'package:morpheus_sdk/crypto/disposable.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';

class PublicKey implements IDisposable {
  Pointer<Void> _ffi;
  bool _owned;

  PublicKey(this._ffi, this._owned);

  /* TODO
  static String get prefix {
    DartApi.native.mpublic_key_prefix().intoString();
  }
  */

  static PublicKey fromSecp(SecpPublicKey secp_pk) {
    final pk = DartApi.native.mpublic_key_fromsecp(secp_pk.ffi);
    return PublicKey(pk, true);
  }

  static PublicKey fromBytes(ByteData data) {
    final slice = ByteSlice.fromBytes(data);
    try {
      final pk = DartApi.native
          .mpublic_key_frombytes(slice.addressOf)
          .extract((res) => res.asPointer());
      return PublicKey(pk, true);
    } finally {
      slice.dispose();
    }
  }

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

  ByteData toBytes() {
    final nativeSlice = DartApi.native.mpublic_key_tobytes(_ffi);
    final slice = ByteSlice(nativeSlice.ref);
    try {
      return slice.toBytes();
    } finally {
      slice.dispose();
    }
  }

  @override
  String toString() {
    return DartApi.native.mpublic_key_tostring(_ffi).intoString();
  }

  KeyId keyId() {
    final keyid_ffi = DartApi.native.mpublic_key_keyid(_ffi);
    return KeyId(keyid_ffi, true);
  }

  bool validateId(KeyId keyId) {
    return DartApi.native.mpublic_key_validate_id(_ffi, keyId._ffi) != 0;
  }

  /* TODO
  bool verify() {
    return DartApi.native.mpublic_key_verify(_ffi, data, sig) != 0;
  }
  */

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

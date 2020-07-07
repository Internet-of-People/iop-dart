import 'dart:core';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/crypto/secp.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';
import 'package:morpheus_sdk/crypto/disposable.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';

class PrivateKey implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  PrivateKey(this._ffi, this._owned);

  /*
  static PrivateKey fromSecp(SecpPrivateKey secpSk) {
    final sk = DartApi.native.mprivate_key_from_secp(secpSk.ffi);
    return PrivateKey(sk, true);
  }
  */

  PublicKey publicKey() {
    final ffiPk = DartApi.native.mprivate_key_public_key(_ffi);
    return PublicKey(ffiPk, true);
  }

  Signature sign(ByteData data) {
    final nativeData = ByteSlice.fromBytes(data);
    try {
      final ffiSig =
          DartApi.native.mprivate_key_sign(_ffi, nativeData.addressOf);
      return Signature(ffiSig, true);
    } finally {
      nativeData.dispose();
    }
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_mprivate_key(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class PublicKey implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  PublicKey(this._ffi, this._owned);

  static String prefix() {
    return DartApi.native.mpublic_key_prefix().intoString();
  }

  static PublicKey fromSecp(SecpPublicKey secp_pk) {
    final pk = DartApi.native.mpublic_key_from_secp(secp_pk.ffi);
    return PublicKey(pk, true);
  }

  static PublicKey fromBytes(ByteData data) {
    final nativeData = ByteSlice.fromBytes(data);
    try {
      final pk = DartApi.native
          .mpublic_key_from_bytes(nativeData.addressOf)
          .extract((res) => res.asPointer<Void>());
      return PublicKey(pk, true);
    } finally {
      nativeData.dispose();
    }
  }

  static PublicKey fromString(String str) {
    final nativeStr = Utf8.toUtf8(str);
    try {
      final pk = DartApi.native
          .mpublic_key_from_string(nativeStr)
          .extract((res) => res.asPointer<Void>());
      return PublicKey(pk, true);
    } finally {
      free(nativeStr);
    }
  }

  ByteData toBytes() {
    final nativeSlice = DartApi.native.mpublic_key_to_bytes(_ffi);
    final slice = ByteSlice(nativeSlice.ref);
    try {
      return slice.toBytes();
    } finally {
      slice.dispose();
    }
  }

  @override
  String toString() {
    return DartApi.native.mpublic_key_to_string(_ffi).intoString();
  }

  KeyId keyId() {
    final keyid_ffi = DartApi.native.mpublic_key_key_id(_ffi);
    return KeyId(keyid_ffi, true);
  }

  bool validateId(KeyId keyId) {
    return DartApi.native.mpublic_key_validate_id(_ffi, keyId._ffi) != 0;
  }

  bool verify(ByteData data, Signature sig) {
    final nativeData = ByteSlice.fromBytes(data);
    try {
      return DartApi.native
              .mpublic_key_verify(_ffi, nativeData.addressOf, sig._ffi) !=
          0;
    } finally {
      nativeData.dispose();
    }
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

class KeyId implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  KeyId(this._ffi, this._owned);

  static String prefix() {
    return DartApi.native.mkeyid_prefix().intoString();
  }

  /*
  static KeyId fromSecp(SecpKeyId secp_id) {
    final id = DartApi.native.mkeyid_from_secp(secp_id.ffi);
    return KeyId(id, true);
  }
  */

  static KeyId fromBytes(ByteData data) {
    final nativeData = ByteSlice.fromBytes(data);
    try {
      final id = DartApi.native
          .mkeyid_from_bytes(nativeData.addressOf)
          .extract((res) => res.asPointer<Void>());
      return KeyId(id, true);
    } finally {
      nativeData.dispose();
    }
  }

  static KeyId fromString(String str) {
    final nativeStr = Utf8.toUtf8(str);
    try {
      final key = DartApi.native
          .mkeyid_from_string(nativeStr)
          .extract((res) => res.asPointer<Void>());
      return KeyId(key, true);
    } finally {
      free(nativeStr);
    }
  }

  ByteData toBytes() {
    final nativeSlice = DartApi.native.mkeyid_to_bytes(_ffi);
    final slice = ByteSlice(nativeSlice.ref);
    try {
      return slice.toBytes();
    } finally {
      slice.dispose();
    }
  }

  @override
  String toString() {
    return DartApi.native.mkeyid_to_string(_ffi).intoString();
  }

  // Only for MorpheusPublic implementation
  Pointer<Void> get ffi => _ffi;

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_mkeyid(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class Signature implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  Signature(this._ffi, this._owned);

  static String prefix() {
    return DartApi.native.msignature_prefix().intoString();
  }

  /*
  static Signature fromSecp(SecpSignature secp_sig) {
    final sig = DartApi.native.msignature_from_secp(secp_sig.ffi);
    return Signature(sig, true);
  }
  */

  static Signature fromBytes(ByteData data) {
    final nativeData = ByteSlice.fromBytes(data);
    try {
      final sig = DartApi.native
          .msignature_from_bytes(nativeData.addressOf)
          .extract((res) => res.asPointer<Void>());
      return Signature(sig, true);
    } finally {
      nativeData.dispose();
    }
  }

  static Signature fromString(String str) {
    final nativeStr = Utf8.toUtf8(str);
    try {
      final sig = DartApi.native
          .msignature_from_string(nativeStr)
          .extract((res) => res.asPointer<Void>());
      return Signature(sig, true);
    } finally {
      free(nativeStr);
    }
  }

  ByteData toBytes() {
    final nativeSlice = DartApi.native.msignature_to_bytes(_ffi);
    final slice = ByteSlice(nativeSlice.ref);
    try {
      return slice.toBytes();
    } finally {
      slice.dispose();
    }
  }

  @override
  String toString() {
    return DartApi.native.msignature_to_string(_ffi).intoString();
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_msignature(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

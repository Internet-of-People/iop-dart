import 'dart:core';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';

class KeyId implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  KeyId(this._ffi, this._owned);

  static String prefix() {
    return DartApi.native.keyId.prefix().intoString();
  }

  static KeyId fromSecp(SecpKeyId secp_id) {
    final id = DartApi.native.keyId.fromSecp(secp_id.ffi);
    return KeyId(id, true);
  }

  static KeyId fromBytes(ByteData data) {
    final nativeData = ByteSlice.fromBytes(data);
    try {
      final id = DartApi.native.keyId
          .fromBytes(nativeData.addressOf)
          .extract((res) => res.asPointer<Void>());
      return KeyId(id, true);
    } finally {
      nativeData.dispose();
    }
  }

  static KeyId fromString(String str) {
    final nativeStr = Utf8.toUtf8(str);
    try {
      final key = DartApi.native.keyId
          .fromString(nativeStr)
          .extract((res) => res.asPointer<Void>());
      return KeyId(key, true);
    } finally {
      free(nativeStr);
    }
  }

  ByteData toBytes() {
    final nativeSlice = DartApi.native.keyId.toBytes(_ffi);
    final slice = ByteSlice(nativeSlice.ref);
    try {
      return slice.toBytes();
    } finally {
      slice.dispose();
    }
  }

  @override
  String toString() {
    return DartApi.native.keyId.to_String(_ffi).intoString();
  }

  // Only for MorpheusPublic implementation
  Pointer<Void> get ffi => _ffi;

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.keyId.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class PrivateKey implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  PrivateKey(this._ffi, this._owned);

  // Only for JwtBuilder
  Pointer<Void> get ffi => _ffi;

  static PrivateKey fromSecp(SecpPrivateKey secpSk) {
    final sk = DartApi.native.privateKey.fromSecp(secpSk.ffi);
    return PrivateKey(sk, true);
  }

  PublicKey publicKey() {
    final ffiPk = DartApi.native.privateKey.publicKey(_ffi);
    return PublicKey(ffiPk, true);
  }

  Signature sign(ByteData data) {
    final nativeData = ByteSlice.fromBytes(data);
    try {
      final ffiSig = DartApi.native.privateKey.sign(_ffi, nativeData.addressOf);
      return Signature(ffiSig, true);
    } finally {
      nativeData.dispose();
    }
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.privateKey.delete(_ffi);
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
    return DartApi.native.publicKey.prefix().intoString();
  }

  static PublicKey fromSecp(SecpPublicKey secp_pk) {
    final pk = DartApi.native.publicKey.fromSecp(secp_pk.ffi);
    return PublicKey(pk, true);
  }

  static PublicKey fromBytes(ByteData data) {
    final nativeData = ByteSlice.fromBytes(data);
    try {
      final pk = DartApi.native.publicKey
          .fromBytes(nativeData.addressOf)
          .extract((res) => res.asPointer<Void>());
      return PublicKey(pk, true);
    } finally {
      nativeData.dispose();
    }
  }

  static PublicKey fromString(String str) {
    final nativeStr = Utf8.toUtf8(str);
    try {
      final pk = DartApi.native.publicKey
          .fromString(nativeStr)
          .extract((res) => res.asPointer<Void>());
      return PublicKey(pk, true);
    } finally {
      free(nativeStr);
    }
  }

  ByteData toBytes() {
    final nativeSlice = DartApi.native.publicKey.toBytes(_ffi);
    final slice = ByteSlice(nativeSlice.ref);
    try {
      return slice.toBytes();
    } finally {
      slice.dispose();
    }
  }

  @override
  String toString() {
    return DartApi.native.publicKey.to_String(_ffi).intoString();
  }

  KeyId keyId() {
    final keyid_ffi = DartApi.native.publicKey.keyId(_ffi);
    return KeyId(keyid_ffi, true);
  }

  bool validateId(KeyId keyId) {
    return DartApi.native.publicKey.validateId(_ffi, keyId._ffi) != 0;
  }

  bool verify(ByteData data, Signature sig) {
    final nativeData = ByteSlice.fromBytes(data);
    try {
      return DartApi.native.publicKey
              .verify(_ffi, nativeData.addressOf, sig._ffi) !=
          0;
    } finally {
      nativeData.dispose();
    }
  }

  // Only for MorpheusPrivate implementation
  Pointer<Void> get ffi => _ffi;

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.publicKey.delete(_ffi);
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
    return DartApi.native.signature.prefix().intoString();
  }

  static Signature fromSecp(SecpSignature secp_sig) {
    final sig = DartApi.native.signature.fromSecp(secp_sig.ffi);
    return Signature(sig, true);
  }

  static Signature fromBytes(ByteData data) {
    final nativeData = ByteSlice.fromBytes(data);
    try {
      final sig = DartApi.native.signature
          .fromBytes(nativeData.addressOf)
          .extract((res) => res.asPointer<Void>());
      return Signature(sig, true);
    } finally {
      nativeData.dispose();
    }
  }

  static Signature fromString(String str) {
    final nativeStr = Utf8.toUtf8(str);
    try {
      final sig = DartApi.native.signature
          .fromString(nativeStr)
          .extract((res) => res.asPointer<Void>());
      return Signature(sig, true);
    } finally {
      free(nativeStr);
    }
  }

  ByteData toBytes() {
    final nativeSlice = DartApi.native.signature.toBytes(_ffi);
    final slice = ByteSlice(nativeSlice.ref);
    try {
      return slice.toBytes();
    } finally {
      slice.dispose();
    }
  }

  @override
  String toString() {
    return DartApi.native.signature.to_String(_ffi).intoString();
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.signature.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

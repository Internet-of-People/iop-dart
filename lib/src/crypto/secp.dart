import 'dart:core';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';
import 'package:iop_sdk/layer1.dart';

class SecpKeyId implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  SecpKeyId(this._ffi, this._owned);

  // Only for fromSecp implementations
  Pointer<Void> get ffi => _ffi;

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.secpKeyId.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class SecpPrivateKey implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  SecpPrivateKey(this._ffi, this._owned);

  static SecpPrivateKey fromArkPassphrase(String passphrase) {
    final nativePassphrase = passphrase.toNativeUtf8();
    try {
      final ffiSk = DartApi.native.secpPrivateKey
          .fromArkPassphrase(nativePassphrase)
          .extract((resp) => resp.asPointer<Void>());
      return SecpPrivateKey(ffiSk, true);
    } finally {
      calloc.free(nativePassphrase);
    }
  }

  String toWif(String network) {
    final nativeNetwork = network.toNativeUtf8();
    try {
      return DartApi.native.secpPrivateKey
          .toWif(_ffi, nativeNetwork)
          .intoString();
    } finally {
      calloc.free(nativeNetwork);
    }
  }

  SecpPublicKey publicKey() {
    final ffiPk = DartApi.native.secpPrivateKey.publicKey(_ffi);
    return SecpPublicKey(ffiPk, true);
  }

  SecpSignature signEcdsa(ByteData data) {
    final nativeData = ByteSlice.fromBytes(data);
    try {
      final ffiSig =
          DartApi.native.secpPrivateKey.signEcdsa(_ffi, nativeData.addressOf);
      return SecpSignature(ffiSig, true);
    } finally {
      nativeData.dispose();
    }
  }

  SignedHydraTransaction signHydraTransaction(String txJson) {
    final nativeTx = txJson.toNativeUtf8();
    try {
      final signedTx = DartApi.native.secpPrivateKey
          .signHydraTx(_ffi, nativeTx)
          .extract((resp) => resp.asString);
      return SignedHydraTransaction(signedTx);
    } finally {
      calloc.free(nativeTx);
    }
  }

  // Only for fromSecp implementations
  Pointer<Void> get ffi => _ffi;

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.secpPrivateKey.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class SecpPublicKey implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  SecpPublicKey(this._ffi, this._owned);

  static SecpPublicKey fromString(String str) {
    final nativeStr = str.toNativeUtf8();
    try {
      final ffi = DartApi.native.secpPublicKey
          .fromString(nativeStr)
          .extract((resp) => resp.asPointer<Void>());
      return SecpPublicKey(ffi, true);
    } finally {
      calloc.free(nativeStr);
    }
  }

  @override
  String toString() {
    return DartApi.native.secpPublicKey
        .to_String(_ffi)
        .extract((res) => res.asString);
  }

  SecpKeyId keyId() {
    final ffiId = DartApi.native.secpPublicKey.keyId(_ffi);
    return SecpKeyId(ffiId, true);
  }

  SecpKeyId arkKeyId() {
    final ffiId = DartApi.native.secpPublicKey.arkKeyId(_ffi);
    return SecpKeyId(ffiId, true);
  }

  bool validateId(SecpKeyId id) {
    return DartApi.native.secpPublicKey.validateId(_ffi, id.ffi) != 0;
  }

  bool validateArkId(SecpKeyId id) {
    return DartApi.native.secpPublicKey.validateArkId(_ffi, id.ffi) != 0;
  }

  bool validateEcdsa(ByteData data, SecpSignature sig) {
    final nativeData = ByteSlice.fromBytes(data);
    try {
      return DartApi.native.secpPublicKey
              .validateEcdsa(_ffi, nativeData.addressOf, sig.ffi) !=
          0;
    } finally {
      nativeData.dispose();
    }
  }

  // Only for fromSecp and transaction builder implementations
  Pointer<Void> get ffi => _ffi;

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.secpPublicKey.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class SecpSignature implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  SecpSignature(this._ffi, this._owned);

  // Only for fromSecp implementations
  Pointer<Void> get ffi => _ffi;

  static SecpSignature fromDer(ByteData data) {
    final nativeData = ByteSlice.fromBytes(data);
    try {
      final ffiSig = DartApi.native.secpSignature
          .fromDer(nativeData.addressOf)
          .extract((resp) => resp.asPointer<Void>());
      return SecpSignature(ffiSig, true);
    } finally {
      nativeData.dispose();
    }
  }

  ByteData toDer() {
    final nativeData = DartApi.native.secpSignature.toDer(_ffi);
    final slice = ByteSlice(nativeData);
    try {
      return slice.toBytes();
    } finally {
      slice.dispose();
    }
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.secpSignature.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

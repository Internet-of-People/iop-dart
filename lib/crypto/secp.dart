import 'dart:core';
import 'dart:ffi';
import 'package:morpheus_sdk/crypto/disposable.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';

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

  @override
  String toString() {
    return DartApi.native.secpPublicKey
        .to_String(_ffi)
        .extract((res) => res.asString);
  }

  // Only for fromSecp implementations
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

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.secpSignature.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

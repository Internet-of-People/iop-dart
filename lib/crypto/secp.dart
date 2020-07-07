import 'dart:core';
import 'dart:ffi';
import 'package:morpheus_sdk/crypto/disposable.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';

class SecpPublicKey implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  SecpPublicKey(this._ffi, this._owned);

  @override
  String toString() {
    return DartApi.native
        .secp_public_key_tostring(_ffi)
        .extract((res) => res.asString);
  }

  // Only for fromSecp implementations
  Pointer<Void> get ffi => _ffi;

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_secp_public_key(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

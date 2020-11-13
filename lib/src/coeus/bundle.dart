import 'dart:ffi';

import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/coeus/operation.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';


class NoncedBundleBuilder implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  NoncedBundleBuilder(this._ffi, this._owned);

  factory NoncedBundleBuilder.create() =>
      NoncedBundleBuilder(DartApi.native.coeusNoncedBundleBuilder.create(), true);

  void add(UserOperation userOperation) {
    DartApi.native.coeusNoncedBundleBuilder
        .add(_ffi, userOperation.ffi)
        .extract((res) => res.asVoid);
  }

  NoncedBundle build(int nonce) {
    final policies = DartApi.native.coeusNoncedBundleBuilder
        .build(_ffi, nonce)
        .extract((res) => res.asPointer<Void>());
    return NoncedBundle(policies, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.coeusNoncedBundleBuilder.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}


class NoncedBundle implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  NoncedBundle(this._ffi, this._owned);

  SignedBundle sign(PrivateKey privateKey) {
    final signed = DartApi.native.coeusNoncedBundle
        .sign(_ffi, privateKey.ffi)
        .extract((res) => res.asPointer<Void>());
    return SignedBundle(signed, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.coeusNoncedBundle.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}


class SignedBundle implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  Pointer<Void> get ffi => _ffi;

  SignedBundle(this._ffi, this._owned);

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.coeusSignedBundle.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}
import 'dart:core';
import 'dart:ffi';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';
import 'package:iop_sdk/src/morpheus/operation_builder.dart';


class MorpheusSignedOperation implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  // NOTE used by MorpheusTxBuilder
  Pointer<Void> get ffi => _ffi;

  MorpheusSignedOperation(this._ffi, this._owned);

  @override
  String toString() {
    return DartApi.native.morpheusSignedOperation.to_String(_ffi)
        .extract((res) => res.asString);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.morpheusSignedOperation.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}


class MorpheusOperationSigner implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  MorpheusOperationSigner(this._ffi, this._owned);

  factory MorpheusOperationSigner.create() {
    final signer = DartApi.native.morpheusOperationSigner.create();
    return MorpheusOperationSigner(signer, true);
  }

  MorpheusOperationSigner add(MorpheusOperation operation) {
    DartApi.native.morpheusOperationSigner.add(_ffi, operation.ffi);
    return this;
  }

  MorpheusSignedOperation signWithKey(PrivateKey privateKey) {
    final signed = DartApi.native.morpheusOperationSigner
        .sign(_ffi, privateKey.ffi)
        .extract((res) => res.asPointer<Void>());
    return MorpheusSignedOperation(signed, true);
  }

  MorpheusSignedOperation sign(MorpheusPrivate morpheusPrivate, KeyId keyId) {
    final publicKey = morpheusPrivate.public.keyById(keyId);
    final privateKey = morpheusPrivate.keyByPk(publicKey).privateKey();
    return signWithKey(privateKey);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.morpheusOperationSigner.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

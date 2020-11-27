import 'dart:core';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';


class MorpheusOperation implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  // NOTE needed in MorpheusOperationSigner
  Pointer<Void> get ffi => _ffi;

  MorpheusOperation(this._ffi, this._owned);

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.morpheusOperation.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class MorpheusOperationBuilder implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  MorpheusOperationBuilder(this._ffi, this._owned);

  factory MorpheusOperationBuilder.create(Did did, String lastTxId) {
    final nativeTxId = lastTxId != null ? Utf8.toUtf8(lastTxId) : nullptr;
    try {
      final builder = DartApi.native.morpheusOperationBuilder
          .create(did.ffi, nativeTxId)
          .extract((res) => res.asPointer<Void>());
      return MorpheusOperationBuilder(builder, true);
    } finally {
      if (nativeTxId != nullptr) { free(nativeTxId); }
    }
  }

  MorpheusOperation addKey(String authentication, int blockHeight) {
    final nativeAuth = Utf8.toUtf8(authentication);
    try {
      final op = DartApi.native.morpheusOperationBuilder
          .addKey(_ffi, nativeAuth, blockHeight)
          .extract((res) => res.asPointer<Void>());
      return MorpheusOperation(op, true);
    } finally {
      free(nativeAuth);
    }
  }

  MorpheusOperation revokeKey(String authentication) {
    final nativeAuth = Utf8.toUtf8(authentication);
    try {
      final op = DartApi.native.morpheusOperationBuilder
          .revokeKey(_ffi, nativeAuth)
          .extract((res) => res.asPointer<Void>());
      return MorpheusOperation(op, true);
    } finally {
      free(nativeAuth);
    }
  }

  MorpheusOperation addRight(String authentication, String right) {
    final nativeAuth = Utf8.toUtf8(authentication);
    final nativeRight = Utf8.toUtf8(right);
    try {
      final op = DartApi.native.morpheusOperationBuilder
          .addRight(_ffi, nativeAuth, nativeRight)
          .extract((res) => res.asPointer<Void>());
      return MorpheusOperation(op, true);
    } finally {
      free(nativeRight);
      free(nativeAuth);
    }
  }

  MorpheusOperation revokeRight(String authentication, String right) {
    final nativeAuth = Utf8.toUtf8(authentication);
    final nativeRight = Utf8.toUtf8(right);
    try {
      final op = DartApi.native.morpheusOperationBuilder
          .revokeRight(_ffi, nativeAuth, nativeRight)
          .extract((res) => res.asPointer<Void>());
      return MorpheusOperation(op, true);
    } finally {
      free(nativeRight);
      free(nativeAuth);
    }
  }

  MorpheusOperation tombstoneDid() {
    final op = DartApi.native.morpheusOperationBuilder.tombstoneDid(_ffi);
    return MorpheusOperation(op, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.morpheusOperationBuilder.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

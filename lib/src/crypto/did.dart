import 'dart:core';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

class Did implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  // NOTE Needed in MorpheusOperationBuilder
  Pointer<Void> get ffi => _ffi;

  Did(this._ffi, this._owned);

  static String prefix() {
    return DartApi.native.did.prefix().intoString();
  }

  static Did fromString(String str) {
    final nativeStr = Utf8.toUtf8(str);
    try {
      final did = DartApi.native.did
          .fromString(nativeStr)
          .extract((res) => res.asPointer<Void>());
      return Did(did, true);
    } finally {
      free(nativeStr);
    }
  }

  static Did fromKeyId(KeyId id) {
    final did = DartApi.native.did.fromKeyId(id.ffi);
    return Did(did, true);
  }

  @override
  String toString() {
    return DartApi.native.did.to_String(_ffi).intoString();
  }

  KeyId defaultKeyId() {
    final id = DartApi.native.did.defaultKeyId(_ffi);
    return KeyId(id, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.did.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

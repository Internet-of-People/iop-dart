import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

class Vault implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  Vault._(this._ffi, this._owned);

  static Vault create(
    String seed,
    String word25,
    String unlockPassword, {
    String languageCode = 'en',
  }) {
    final nativeLang = languageCode.toNativeUtf8();
    final nativeSeed = seed.toNativeUtf8();
    final nativeW25 = word25.toNativeUtf8();
    final nativePwd = unlockPassword.toNativeUtf8();
    try {
      final ffiVault = DartApi.native.vault
          .create(nativeLang, nativeSeed, nativeW25, nativePwd)
          .extract((res) => res.asPointer<Void>());
      return Vault._(ffiVault, true);
    } finally {
      calloc.free(nativePwd);
      calloc.free(nativeW25);
      calloc.free(nativeSeed);
      calloc.free(nativeLang);
    }
  }

  static Vault load(String vaultJson) {
    final nativeJson = vaultJson.toNativeUtf8();
    try {
      final ffiVault = DartApi.native.vault
          .load(nativeJson)
          .extract((res) => res.asPointer<Void>());
      return Vault._(ffiVault, true);
    } finally {
      calloc.free(nativeJson);
    }
  }

  // Only for MorpheusPlugin and HydraPlugin implementations
  Pointer<Void> get ffi => _ffi;

  bool get dirty {
    return DartApi.native.vault.dirty_get(_ffi).extract((res) => res.asBool());
  }

  String save() {
    return DartApi.native.vault.save(_ffi).extract((res) => res.asString);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.vault.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

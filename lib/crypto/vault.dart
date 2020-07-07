import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/crypto/disposable.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';

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
    final nativeLang = Utf8.toUtf8(languageCode);
    final nativeSeed = Utf8.toUtf8(seed);
    final nativeW25 = Utf8.toUtf8(word25);
    final nativePwd = Utf8.toUtf8(unlockPassword);
    try {
      final ffiVault = DartApi.native
          .vault_create(nativeLang, nativeSeed, nativeW25, nativePwd)
          .extract((res) => res.asPointer<Void>());
      return Vault._(ffiVault, true);
    } finally {
      free(nativePwd);
      free(nativeW25);
      free(nativeSeed);
      free(nativeLang);
    }
  }

  static Vault load(String vaultJson) {
    final nativeJson = Utf8.toUtf8(vaultJson);
    try {
      final ffiVault = DartApi.native
          .vault_load(nativeJson)
          .extract((res) => res.asPointer<Void>());
      return Vault._(ffiVault, true);
    } finally {
      free(nativeJson);
    }
  }

  // Only for MorpheusPlugin and HydraPlugin implementations
  Pointer<Void> get ffi => _ffi;

  bool get dirty {
    return DartApi.native.vault_dirty_get(_ffi).extract((res) => res.asBool());
  }

  String save() {
    return DartApi.native.vault_save(_ffi).extract((res) => res.asString);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_vault(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

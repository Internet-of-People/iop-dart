import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/crypto/disposable.dart';
import 'package:morpheus_sdk/crypto/multicipher.dart';
import 'package:morpheus_sdk/crypto/vault.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';

class MorpheusPublicKind implements IDisposable {
  Pointer<Void> _ffi;
  bool _owned;

  MorpheusPublicKind._(this._ffi, this._owned);

  int get length {
    return DartApi.native
        .morpheus_public_kind_len(_ffi)
        .extract((res) => res.asUint64());
  }

  bool get isEmpty {
    return DartApi.native
        .morpheus_public_kind_is_empty(_ffi)
        .extract((res) => res.asBool());
  }

  PublicKey key(int idx) {
    final pk = DartApi.native
        .morpheus_public_kind_key(_ffi, idx)
        .extract((res) => res.asPointer());
    return PublicKey(pk, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_morpheus_public_kind(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class MorpheusPublic implements IDisposable {
  Pointer<Void> _ffi;
  bool _owned;

  MorpheusPublic._(this._ffi, this._owned);

  MorpheusPublicKind personas() {
    final kind = DartApi.native
        .morpheus_public_personas(_ffi)
        .extract((res) => res.asPointer());
    return MorpheusPublicKind._(kind, true);
  }

  PublicKey keyById(KeyId keyId) {
    final pk = DartApi.native
        .morpheus_public_personas(_ffi)
        .extract((res) => res.asPointer());
    return PublicKey(pk, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_morpheus_public(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class MorpheusPrivate implements IDisposable {
  Pointer<Void> _ffi;
  bool _owned;

  MorpheusPrivate._(this._ffi, this._owned);

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_morpheus_private(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class MorpheusPlugin implements IDisposable {
  static void rewind(Vault vault, String unlockPassword) {
    final nativePwd = Utf8.toUtf8(unlockPassword);
    try {
      return DartApi.native
          .morpheus_plugin_rewind(vault.ffi, nativePwd)
          .extract((res) => res.asVoid);
    } finally {
      free(nativePwd);
    }
  }

  static MorpheusPlugin get(Vault vault) {
    final plugin = DartApi.native
        .morpheus_plugin_get(vault.ffi)
        .extract((res) => res.asPointer());
    return MorpheusPlugin._(plugin, true);
  }

  Pointer<Void> _ffi;
  bool _owned;

  MorpheusPlugin._(this._ffi, this._owned);

  MorpheusPrivate private(String unlockPassword) {
    final nativePwd = Utf8.toUtf8(unlockPassword);
    try {
      final private = DartApi.native
          .morpheus_plugin_private(_ffi, nativePwd)
          .extract((res) => res.asPointer());
      return MorpheusPrivate._(private, true);
    } finally {
      free(nativePwd);
    }
  }

  MorpheusPublic public() {
    final public = DartApi.native
        .morpheus_plugin_public(_ffi)
        .extract((res) => res.asPointer());
    return MorpheusPublic._(public, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_morpheus_plugin(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

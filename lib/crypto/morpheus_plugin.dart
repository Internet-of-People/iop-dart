import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/crypto/did.dart';
import 'package:morpheus_sdk/crypto/disposable.dart';
import 'package:morpheus_sdk/crypto/multicipher.dart';
import 'package:morpheus_sdk/crypto/vault.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';

class MorpheusPublicKey implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  MorpheusPublicKey._(this._ffi, this._owned);

  String get path {
    return DartApi.native.morpheusPublicKey.pathGet(_ffi).intoString();
  }

  String get kind {
    return DartApi.native.morpheusPublicKey.kindGet(_ffi).intoString();
  }

  int get idx {
    return DartApi.native.morpheusPublicKey.idxGet(_ffi);
  }

  PublicKey publicKey() {
    final ffiPk = DartApi.native.morpheusPublicKey.publicKey(_ffi);
    return PublicKey(ffiPk, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.morpheusPublicKey.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class MorpheusPublicKind implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  MorpheusPublicKind._(this._ffi, this._owned);

  int get length {
    return DartApi.native.morpheusPublicKind
        .lenGet(_ffi)
        .extract((res) => res.asUint64());
  }

  bool get isEmpty {
    return DartApi.native.morpheusPublicKind
        .isEmptyGet(_ffi)
        .extract((res) => res.asBool());
  }

  PublicKey key(int idx) {
    final pk = DartApi.native.morpheusPublicKind
        .key(_ffi, idx)
        .extract((res) => res.asPointer<Void>());
    return PublicKey(pk, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.morpheusPublicKind.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class MorpheusPublic implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  MorpheusPublic._(this._ffi, this._owned);

  MorpheusPublicKind get personas {
    final kind = DartApi.native.morpheusPublic
        .personasGet(_ffi)
        .extract((res) => res.asPointer<Void>());
    return MorpheusPublicKind._(kind, true);
  }

  PublicKey keyById(KeyId keyId) {
    final pk = DartApi.native.morpheusPublic
        .keyById(_ffi, keyId.ffi)
        .extract((res) => res.asPointer<Void>());
    return PublicKey(pk, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.morpheusPublic.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class MorpheusPrivateKey implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  MorpheusPrivateKey._(this._ffi, this._owned);

  String get path {
    return DartApi.native.morpheusPrivateKey.pathGet(_ffi).intoString();
  }

  String get kind {
    return DartApi.native.morpheusPrivateKey.kindGet(_ffi).intoString();
  }

  int get idx {
    return DartApi.native.morpheusPrivateKey.idxGet(_ffi);
  }

  MorpheusPublicKey neuter() {
    final ffiPubKey = DartApi.native.morpheusPrivateKey.neuter(_ffi);
    return MorpheusPublicKey._(ffiPubKey, true);
  }

  PrivateKey privateKey() {
    final ffiPk = DartApi.native.morpheusPrivateKey.privateKey(_ffi);
    return PrivateKey(ffiPk, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.morpheusPrivateKey.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class MorpheusPrivateKind implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  MorpheusPrivateKind._(this._ffi, this._owned);

  String get kind {
    return DartApi.native.morpheusPrivateKind.kindGet(_ffi).intoString();
  }

  int get length {
    return DartApi.native.morpheusPrivateKind
        .lenGet(_ffi)
        .extract((res) => res.asUint64());
  }

  bool get isEmpty {
    return DartApi.native.morpheusPrivateKind
        .isEmptyGet(_ffi)
        .extract((res) => res.asBool());
  }

  MorpheusPublicKind neuter() {
    final ffiMorpheusPublicKind =
        DartApi.native.morpheusPrivateKind.neuter(_ffi);
    return MorpheusPublicKind._(ffiMorpheusPublicKind, true);
  }

  MorpheusPrivateKey key(int idx) {
    final ffiMorpheusSk = DartApi.native.morpheusPrivateKind
        .key(_ffi, idx)
        .extract((res) => res.asPointer<Void>());
    return MorpheusPrivateKey._(ffiMorpheusSk, true);
  }

  Did did(int idx) {
    final ffiDid = DartApi.native.morpheusPrivateKind
        .did(_ffi, idx)
        .extract((res) => res.asPointer<Void>());
    return Did(ffiDid, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.morpheusPrivateKind.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class MorpheusPrivate implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  MorpheusPrivate._(this._ffi, this._owned);

  MorpheusPublicKind get personas {
    final ffiKind = DartApi.native.morpheusPrivate
        .personasGet(_ffi)
        .extract((res) => res.asPointer<Void>());
    return MorpheusPublicKind._(ffiKind, true);
  }

  MorpheusPrivateKey keyByPk(PublicKey pk) {
    final ffiMorpheusSk = DartApi.native.morpheusPrivate
        .keyByPk(_ffi, pk.ffi)
        .extract((res) => res.asPointer<Void>());
    return MorpheusPrivateKey._(ffiMorpheusSk, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.morpheusPrivate.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class MorpheusPlugin implements Disposable {
  static void rewind(Vault vault, String unlockPassword) {
    final nativePwd = Utf8.toUtf8(unlockPassword);
    try {
      return DartApi.native.morpheusPlugin
          .rewind(vault.ffi, nativePwd)
          .extract((res) => res.asVoid);
    } finally {
      free(nativePwd);
    }
  }

  static MorpheusPlugin get(Vault vault) {
    final plugin = DartApi.native.morpheusPlugin
        .get(vault.ffi)
        .extract((res) => res.asPointer<Void>());
    return MorpheusPlugin._(plugin, true);
  }

  Pointer<Void> _ffi;
  bool _owned;

  MorpheusPlugin._(this._ffi, this._owned);

  MorpheusPrivate private(String unlockPassword) {
    final nativePwd = Utf8.toUtf8(unlockPassword);
    try {
      final private = DartApi.native.morpheusPlugin
          .private(_ffi, nativePwd)
          .extract((res) => res.asPointer<Void>());
      return MorpheusPrivate._(private, true);
    } finally {
      free(nativePwd);
    }
  }

  MorpheusPublic get public {
    final public = DartApi.native.morpheusPlugin
        .public_get(_ffi)
        .extract((res) => res.asPointer<Void>());
    return MorpheusPublic._(public, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.morpheusPlugin.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

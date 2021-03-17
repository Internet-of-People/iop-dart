import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';
// ignore: library_prefixes
import 'package:iop_sdk/ssi.dart' as Ssi;

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

  Did did(int idx) {
    final ffiDid = DartApi.native.morpheusPublicKind
        .did(_ffi, idx)
        .extract((res) => res.asPointer<Void>());
    return Did(ffiDid, true);
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

  MorpheusPrivateKind get personas {
    final ffiKind = DartApi.native.morpheusPrivate
        .personasGet(_ffi)
        .extract((res) => res.asPointer<Void>());
    return MorpheusPrivateKind._(ffiKind, true);
  }

  MorpheusPublic get public {
    final ffiPub = DartApi.native.morpheusPrivate.publicGet(_ffi);
    return MorpheusPublic._(ffiPub, true);
  }

  MorpheusPrivateKey keyByPk(PublicKey pk) {
    final ffiMorpheusSk = DartApi.native.morpheusPrivate
        .keyByPk(_ffi, pk.ffi)
        .extract((res) => res.asPointer<Void>());
    return MorpheusPrivateKey._(ffiMorpheusSk, true);
  }

  Ssi.Signed<ByteData> signDidOperations(KeyId id, ByteData data) {
    final nativeData = ByteSlice.fromBytes(data);
    try {
      final signedFfi = DartApi.native.morpheusPrivate
          .signDidOperations(_ffi, id.ffi, nativeData.addressOf)
          .extract((resp) => resp.asPointer<Void>());
      return _toSsiSignedBytes(signedFfi, data);
    } finally {
      nativeData.dispose();
    }
  }

  Ssi.Signed<Ssi.WitnessRequest> signWitnessRequest(
      KeyId id, Ssi.WitnessRequest request) {
    final requestString = json.encode(request.toJson());
    final nativeRequest = requestString.toNativeUtf8();
    try {
      final signedFfi = DartApi.native.morpheusPrivate
          .signWitnessRequest(_ffi, id.ffi, nativeRequest)
          .extract((resp) => resp.asPointer<Void>());
      return _toSsiSignedTyped(signedFfi, request);
    } finally {
      calloc.free(nativeRequest);
    }
  }

  Ssi.Signed<Ssi.WitnessStatement> signWitnessStatement(
      KeyId id, Ssi.WitnessStatement statement) {
    final statementString = json.encode(statement.toJson());
    final nativeStatement = statementString.toNativeUtf8();
    try {
      final signedFfi = DartApi.native.morpheusPrivate
          .signWitnessStatement(_ffi, id.ffi, nativeStatement)
          .extract((resp) => resp.asPointer<Void>());
      return _toSsiSignedTyped(signedFfi, statement);
    } finally {
      calloc.free(nativeStatement);
    }
  }

  Ssi.Signed<Ssi.Presentation> signClaimPresentation(
      KeyId id, Ssi.Presentation presentation) {
    final presentationString = json.encode(presentation.toJson());
    final nativePresentation = presentationString.toNativeUtf8();
    try {
      final signedFfi = DartApi.native.morpheusPrivate
          .signClaimPresentation(_ffi, id.ffi, nativePresentation)
          .extract((resp) => resp.asPointer<Void>());
      return _toSsiSignedTyped(signedFfi, presentation);
    } finally {
      calloc.free(nativePresentation);
    }
  }

  Ssi.Signature _toSsiSignature(PublicKey pk, Signature sig) {
    try {
      final publicKeyData = PublicKeyData(pk.toString());
      final signatureBytes = SignatureData(sig.toString());
      return Ssi.Signature(publicKeyData, signatureBytes);
    } finally {
      sig.dispose();
      pk.dispose();
    }
  }

  Ssi.Signed<ByteData> _toSsiSignedBytes(
      Pointer<Void> signedFfi, ByteData content) {
    final signedBytes = SignedBytes(signedFfi, true);
    try {
      final signature = _toSsiSignature(
        signedBytes.publicKey,
        signedBytes.signature,
      );
      return Ssi.Signed<ByteData>(signature, Ssi.Content(content, null));
    } finally {
      signedBytes.dispose();
    }
  }

  Ssi.Signed<T> _toSsiSignedTyped<T>(Pointer<Void> signedFfi, T content) {
    final signedJson = SignedJson(signedFfi, true);
    try {
      final signature = _toSsiSignature(
        signedJson.publicKey,
        signedJson.signature,
      );
      return Ssi.Signed<T>(signature, Ssi.Content(content, null));
    } finally {
      signedJson.dispose();
    }
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
  static void init(Vault vault, String unlockPassword) {
    final nativePwd = unlockPassword.toNativeUtf8();
    try {
      return DartApi.native.morpheusPlugin
          .init(vault.ffi, nativePwd)
          .extract((res) => res.asVoid);
    } finally {
      calloc.free(nativePwd);
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
    final nativePwd = unlockPassword.toNativeUtf8();
    try {
      final private = DartApi.native.morpheusPlugin
          .private(_ffi, nativePwd)
          .extract((res) => res.asPointer<Void>());
      return MorpheusPrivate._(private, true);
    } finally {
      calloc.free(nativePwd);
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

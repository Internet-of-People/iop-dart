import 'dart:ffi';

import 'package:iop_sdk/crypto.dart';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/network.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';
import 'package:iop_sdk/src/morpheus/operation_signer.dart';

import '../../ssi.dart';

class MorpheusAssetBuilder implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  MorpheusAssetBuilder(this._ffi, this._owned);

  factory MorpheusAssetBuilder.create() {
    final builder = DartApi.native.morpheusAssetBuilder.create();
    return MorpheusAssetBuilder(builder, true);
  }

  MorpheusAssetBuilder addSigned(MorpheusSignedOperation signedOperation) {
    DartApi.native.morpheusAssetBuilder
        .addSigned(_ffi, signedOperation.ffi);
    return this;
  }

  MorpheusAssetBuilder addRegisterBeforeProof(ContentId contentId) {
    final nativeCid = Utf8.toUtf8(contentId.value);
    try {
      DartApi.native.morpheusAssetBuilder
          .addRegisterBeforeProof(_ffi, nativeCid)
          .extract((res) => res.asVoid);
      return this;
    } finally {
      free(nativeCid);
    }
  }

  MorpheusAsset build() {
    final asset = DartApi.native.morpheusAssetBuilder.build(_ffi);
    return MorpheusAsset(asset, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.morpheusAssetBuilder.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class MorpheusAsset implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  MorpheusAsset(this._ffi, this._owned);

  @override
  String toString() {
    return DartApi.native.morpheusAsset.to_String(_ffi)
        .extract((res) => res.asString);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.morpheusAsset.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}


class MorpheusTxBuilder{
  static String build(Network network, MorpheusAsset asset, SecpPublicKey senderPubKey, int nonce) {
    final nativeNetwork = Utf8.toUtf8(network.networkNativeName);
    try {
      return DartApi.native.morpheusTxBuilder
          .build(nativeNetwork, asset._ffi, senderPubKey.ffi, nonce)
          .extract((res) => res.asString);
    } finally {
      free(nativeNetwork);
    }
  }
}
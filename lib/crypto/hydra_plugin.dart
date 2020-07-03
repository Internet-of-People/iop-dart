import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/crypto/bip44.dart';
import 'package:morpheus_sdk/crypto/disposable.dart';
import 'package:morpheus_sdk/crypto/vault.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';
import 'package:morpheus_sdk/layer1/sdk.dart';
import 'package:morpheus_sdk/network.dart';

class HydraPlugin implements Disposable {
  static void rewind(
      Vault vault, String unlockPassword, Network network, int account) {
    final nativePwd = Utf8.toUtf8(unlockPassword);
    final nativeNet = Utf8.toUtf8(network.RustApiId);
    try {
      return DartApi.native
          .hydra_plugin_rewind(vault.ffi, nativePwd, nativeNet, account)
          .extract((res) => res.asVoid);
    } finally {
      free(nativeNet);
      free(nativePwd);
    }
  }

  static HydraPlugin get(Vault vault, Network network, int account) {
    final nativeNet = Utf8.toUtf8(network.RustApiId);
    try {
      final ffiPlugin = DartApi.native
          .hydra_plugin_get(vault.ffi, nativeNet, account)
          .extract((res) => res.asPointer());
      return HydraPlugin(ffiPlugin);
    } finally {
      free(nativeNet);
    }
  }

  Pointer<Void> _ffi;
  bool _owned;

  HydraPlugin(this._ffi);

  HydraPrivate private(String unlockPassword) {
    final nativePwd = Utf8.toUtf8(unlockPassword);
    try {
      final ffiPrivate = DartApi.native
          .hydra_private_get(_ffi, nativePwd)
          .extract((res) => res.asPointer());
      return HydraPrivate(ffiPrivate);
    } finally {
      free(nativePwd);
    }
  }

  HydraPublic public() {
    final ffiPublic = DartApi.native.hydra_public_get(_ffi).extract((res) => res.asPointer());
    return HydraPublic(ffiPublic, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_hydra_plugin(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class HydraPrivate implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  HydraPrivate(this._ffi);

  HydraPublic neuter() {
    final public = DartApi.native
        .hydra_private_neuter(_ffi)
        .extract((res) => res.asPointer());
    return HydraPublic(public, true);
  }

  // TODO should be strongly typed, e.g. receiving HydraTransferTransaction,
  //      returning SignedContent and maybe extracting signer address from tx or using HydraAddress
  SignedHydraTransaction signHydraTransaction(String address, String tx) {
    // TODO should we dedicate a toJson() function for tx serialization?
    final signedTx = DartApi.instance.hydraPrivatePartSignHydraTx(
      _ffi,
      address,
      tx.toString(),
    );

    return SignedHydraTransaction(signedTx);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_hydra_private(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class HydraPublic implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  HydraPublic(this._ffi, this._owned);

  Bip44PublicKey key(int idx) {
    final bip44PubKey = DartApi.native
        .hydra_public_key(_ffi, idx)
        .extract((res) => res.asPointer());
    return Bip44PublicKey(bip44PubKey, true);
  }

  Bip44PublicKey keyByAddress(String address) {
    final nativeAddr = Utf8.toUtf8(address);
    try {
      final bip44PubKey = DartApi.native
          .hydra_public_key_by_address(_ffi, nativeAddr)
          .extract((res) => res.asPointer());
      return Bip44PublicKey(bip44PubKey, true);
    } finally {
      free(nativeAddr);
    }
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_hydra_public(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

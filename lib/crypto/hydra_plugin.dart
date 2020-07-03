import 'dart:ffi';

import 'package:morpheus_sdk/crypto/bip44.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/layer1/sdk.dart';

class HydraPlugin {
  // TODO call destructor somehow
  final Pointer<Void> _ffiHydra;

  HydraPlugin(this._ffiHydra);

  HydraPrivate private(String unlockPassword) {
    final ffiPrivate = DartApi.instance.hydraPrivatePart(_ffiHydra, unlockPassword);
    return HydraPrivate(ffiPrivate);
  }

  HydraPublic public() {
    final ffiPublic = DartApi.instance.hydraPublicPart(_ffiHydra);
    return HydraPublic(ffiPublic);
  }
}

class HydraPrivate {
  // TODO call destructor somehow
  final Pointer<Void> _ffiHydraPrivate;

  HydraPrivate(this._ffiHydraPrivate);

  HydraPublic neuter() {
    final public = DartApi.instance.hydraPrivatePartNeuter(_ffiHydraPrivate);
    return HydraPublic(public);
  }

  // TODO should be strongly typed, e.g. receiving HydraTransferTransaction,
  //      returning SignedContent and maybe extracting signer address from tx or using HydraAddress
  SignedHydraTransaction signHydraTransaction(String address, String tx) {
    // TODO should we dedicate a toJson() function for tx serialization?
    final signedTx = DartApi.instance.hydraPrivatePartSignHydraTx(
      _ffiHydraPrivate,
      address,
      tx.toString(),
    );

    return SignedHydraTransaction(signedTx);
  }
}

class HydraPublic {
  // TODO call destructor somehow
  final Pointer<Void> _ffiHydraPublic;

  HydraPublic(this._ffiHydraPublic);

  Bip44PublicKey key(int idx) {
    final bip44PubKey = DartApi.instance.hydraPublicPartKey(_ffiHydraPublic, idx);
    return Bip44PublicKey(bip44PubKey);
  }

  Bip44PublicKey keyByAddress(String address) {
    final bip44PubKey = DartApi.instance.hydraPublicPartKeyByAddress(_ffiHydraPublic, address);
    return Bip44PublicKey(bip44PubKey);
  }
}

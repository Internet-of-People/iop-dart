import 'dart:ffi';

import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/layer1/sdk.dart';

class HydraPlugin {
  // TODO call destructor somehow
  final Pointer<Void> _ffiHydra;

  HydraPlugin(this._ffiHydra);

  HydraPrivate private(String unlockPassword) {
    final ffiPrivate = DartApi.instance.hydraPrivate(_ffiHydra, unlockPassword);
    return HydraPrivate(ffiPrivate);
  }

  HydraPublic public() {
    final ffiPublic = DartApi.instance.hydraPublic(_ffiHydra);
    return HydraPublic(ffiPublic);
  }
}

class HydraPrivate {
  // TODO call destructor somehow
  final Pointer<Void> _ffiHydraPrivate;

  HydraPrivate(this._ffiHydraPrivate);

  // TODO should be strongly typed, e.g. receiving HydraTransferTransaction,
  //      returning SignedContent and maybe extracting signer address from tx or using HydraAddress
  SignedHydraTransaction signHydraTransaction(String address, String tx) {
    // TODO should we dedicate a toJson() function for tx serialization?
    final signedTx = DartApi.instance.signHydraTx(
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

  String address(int idx) {
    return DartApi.instance.hydraAddress(_ffiHydraPublic, idx);
  }
}

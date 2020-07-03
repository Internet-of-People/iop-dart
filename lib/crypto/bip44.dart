import 'dart:ffi';

import 'package:morpheus_sdk/crypto/secp.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/layer1/sdk.dart';

class Bip44PublicKey {
  // TODO call destructor somehow
  final Pointer<Void> _ffiBip44PublicKey;

  Bip44PublicKey(this._ffiBip44PublicKey);

  SecpPublicKey get publicKey {
    final secpPubKey =
        DartApi.instance.bip44PublicKeyGetPublicKey(_ffiBip44PublicKey);
    return SecpPublicKey(secpPubKey);
  }

  String get address {
    return DartApi.instance.bip44PublicKeyGetAddress(_ffiBip44PublicKey);
  }
}

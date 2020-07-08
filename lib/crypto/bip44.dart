import 'dart:ffi';
import 'package:morpheus_sdk/crypto/disposable.dart';
import 'package:morpheus_sdk/crypto/secp.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';

class Bip44PublicKey implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  Bip44PublicKey(this._ffi, this._owned);

  SecpPublicKey get publicKey {
    final secpPubKey = DartApi.native.bip44publicKey
        .publicKeyGet(_ffi)
        .extract((res) => res.asPointer<Void>());
    return SecpPublicKey(secpPubKey, true);
  }

  String get address {
    return DartApi.native.bip44publicKey
        .addressGet(_ffi)
        .extract((res) => res.asString);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.bip44publicKey.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

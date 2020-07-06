import 'dart:ffi';

import 'package:morpheus_sdk/crypto/disposable.dart';
import 'package:morpheus_sdk/crypto/secp.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';

class Bip44PublicKey implements IDisposable {
  Pointer<Void> _ffi;
  bool _owned;

  Bip44PublicKey(this._ffi, this._owned);

  SecpPublicKey get publicKey {
    final secpPubKey = DartApi.native
        .bip44_public_key_pk_get(_ffi)
        .extract((res) => res.asPointer());
    return SecpPublicKey(secpPubKey, true);
  }

  String get address {
    return DartApi.native
        .bip44_public_key_address_get(_ffi)
        .extract((res) => res.asString);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.delete_bip44_public_key(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

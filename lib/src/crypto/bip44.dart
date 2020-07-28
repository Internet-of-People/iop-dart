import 'dart:ffi';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

class Bip44Key implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  Bip44Key(this._ffi, this._owned);

  /* TODO Bip32Node
  Bip32Node publicKey() {
    final node = DartApi.native.bip44Key
        .node(_ffi);
    return Bip32Node(node, true);
  }
  */

  SecpPrivateKey privateKey() {
    final secpSk = DartApi.native.bip44Key.privateKey(_ffi);
    return SecpPrivateKey(secpSk, true);
  }

  int get slip44 {
    return DartApi.native.bip44Key.slip44Get(_ffi);
  }

  int get account {
    return DartApi.native.bip44Key.accountGet(_ffi);
  }

  bool get change {
    return DartApi.native.bip44Key.changeGet(_ffi) != 0;
  }

  int get key {
    return DartApi.native.bip44Key.keyGet(_ffi);
  }

  String get path {
    return DartApi.native.bip44Key.pathGet(_ffi).intoString();
  }

  Bip44PublicKey neuter() {
    final bip44Pk = DartApi.native.bip44Key.neuter(_ffi);
    return Bip44PublicKey(bip44Pk, true);
  }

  String get wif {
    return DartApi.native.bip44Key.wifGet(_ffi).intoString();
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.bip44Key.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class Bip44PublicKey implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  Bip44PublicKey(this._ffi, this._owned);

  /* TODO Bip32PublicNode
  Bip32PublicNode node() {
    final node = DartApi.native.bip44PublicKey
        .node(_ffi);
    return Bip32PublicNode(node, true);
  }
  */

  SecpPublicKey publicKey() {
    final secpPk = DartApi.native.bip44PublicKey.publicKey(_ffi);
    return SecpPublicKey(secpPk, true);
  }

  SecpKeyId keyId() {
    final secpId = DartApi.native.bip44PublicKey.keyId(_ffi);
    return SecpKeyId(secpId, true);
  }

  int get slip44 {
    return DartApi.native.bip44PublicKey.slip44Get(_ffi);
  }

  int get account {
    return DartApi.native.bip44PublicKey.accountGet(_ffi);
  }

  bool get change {
    return DartApi.native.bip44PublicKey.changeGet(_ffi) != 0;
  }

  int get key {
    return DartApi.native.bip44PublicKey.keyGet(_ffi);
  }

  String get path {
    return DartApi.native.bip44PublicKey.pathGet(_ffi).intoString();
  }

  String get address {
    return DartApi.native.bip44PublicKey.addressGet(_ffi).intoString();
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.bip44PublicKey.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

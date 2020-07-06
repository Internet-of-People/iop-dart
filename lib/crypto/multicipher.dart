import 'dart:core';
import 'dart:ffi';

import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/layer1/sdk.dart';


class MPublicKey {
  // TODO call destructor somehow
  final Pointer<Void> _ffiMPublicKey;

  MPublicKey(this._ffiMPublicKey);

  static MPublicKey fromString(String str) {
    final _ffiMPublicKey = DartApi.instance.mPublicKeyFromString(str);
    return MPublicKey(_ffiMPublicKey);
  }

  @override
  String toString() {
    return DartApi.instance.mPublicKeyToString(_ffiMPublicKey);
  }
}


class MKeyId {
  // TODO call destructor somehow
  final Pointer<Void> _ffiMKeyId;

  MKeyId(this._ffiMKeyId);

  static MKeyId fromString(String str) {
    final _ffiMKeyId = DartApi.instance.mKeyIdFromString(str);
    return MKeyId(_ffiMKeyId);
  }

  @override
  String toString() {
    return DartApi.instance.mKeyIdToString(_ffiMKeyId);
  }
}

import 'dart:core';
import 'dart:ffi';

import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/layer1/sdk.dart';

class SecpPublicKey {
  // TODO call destructor somehow
  final Pointer<Void> _ffiSecpPublicKey;

  SecpPublicKey(this._ffiSecpPublicKey);

  @override
  String toString() {
    return DartApi.instance.secpPublicKey_toString(_ffiSecpPublicKey);
  }
}

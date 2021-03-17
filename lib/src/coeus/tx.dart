import 'dart:ffi';

import 'package:iop_sdk/crypto.dart';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/network.dart';
import 'package:iop_sdk/src/coeus/bundle.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

class CoeusTxBuilder implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  CoeusTxBuilder(this._ffi, this._owned);

  factory CoeusTxBuilder.create(Network network) {
    final nativeNetwork = network.networkNativeName.toNativeUtf8();
    try {
      final builder = DartApi.native.coeusTxBuilder
          .create(nativeNetwork)
          .extract((res) => res.asPointer<Void>());
      return CoeusTxBuilder(builder, true);
    } finally {
      calloc.free(nativeNetwork);
    }
  }

  String build(SignedBundle bundle, SecpPublicKey senderPublicKey, int nonce) {
    return DartApi.native.coeusTxBuilder
        .build(_ffi, bundle.ffi, senderPublicKey.ffi, nonce)
        .extract((res) => res.asString);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.coeusTxBuilder.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

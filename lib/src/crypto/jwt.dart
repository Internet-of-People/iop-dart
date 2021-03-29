import 'dart:core';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

class JwtBuilder implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  JwtBuilder(this._ffi, this._owned);

  factory JwtBuilder.create() {
    final builder = DartApi.native.jwtBuilder.create();
    return JwtBuilder(builder, true);
  }

  factory JwtBuilder.withContentId(String contentId) {
    final nativeContentId = contentId.toNativeUtf8();
    try {
      final builder = DartApi.native.jwtBuilder
          .withContentId(nativeContentId)
          .extract((res) => res.asPointer<Void>());
      return JwtBuilder(builder, true);
    } finally {
      calloc.free(nativeContentId);
    }
  }

  DateTime get createdAt {
    final epochSecs = DartApi.native.jwtBuilder.createdAt_get(_ffi);
    return DateTime.fromMillisecondsSinceEpoch(1000 * epochSecs).toUtc();
  }

  set createdAt(DateTime value) {
    final epochSecs = (value.toUtc().millisecondsSinceEpoch / 1000).round();
    DartApi.native.jwtBuilder.createdAt_set(_ffi, epochSecs);
  }

  Duration get timeToLive {
    final secs = DartApi.native.jwtBuilder.createdAt_get(_ffi);
    return Duration(seconds: secs);
  }

  set timeToLive(Duration value) {
    DartApi.native.jwtBuilder.createdAt_set(_ffi, value.inSeconds);
  }

  String sign(PrivateKey privateKey) {
    return DartApi.native.jwtBuilder
        .sign(_ffi, privateKey.ffi)
        .extract((res) => res.asString);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.jwtBuilder.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class JwtParser implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  JwtParser(this._ffi, this._owned);

  factory JwtParser.create(String token, {DateTime? currentTime}) {
    Pointer<Int64> epochSecs = nullptr;
    if (currentTime != null) {
      epochSecs = calloc<Int64>();
      epochSecs.value =
          (currentTime.toUtc().millisecondsSinceEpoch / 1000).round();
    }

    final nativeToken = token.toNativeUtf8();
    try {
      final parser = DartApi.native.jwtParser
          .create(nativeToken, epochSecs)
          .extract((res) => res.asPointer<Void>());
      return JwtParser(parser, true);
    } finally {
      calloc.free(nativeToken);
    }
  }

  PublicKey get publicKey {
    final pubKey = DartApi.native.jwtParser.publicKey_get(_ffi);
    return PublicKey(pubKey, true);
  }

  DateTime get createdAt {
    final epochSecs = DartApi.native.jwtParser.createdAt_get(_ffi);
    return DateTime.fromMillisecondsSinceEpoch(1000 * epochSecs);
  }

  Duration get timeToLive {
    final secs = DartApi.native.jwtParser.timeToLive_get(_ffi);
    return Duration(seconds: secs);
  }

  String? get contentId {
    return DartApi.native.jwtParser.contentId_get(_ffi).intoString();
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.jwtParser.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

import 'dart:convert';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/native_api.dart';
import 'package:iop_sdk/layer1.dart';

class DartApi implements Disposable {
  static DartApi _instance;
  final NativeApi _native;

  DartApi._(this._native);

  static NativeApi get native => instance._native;

  static DartApi get instance {
    if (_instance == null) {
      final api = NativeApi.load('./libiop_sdk_ffi.so');
      _instance = DartApi._(api);
    }

    return _instance;
  }

  static void disposeIfCreated() {
    if (_instance != null) {
      _instance.dispose();
      _instance = null;
    }
  }

  String bip39GeneratePhrase(String langCode) {
    final nativeLangCode = Utf8.toUtf8(langCode);
    try {
      return _native
          .bip39_generate_phrase(nativeLangCode)
          .extract((res) => res.asString);
    } finally {
      free(nativeLangCode);
    }
  }

  void bip39ValidatePhrase(String langCode, String phrase) {
    final nativeLangCode = Utf8.toUtf8(langCode);
    final nativePhrase = Utf8.toUtf8(phrase);
    try {
      return _native
          .bip39_validate_phrase(nativeLangCode, nativePhrase)
          .extract((res) => res.asVoid);
    } finally {
      free(nativeLangCode);
      free(nativePhrase);
    }
  }

  List<String> bip39ListWords(String langCode, String prefix) {
    final nativeLangCode = Utf8.toUtf8(langCode);
    final nativePrefix = Utf8.toUtf8(prefix);

    try {
      return _native
          .bip39_list_words(nativeLangCode, nativePrefix)
          .extract((res) => res.asStringList());
    } finally {
      free(nativeLangCode);
      free(nativePrefix);
    }
  }

  String selectiveDigestJson(String json, String keepPaths) {
    final nativeJson = Utf8.toUtf8(json);
    final nativeKeepPaths = Utf8.toUtf8(keepPaths);
    try {
      return _native
          .selectiveDigestJson(nativeJson, nativeKeepPaths)
          .extract((res) => res.asString);
    } finally {
      free(nativeJson);
      free(nativeKeepPaths);
    }
  }

  String digestJson(String json) {
    final nativeJson = Utf8.toUtf8(json);
    try {
      return _native.digestJson(nativeJson).extract((res) => res.asString);
    } finally {
      free(nativeJson);
    }
  }

  String stringifyJson(String json) {
    final nativeJson = Utf8.toUtf8(json);
    try {
      return _native.stringifyJson(nativeJson).extract((res) => res.asString);
    } finally {
      free(nativeJson);
    }
  }

  String nonce264() {
    return _native.nonce264().extract((res) => res.asString);
  }

  // TODO Temporary API for the transfer builder
  String morpheusTx(
    String network,
    SecpPublicKey senderPubKey,
    List<OperationData> opAttempts,
    int nonce,
  ) {
    final nativeNet = Utf8.toUtf8(network);
    final nativeOps = Utf8.toUtf8(json.encode(opAttempts));
    try {
      return _native
          .morpheusTx(nativeNet, senderPubKey.ffi, nativeOps, nonce)
          .extract((res) => res.asString);
    } finally {
      free(nativeOps);
      free(nativeNet);
    }
  }

  @override
  void dispose() {}
}

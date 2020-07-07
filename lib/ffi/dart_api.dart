import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/crypto/disposable.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';
import 'package:morpheus_sdk/ffi/native_api.dart';

class DartApi implements Disposable {
  static DartApi _instance;
  final NativeApi _native;

  DartApi._(this._native);

  static NativeApi get native => instance._native;

  static DartApi get instance {
    if (_instance == null) {
      final api = NativeApi.load('./libmorpheus_core.so');
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
          .selective_digest_json(nativeJson, nativeKeepPaths)
          .extract((res) => res.asString);
    } finally {
      free(nativeJson);
      free(nativeKeepPaths);
    }
  }

  String nonce264() {
    return _native.nonce264().extract((res) => res.asString);
  }

  // TODO Temporary API for the transfer builder
  String hydraTransferTx(
    String network,
    String senderPubKey,
    String recipient,
    int flakesAmount,
    int nonce,
  ) {
    final nativeNet = Utf8.toUtf8(network);
    final nativeSender = Utf8.toUtf8(senderPubKey);
    final nativeRecipient = Utf8.toUtf8(recipient);
    try {
      return _native
          .hydra_transfer_tx(
            nativeNet,
            nativeSender,
            nativeRecipient,
            flakesAmount,
            nonce,
          )
          .extract((res) => res.asString);
    } finally {
      free(nativeRecipient);
      free(nativeSender);
      free(nativeNet);
    }
  }

  @override
  void dispose() {}
}

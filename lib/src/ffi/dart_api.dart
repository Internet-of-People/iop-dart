import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/native_api.dart';

class DartApi implements Disposable {
  static DartApi? _instance;
  final NativeApi _native;

  DartApi._(this._native);

  static NativeApi get native => instance._native;

  static DartApi get instance {
    if (_instance == null) {
      final libName = 'libiop_sdk_ffi.so';
      final libPath = Platform.isAndroid ? libName : './$libName';
      final api = NativeApi.load(libPath);
      _instance = DartApi._(api);
    }

    return _instance!;
  }

  static void disposeIfCreated() {
    if (_instance != null) {
      _instance!.dispose();
      _instance = null;
    }
  }

  String bip39GeneratePhrase(String langCode) {
    final nativeLangCode = langCode.toNativeUtf8();
    try {
      return _native
          .bip39_generate_phrase(nativeLangCode)
          .extract((res) => res.asString);
    } finally {
      calloc.free(nativeLangCode);
    }
  }

  void bip39ValidatePhrase(String langCode, String phrase) {
    final nativeLangCode = langCode.toNativeUtf8();
    final nativePhrase = phrase.toNativeUtf8();
    try {
      return _native
          .bip39_validate_phrase(nativeLangCode, nativePhrase)
          .extract((res) => res.asVoid);
    } finally {
      calloc.free(nativeLangCode);
      calloc.free(nativePhrase);
    }
  }

  List<String> bip39ListWords(String langCode, String prefix) {
    final nativeLangCode = langCode.toNativeUtf8();
    final nativePrefix = prefix.toNativeUtf8();

    try {
      return _native
          .bip39_list_words(nativeLangCode, nativePrefix)
          .extract((res) => res.asStringList());
    } finally {
      calloc.free(nativeLangCode);
      calloc.free(nativePrefix);
    }
  }

  String selectiveDigestJson(String json, String keepPaths) {
    final nativeJson = json.toNativeUtf8();
    final nativeKeepPaths = keepPaths.toNativeUtf8();
    try {
      return _native
          .selectiveDigestJson(nativeJson, nativeKeepPaths)
          .extract((res) => res.asString);
    } finally {
      calloc.free(nativeJson);
      calloc.free(nativeKeepPaths);
    }
  }

  String digestJson(String json) {
    final nativeJson = json.toNativeUtf8();
    try {
      return _native.digestJson(nativeJson).extract((res) => res.asString);
    } finally {
      calloc.free(nativeJson);
    }
  }

  String stringifyJson(String json) {
    final nativeJson = json.toNativeUtf8();
    try {
      return _native.stringifyJson(nativeJson).extract((res) => res.asString);
    } finally {
      calloc.free(nativeJson);
    }
  }

  String nonce264() {
    return _native.nonce264().extract((res) => res.asString);
  }

  @override
  void dispose() {}
}

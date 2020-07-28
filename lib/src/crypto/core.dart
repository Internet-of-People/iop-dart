import 'dart:convert';

import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/ssi.dart';

class Bip39 {
  final String _languageCode;

  static const String DEMO_PHRASE =
      'include pear escape sail spy orange cute despair witness trouble sleep torch wire burst unable brass expose fiction drift clock duck oxygen aerobic already';

  Bip39(this._languageCode);

  String generatePhrase() {
    return DartApi.instance.bip39GeneratePhrase(_languageCode);
  }

  List<String> listWords(String prefix) {
    return DartApi.instance.bip39ListWords(_languageCode, prefix);
  }

  void validatePhrase(String phrase) {
    return DartApi.instance.bip39ValidatePhrase(_languageCode, phrase);
  }
}

class Authentication {
  final KeyId keyId;
  final PublicKey publicKey;

  Authentication._(this.keyId, this.publicKey);

  factory Authentication.keyId(KeyId keyId) => Authentication._(keyId, null);

  factory Authentication.publicKey(PublicKey publicKey) => Authentication._(
        null,
        publicKey,
      );

  bool get isKeyId => keyId != null;

  bool get isPublicKey => publicKey != null;
}

ContentId selectiveDigestJson(
  Map<String, dynamic> data,
  String keepPropertiesList,
) {
  return ContentId(DartApi.instance.selectiveDigestJson(
    json.encode(data),
    keepPropertiesList,
  ));
}

ContentId digestJson(dynamic data) {
  return ContentId(DartApi.instance.digestJson(json.encode(data)));
}

String stringifyJson(dynamic data) {
  return DartApi.instance.stringifyJson(json.encode(data));
}

Nonce nonce264() {
  return Nonce(DartApi.instance.nonce264());
}

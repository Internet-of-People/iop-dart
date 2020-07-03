import 'package:morpheus_sdk/crypto/multicipher.dart';

class Bip39 {
  static const String DEMO_PHRASE =
      'include pear escape sail spy orange cute despair witness trouble sleep torch wire burst unable brass expose fiction drift clock duck oxygen aerobic already';

  Bip39(String languageCode);
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

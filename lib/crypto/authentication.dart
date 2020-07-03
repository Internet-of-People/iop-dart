import 'package:morpheus_sdk/crypto/core.dart';
import 'package:morpheus_sdk/crypto/multicipher.dart';

bool isSameAuthentication(Authentication left, Authentication right) {
  if(left.isPublicKey) {
    if(right.isKeyId) {
      return left.publicKey.validateId(right.keyId);
    }
    else {
      return left.publicKey.toString() == right.keyId.toString();
    }
  }
  else {
    if(right.isKeyId) {
      return left.keyId.toString() == right.keyId.toString();
    }
    else {
      return right.publicKey.validateId(left.keyId);
    }
  }
}

Authentication authenticationFromData(String auth) {
  return auth.startsWith(KeyId.prefix())
      ? Authentication.keyId(KeyId.fromString(auth))
      : Authentication.publicKey(PublicKey.fromString(auth));
}

import 'package:iop_sdk/crypto.dart';

bool isSameAuthentication(Authentication left, Authentication right) {
  if (left.isPublicKey) {
    if (right.isKeyId) {
      return left.publicKey.validateId(right.keyId);
    } else {
      return left.publicKey.toString() == right.keyId.toString();
    }
  } else {
    if (right.isKeyId) {
      return left.keyId.toString() == right.keyId.toString();
    } else {
      return right.publicKey.validateId(left.keyId);
    }
  }
}

Authentication authenticationFromData(AuthenticationData auth) {
  return auth.value.startsWith(KeyId.prefix())
      ? Authentication.keyId(KeyId.fromString(auth.value))
      : Authentication.publicKey(PublicKey.fromString(auth.value));
}

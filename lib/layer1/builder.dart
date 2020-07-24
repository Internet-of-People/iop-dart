import 'package:morpheus_sdk/crypto/morpheus_plugin.dart';
import 'package:morpheus_sdk/crypto/multicipher.dart';
import 'package:morpheus_sdk/layer1/operation_data.dart';

class SignedOperationAttemptsBuilder {
  static SignedOperationsData tempSign(
    MorpheusPrivate priv,
    KeyId id,
    List<SignableOperationData> signables,
  ) {
    final opBytes = SignedOperationsData.serialize(signables);
    final signedBytes = priv.signDidOperations(
      id,
      opBytes,
    );
    final signedOp = SignedOperationsData(
      signables,
      signedBytes.signature.publicKey,
      signedBytes.signature.bytes,
    );
    return signedOp;
  }
}

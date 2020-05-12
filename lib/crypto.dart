import 'claim.dart';
import 'sdk.dart';

String maskJson(String json, String keepPaths) { throw UnimplementedError(); }
String generateNonce() { throw UnimplementedError(); }

abstract class Bip39 {
    Bip39(String languageCode);

    String generateSeedPhrase();
    bool validateSeedPhrase(String phrase);
    List<String> listWords(String wordPrefix);
}

abstract class KeyId {}

abstract class Signature {
    Signature.fromString(String signature);

    @override String toString();
}

abstract class PublicKey {
    PublicKey.fromString(String publicKey);

    @override String toString();
    KeyId keyId();
}

abstract class Did {
    Did.fromString(String did);

    @override String toString();
    PublicKey defaultKey();
}

abstract class SignedContent {
    String content(); // TODO consider using a generic T or binary type here
    PublicKey publicKey();
    Signature signature();

    bool validate();
    bool validateWithKeyId(KeyId keyId);
}


// TODO path should be strongly typed, check if there's FilePath
abstract class Vault {
    Vault.fromSeedPhrase(String phrase, {String vaultPath});
    Vault.load({String vaultPath});

    List<Did> listDids();
    Did createDid();

    Signed<WitnessRequest> signWitnessRequest(String witnessRequest, String authentication);
    Signed<WitnessStatement> signWitnessStatement(String witnessStatement, String authentication);
    Signed<Presentation> signClaimPresentation(String claimPresentation, String authentication);
}
import 'claim.dart';
import 'sdk.dart';


String maskJson(String json, String keepPaths) { throw UnimplementedError(); }
String generateNonce() { throw UnimplementedError(); }

class Bip39 {
    static const String DEMO_PHRASE = 'include pear escape sail spy orange cute despair witness trouble sleep torch wire burst unable brass expose fiction drift clock duck oxygen aerobic already';

    Bip39(String languageCode);

    String generatePhrase() { throw UnimplementedError(); }
    bool validatePhrase(String phrase) { throw UnimplementedError(); }
    List<String> listWords(String wordPrefix) { throw UnimplementedError(); }
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

abstract class Authentication {}


// TODO path should be strongly typed, check if there's FilePath
class Vault {
    Vault.fromPhrase(String phrase, {String languageCode = 'en', String vaultPath = 'vault.test'})
        { throw UnimplementedError(); }
    Vault.load({String vaultPath = 'vault.test'}) { throw UnimplementedError(); }

    List<Did> listDids() { throw UnimplementedError(); }
    Did createDid() { throw UnimplementedError(); }

    Future<MorpheusSigned<WitnessRequest>> signWitnessRequest(String witnessRequest, Authentication authentication)
        { throw UnimplementedError(); }
    Future<MorpheusSigned<WitnessStatement>> signWitnessStatement(String witnessStatement, Authentication authentication)
        { throw UnimplementedError(); }
    Future<MorpheusSigned<Presentation>> signClaimPresentation(String claimPresentation, Authentication authentication)
        { throw UnimplementedError(); }
}
import 'package:morpheus_sdk/crypto.dart';
import 'package:morpheus_sdk/layer1.dart';
import 'package:morpheus_sdk/sdk.dart';


const String senderHydAddress = 'fromHydraAddress';
const String targetHydAddress = 'toHydraAddress';


SignedHydraTransaction buildTransferTx(String toAddress, BigInt flakes, String passphrase, BigInt nonce) {
    // TODO !!! use Rust business logic via FFI to build a signed tx object
    return SignedHydraTransaction('{"transactions":[{"version":2,"network":128,"typeGroup":1,"type":0,"nonce":69,"senderPublicKey":"03d4bda72219264ff106e21044b047b6c6b2c0dde8f49b42c848e086b97920adbf","fee":10000000,"amount":100000000,"recipientId":"tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J","id":"b9e4c443071c166ca76a225a55e193deff837c5168818b715f5221b66e6f302c","signature":"304402207a0f32cc466b820ca9f76fbe595f7ac091144b89a7a9ff75df6f55ad17d4e31102204e1123a2741e1dee12ad985b194b2ed600ecad0765f2d3f2c6c18e46b0c3fce0"}]}');
}

void main(List<String> arguments) async {
    // TODO use Vault for signing Hydra transfer transaction
//    var tx = HydraTransferTransaction(
//        toAddress: HydraAddress(targetHydAddress),
//        flakes: BigInt.from(1e8),
//    );
//
//    //var phrase = Bip39.DEMO_PHRASE;
//    var phrase = Bip39('en').generatePhrase();
//    var vault = Vault.fromPhrase(phrase);
//    var signedTx = await vault.signHydraTransfer(tx, HydraAddress(senderHydAddress));

    var layer1 = Layer1(Network.TestNet);
    var nonce = await layer1.getWalletNonce();
    print('Nonce: ${nonce}');

    // TODO use Vault for signing Hydra transfer transaction
    var signedTx = buildTransferTx(
        'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J',
        BigInt.from(100000000),
        'scout try doll stuff cake welcome random taste load town clerk ostrich',
        nonce + BigInt.from(1)
    );

    var txId = await layer1.sendTransaction(signedTx);
    var txStatus = await layer1.getTransactionStatus(txId);
    print(txStatus);
}
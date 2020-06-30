import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/layer1.dart';
import 'package:morpheus_sdk/sdk.dart';


const String senderHydAddress = 'fromHydraAddress';
const String targetHydAddress = 'toHydraAddress';


SignedHydraTransaction buildTransferTx(String toAddress, BigInt flakes, String passphrase, BigInt nonce) {
    // TODO !!! use Rust business logic via FFI to build a signed tx object
    return SignedHydraTransaction('{"transactions":[{"version":2,"network":128,"typeGroup":1,"type":0,"nonce":69,"senderPublicKey":"03d4bda72219264ff106e21044b047b6c6b2c0dde8f49b42c848e086b97920adbf","fee":10000000,"amount":100000000,"recipientId":"tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J","id":"b9e4c443071c166ca76a225a55e193deff837c5168818b715f5221b66e6f302c","signature":"304402207a0f32cc466b820ca9f76fbe595f7ac091144b89a7a9ff75df6f55ad17d4e31102204e1123a2741e1dee12ad985b194b2ed600ecad0765f2d3f2c6c18e46b0c3fce0"}]}');
}

void main(List<String> arguments) async {
    DartApi.create('./libmorpheus_core.so');
    
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

    final network = Network.TestNet;
    final layer1 = Layer1(network);
//    var wallet = await layer1.getWallet();
//    var nonce = wallet.nonce;
    // TODO query nonce properly
    var nonce = BigInt.from(3);
    nonce += BigInt.from(1);
    print('Nonce: ${nonce}');

    // TODO use some kind of builder API for the transaction
    // TODO use vault/hydra to get sender info
    final senderPubKey = '02db11c07afd6ec05980284af58105329d41e9882947188022350219cca9baa3e7';
    final recipient = 'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J';
    final transferTx = DartApi.Instance.hydraTransferTx(network.Id, senderPubKey, recipient, 3141593, nonce.toInt());
    // TODO use vault/hydra to sign Tx
    var signedTx = SignedHydraTransaction(transferTx);

    print('Sending transaction');
    var txId = await layer1.sendTransaction(signedTx);
    var txStatus = await layer1.getTransactionStatus(txId);
    print('Success status: $txStatus');
}
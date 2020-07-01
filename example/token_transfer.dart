import 'package:morpheus_sdk/crypto.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/layer1.dart';
import 'package:morpheus_sdk/vault.dart';


const String senderHydAddress = 'fromHydraAddress';
const String targetHydAddress = 'toHydraAddress';


void main(List<String> arguments) async {
    // TODO hide .so and this init complexity from client
    DartApi.create('./libmorpheus_core.so');

    final phrase = Bip39.DEMO_PHRASE;
    //var phrase = Bip39('en').generatePhrase();
    final unlockPassword = 'unlock';
    final vault = Vault.create(phrase, '', unlockPassword);

    final network = Network.TestNet;
    final hydraAccount = 0;
    final layer1 = Layer1(network);

    // TODO use some kind of builder like instead of the long manual assembly below
//    var tx = HydraTransferTransaction(
//        toAddress: HydraAddress(targetHydAddress),
//        flakes: BigInt.from(1e8),
//    );

//    var wallet = await layer1.getWallet();
//    var nonce = wallet.nonce;
    // TODO query nonce properly
    var nonce = BigInt.from(15);
    nonce += BigInt.from(1);
    print('Nonce: ${nonce}');

    // TODO use some kind of builder API for the transaction
    // TODO use vault/hydra to get sender info
    final senderPubKey = '02db11c07afd6ec05980284af58105329d41e9882947188022350219cca9baa3e7';
    final recipient = 'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J';
    // TODO move this into somewhere near HydraTransaction
    final transferTx = DartApi.Instance.hydraTransferTx(network.Id, senderPubKey, recipient, 3141593, nonce.toInt());

    vault.rewindHydra(unlockPassword, network, hydraAccount);
    final hydraPlugin = vault.hydra(network, hydraAccount);
    final senderAddress = hydraPlugin.public().address(0);
    final hydraPrivate = hydraPlugin.private(unlockPassword);
    var signedTx = hydraPrivate.signHydraTransaction(senderAddress, transferTx);
    //var signedTx = SignedHydraTransaction(transferTx);

    print('Sending transaction');
    var txId = await layer1.sendTransaction(signedTx);
    var txStatus = await layer1.getTransactionStatus(txId);
    print('Success status: $txStatus');
}
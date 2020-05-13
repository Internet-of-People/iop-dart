import 'package:morpheus_sdk/crypto.dart';
import 'package:morpheus_sdk/layer1.dart';


const String senderHydAddress = 'fromHydraAddress';
const String targetHydAddress = 'toHydraAddress';

void main(List<String> arguments) async {
    var tx = HydraTransferTransaction(
        toAddress: HydraAddress(targetHydAddress),
        flakes: BigInt.from(1e8),
    );

    //var phrase = Bip39.DEMO_PHRASE;
    var phrase = Bip39('en').generatePhrase();
    var vault = Vault.fromPhrase(phrase);
    var signedTx = await vault.signHydraTransfer(tx, HydraAddress(senderHydAddress));

    var layer1 = Layer1(Network.TestNet);
    var txId = await layer1.sendTransaction(signedTx);
    var txStatus = await layer1.getTransactionStatus(txId);
    print(txStatus);
}
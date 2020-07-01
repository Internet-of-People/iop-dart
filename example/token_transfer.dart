import 'package:morpheus_sdk/crypto/core.dart';
import 'package:morpheus_sdk/crypto/vault.dart';
import 'package:morpheus_sdk/layer1/api.dart';
import 'package:morpheus_sdk/network.dart';

void main(List<String> arguments) async {
  final network = Network.TestNet;
  final targetAddress = 'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J'; // genesis
  final hydraAccount = 0;

  final unlockPassword = 'unlock';
  final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
  vault.rewindHydra(unlockPassword, network, hydraAccount);

  final hydraPlugin = vault.hydra(network, hydraAccount);
  final senderAddress = hydraPlugin.public().address(0);
  final hydraPrivate = hydraPlugin.private(unlockPassword);

  final layer1Api = Layer1Api(network);
  final amount = 1e8 ~/ 10;
  final txId = await layer1Api.sendTransferTx(
    senderAddress,
    targetAddress,
    amount,
    hydraPrivate,
  );
  print('Transaction ID: $txId');
}

import 'package:morpheus_sdk/crypto/core.dart';
import 'package:morpheus_sdk/crypto/hydra_plugin.dart';
import 'package:morpheus_sdk/crypto/vault.dart';
import 'package:morpheus_sdk/layer1/api.dart';
import 'package:morpheus_sdk/network.dart';

void main(List<String> arguments) async {
  final network = Network.TestNet;
  final targetAddress = 'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J'; // genesis
  final hydraAccount = 0;
  final unlockPassword = 'unlock';

  final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
  HydraPlugin.rewind(vault, unlockPassword, network, hydraAccount);

  final hydraPlugin = HydraPlugin.get(vault, network, hydraAccount);

  final senderAddress = hydraPlugin.public.key(0).address;
  final hydraPrivate = hydraPlugin.private(unlockPassword);

  final layer1Api = Layer1Api(network);
  final amount = 1e8 ~/ 10;
  final txId = await layer1Api.sendTransferTx(
    senderAddress,
    targetAddress,
    amount,
    hydraPrivate,
  );

  hydraPlugin.dispose();
  vault.dispose();

  print('Transaction ID: $txId');
}

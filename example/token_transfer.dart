import 'package:morpheus_sdk/crypto/core.dart';
import 'package:morpheus_sdk/crypto/disposable.dart';
import 'package:morpheus_sdk/crypto/hydra_plugin.dart';
import 'package:morpheus_sdk/crypto/vault.dart';
import 'package:morpheus_sdk/layer1/api.dart';
import 'package:morpheus_sdk/network.dart';

void main(List<String> arguments) async {
  final network = Network.TestNet;
  final targetAddress = 'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J'; // genesis
  final hydraAccount = 0;
  final unlockPassword = 'unlock';

  await Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword).use((vault) async {
    HydraPlugin.rewind(vault, unlockPassword, network, hydraAccount);
    await HydraPlugin.get(vault, network, hydraAccount).use((hydraPlugin) async {
      hydraPlugin.private(unlockPassword).use((hydraPrivate) async {
        final senderAddress = hydraPlugin.public().key(0).address;

        final layer1Api = Layer1Api(network);
        final amount = 1e8 ~/ 10;
        final txId = await layer1Api.sendTransferTx(
          senderAddress,
          targetAddress,
          amount,
          hydraPrivate,
        );
        print('Transaction sent, ID: $txId');
      });
    });
  });
}

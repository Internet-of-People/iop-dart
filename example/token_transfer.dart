import 'package:iop_sdk/crypto/core.dart';
import 'package:iop_sdk/crypto/hydra_plugin.dart';
import 'package:iop_sdk/crypto/vault.dart';
import 'package:iop_sdk/layer1/api.dart';
import 'package:iop_sdk/network.dart';


final network = Network.TestNet;
final targetAddress = 'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J'; // genesis
final amount = 1e8 ~/ 10;


void main(List<String> arguments) async {
  await sendTransferTxWithPassphrase();
  await sendTransferTxWithVault();
}


void sendTransferTxWithPassphrase() async {
  final walletPassphrase = 'scout try doll stuff cake welcome random taste load town clerk ostrich';

  print('Sending transfer transaction with passphrase');

  final layer1Api = Layer1Api(network);
  final txId = await layer1Api.sendTransferTxWithPassphrase(
    walletPassphrase,
    targetAddress,
    amount,
  );

  print('Transfer transaction sent with passphrase, ID: $txId');
}


void sendTransferTxWithVault() async {
  final hydraAccount = 0;
  final unlockPassword = 'unlock';

  print('Sending transfer transaction with HydraPlugin');

  final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
  HydraPlugin.rewind(vault, unlockPassword, network, hydraAccount);

  final hydraPlugin = HydraPlugin.get(vault, network, hydraAccount);
  final senderAddress = hydraPlugin.public.key(0).address;
  final hydraPrivate = hydraPlugin.private(unlockPassword);

  final layer1Api = Layer1Api(network);
  final txId = await layer1Api.sendTransferTx(
    senderAddress,
    targetAddress,
    amount,
    hydraPrivate,
  );

  hydraPlugin.dispose();
  vault.dispose();

  print('Transfer transaction sent with HydraPlugin, ID: $txId');
}

import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/network.dart';

import 'package:iop_sdk/crypto.dart';


final network = Network.TestNet;
final targetAddress = 'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J'; // genesis
final walletPassphrase = 'scout try doll stuff cake welcome random taste load town clerk ostrich';


void main(List<String> arguments) async {
  await sendTransferTxWithPassphrase();
  await sendTransferTxWithVault();
}

void sendTransferTxWithPassphrase() async {
  final layer1Api = Layer1Api(network);
  final amount = 1e8 ~/ 10;
  final txId = await layer1Api.sendTransferTxWithPassphrase(
    walletPassphrase,
    targetAddress,
    amount,
  );

  print('Transaction ID: $txId');
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
  final amount = 1e8 ~/ 10;
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

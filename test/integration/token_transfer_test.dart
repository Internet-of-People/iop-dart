import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/network.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:test/test.dart';


final network = Network.TestNet;
final targetAddress = 'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J'; // genesis
final walletPassphrase = 'scout try doll stuff cake welcome random taste load town clerk ostrich';


void main() {
  group('token_transfer', () {
    test('with passphrase', () async {
      final layer1Api = Layer1Api(network);
      final amount = 1e8 ~/ 10;
      final txId = await layer1Api.sendTransferTxWithPassphrase(
        walletPassphrase,
        targetAddress,
        amount,
      );

      print('Transaction ID: $txId');
      expect(txId, isNotNull);

      // NOTE make sure that other tests receive the CHANGED nonce, they fail otherwise
      await Future.delayed(Duration(seconds: 12));  // it'll be included in the SDK Soon in 2020
    });

    test('with vault', () async {
      final hydraAccount = 0;
      final unlockPassword = 'unlock';

      print('Sending transfer transaction with HydraPlugin');

      final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
      HydraPlugin.rewind(vault, unlockPassword, network, hydraAccount);

      final hydraPlugin = HydraPlugin.get(vault, network, hydraAccount);
      final hydraPublic = hydraPlugin.public;
      final firstHydKey = hydraPublic.key(0);
      final senderAddress = firstHydKey.address;
      final hydraPrivate = hydraPlugin.private(unlockPassword);

      final layer1Api = Layer1Api(network);
      final amount = 1e8 ~/ 10;
      final txId = await layer1Api.sendTransferTx(
        senderAddress,
        targetAddress,
        amount,
        hydraPrivate,
      );

      print('Transfer transaction sent with HydraPlugin, ID: $txId');
      expect(txId, isNotNull);

      // NOTE make sure that other tests receive the CHANGED nonce, they fail otherwise
      await Future.delayed(Duration(seconds: 12));  // it'll be included in the SDK Soon in 2020

      firstHydKey.dispose();
      hydraPublic.dispose();
      hydraPrivate.dispose();
      hydraPlugin.dispose();
      vault.dispose();
    });
  });
}

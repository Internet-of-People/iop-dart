import 'package:iop_sdk/network.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:test/test.dart';

import '../util.dart';

final network = Network.TestNet;
final targetAddress = 'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J'; // genesis
final hydraAccount = 0;
final unlockPassword = 'unlock';

void main() {
  final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
  HydraPlugin.init(vault, unlockPassword, network, hydraAccount);

  final hydraPlugin = HydraPlugin.get(vault, network, hydraAccount);
  final hydraPrivate = hydraPlugin.private(unlockPassword);

  final senderAddress = hydraPlugin.public
      .key(0)
      .address;

  group('token_transfer', () {
    test('with vault', () async {
      final amount = 100000; // 0.001HYD
      final txId = await layer1.sendTransferTx(
        senderAddress,
        targetAddress,
        amount,
        hydraPrivate,
      );
      await waitForLayer1Confirmation(txId, true);
    });
  });

  group('voting transactions', () {
    final delegate1 = SecpPublicKey.fromString(
        '02ae6eaed36910a51807c9dfb51c2e2988abf9008381fe4e00995e01b6714e3db2');

    test('vote', () async {
      final txId = await layer1.sendVoteTx(
        senderAddress,
        delegate1,
        hydraPrivate,
      );
      await waitForLayer1Confirmation(txId, true);
    });

    test('unvote', () async {
      final txId = await layer1.sendUnvoteTx(
        senderAddress,
        delegate1,
        hydraPrivate,
      );
      await waitForLayer1Confirmation(txId, true);
    });
  });
}

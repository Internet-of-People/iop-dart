import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/network.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:test/test.dart';

final network = Network.TestNet;
final targetAddress = 'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J'; // genesis
final api = Layer1Api.createApi(NetworkConfig.fromNetwork(Network.TestNet));
final hydraAccount = 0;
final unlockPassword = 'unlock';

void waitConfirmation(String txId) async
{
  bool success;
  for (var i = 0; i < 12; i++) {
    await Future.delayed(const Duration(seconds: 2));
    final status = await api.getTxnStatus(txId);
    if (status.isPresent && status.value.id == txId) {
      success = true;
      break;
    }
  }
  expect(success, true);
}

void main() {
  final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
  HydraPlugin.rewind(vault, unlockPassword, network, hydraAccount);

  final hydraPlugin = HydraPlugin.get(vault, network, hydraAccount);
  final hydraPrivate = hydraPlugin.private(unlockPassword);

  final senderAddress = hydraPlugin.public
      .key(0)
      .address;

  group('token_transfer', () {
    test('with vault', () async {
      final amount = 100000; // 0.001HYD
      final txId = await api.sendTransferTx(
        senderAddress,
        targetAddress,
        amount,
        hydraPrivate,
      );
      await waitConfirmation(txId);
    });
  });

  group('voting transactions', () {
    final delegate1 = SecpPublicKey.fromString(
        '02ae6eaed36910a51807c9dfb51c2e2988abf9008381fe4e00995e01b6714e3db2');

    test('vote', () async {
      final txId = await api.sendVoteTx(
        senderAddress,
        delegate1,
        hydraPrivate,
      );
      await waitConfirmation(txId);
    });

    test('unvote', () async {
      final txId = await api.sendUnvoteTx(
        senderAddress,
        delegate1,
        hydraPrivate,
      );
      await waitConfirmation(txId);
    });
  });
}

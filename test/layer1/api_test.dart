import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/network.dart';
import 'package:test/test.dart';

void main() {
  final api = Layer1Api.createApi(NetworkConfig.fromNetwork(Network.TestNet));

  group('api', () {
    test('getNodeCryptoConfig', () async {
      final resp = await api.getNodeCryptoConfig();
      expect(resp, isNotNull);
    });

    test('getCurrentHeight', () async {
      final height = await api.getCurrentHeight();
      expect(height, greaterThan(898442));
    });

    test('getTxnStatus', () async {
      const id =
          '34cec59f7ce76ae8483f064ed92c7d6f791f0ddd7c89525dcf92c95f8800ec59';
      final status = await api.getTxnStatus(id);
      expect(status.isPresent, true);
      expect(status.value.id, id);
      expect(status.value.timestamp.unix, 1593603972);
    });

    test('getTxnStatus - not existing', () async {
      const id =
          '0000c59f7ce76ae8483f064ed92c7d6f791f0ddd7c89525dcf92c95f8800ec59';
      final status = await api.getTxnStatus(id);
      expect(status.isPresent, false);
    });

    test('getWallet', () async {
      const address = 'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J';
      final wallet = await api.getWallet(address);
      expect(wallet.isPresent, true);
      expect(wallet.value.address, address);
    });

    test('getWallet - not existing', () async {
      const address = 'tjseecxRmob5qBS2T3qc8frXDKz3YUaaaa';
      final wallet = await api.getWallet(address);
      expect(wallet.isPresent, false);
    });

    test('getWalletNonce', () async {
      const address = 'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J';
      final nonce = await api.getWalletNonce(address);
      expect(nonce, greaterThan(1));
    });

    test('getWalletNonce - not existing', () async {
      const address = 'tjseecxRmob5qBS2T3qc8frXDKz3YUaaaa';
      final nonce = await api.getWalletNonce(address);
      expect(nonce, 0);
    });

    test('getWalletBalance', () async {
      const address = 'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J';
      final balance = await api.getWalletBalance(address);
      expect(balance, greaterThan(1));
    });

    test('getWalletBalance - not existing', () async {
      const address = 'tjseecxRmob5qBS2T3qc8frXDKz3YUaaaa';
      final balance = await api.getWalletBalance(address);
      expect(balance, 0);
    });

    test('sendTransfer', () async {
      final network = Network.TestNet;
      final targetAddress = 'tjseecxRmob5qBS2T3qc8frXDKz3YUGB8J'; // genesis
      final hydraAccount = 0;
      final unlockPassword = 'unlock';

      final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
      HydraPlugin.rewind(vault, unlockPassword, network, hydraAccount);

      final hydraPlugin = HydraPlugin.get(vault, network, hydraAccount);

      final senderAddress = hydraPlugin.public.key(0).address;
      final hydraPrivate = hydraPlugin.private(unlockPassword);

      final amount = 100000; // 0.001HYD

      final txId = await api.sendTransferTx(
        senderAddress,
        targetAddress,
        amount,
        hydraPrivate,
      );

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
    });
  });
}

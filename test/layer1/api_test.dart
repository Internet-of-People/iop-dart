import 'package:morpheus_sdk/layer1/api.dart';
import 'package:morpheus_sdk/network.dart';
import 'package:test/test.dart';

void main() {
  final api = Layer1Api(Network.TestNet);

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

    // TODO: send transfer tests, when the api is finalized
  });
}

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
      expect(height, greaterThan(10));
    });

    test('getTxnStatus', () async {
      const id =
          'ec38441844b31a47660a9c6a3b78a2fe62913034ce152c11a3d94a8887806fff';
      final status = await api.getTxnStatus(id);
      expect(status.isPresent, true);
      expect(status.value.id, id);
      expect(status.value.timestamp!.unix, 1564646400);
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
  });
}

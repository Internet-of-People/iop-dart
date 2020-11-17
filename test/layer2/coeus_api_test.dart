import 'dart:math';

import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/layer2.dart';
import 'package:iop_sdk/network.dart';
import 'package:iop_sdk/src/coeus/operation.dart';
import 'package:optional/optional.dart';
import 'package:test/test.dart';

void main() {
  final unlockPassword = '+*7=_X8<3yH:v2@s';
  final network = Network.LocalTestNet;
  final hydraAccount = 0;
  final random = Random();
  final networkConfig = NetworkConfig.fromNetwork(network, port: 4703);
  final layer1Api = Layer1Api.createApi(networkConfig);
  final layer2Api = Layer2Api.createCoeusApi(networkConfig);
  final registeredDomain = '.schema.apitest${random.nextInt(1000000)}';
  final registeredDomainData =
      '{"The_Answer_to_the_Ultimate_Question_of_Life_the_Universe_and_Everything_is":42}';

  group('api', () {
    setUpAll(() async {
      final currentHeight = await layer1Api.getCurrentHeight();

      final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
      HydraPlugin.rewind(vault, unlockPassword, network, hydraAccount);

      final hydraPlugin = HydraPlugin.get(vault, network, hydraAccount);
      final hydraPrivate = hydraPlugin.private(unlockPassword);
      final fromAddress = hydraPlugin.public.key(0).address;
      final secpPubKey =
          hydraPrivate.public.keyByAddress(fromAddress).publicKey();

      final registerOp = UserOperation.register(
        registeredDomain,
        PublicKey.fromSecp(secpPubKey).toString(),
        SubtreePolicies.create(),
        registeredDomainData,
        currentHeight + 10,
      );

      final txId = await layer1Api.sendCoeusTx(
        fromAddress,
        [registerOp],
        hydraPrivate,
      );

      Optional<TransactionStatusResponse> txStatus;
      do {
        await Future.delayed(Duration(seconds: 2));
        txStatus = await layer1Api.getTxnStatus(txId);
      } while (txStatus.isEmpty);
    });

    test('resolve', () async {
      final resp = await layer2Api.resolve(registeredDomain);

      expect(resp.isPresent, true);
      expect(resp.value, registeredDomainData);
    });

    /*test('resolve - not existing', () async {
      final resp = await layer2Api.resolve('.schema.itsnotthere');
      expect(resp.isPresent, false);
    });

    test('getMetadata', () async {
      final domain = randomDomain();
      // TODO: register a random domain

      final resp = await layer2Api.getMetadata('.schema.$domain');
      // TODO delete the domain
      expect(resp.isPresent, true);
      expect(resp.value.expiresAtHeight, 10000000000);
      expect(resp.value.owner, 'TODO');
      expect(resp.value.registraionPolicy, 'owner');
      expect(resp.value.subtreePolicies, 'TODO');
    });

    test('getMetadata - not existing', () async {
      final resp = await layer2Api.getMetadata('.schema.itsnotthere');
      expect(resp.isPresent, false);
    });

    test('getChildren', () async {
      final domain = randomDomain();
      // TODO: register a random domain
      // TODO: register some subdomains

      final resp = await layer2Api.getChildren('.schema.$domain');
      // TODO delete the domain
      expect(resp.isPresent, true);
      expect(resp.value.length, 2);
      expect(resp.value[0], '.sub1');
      expect(resp.value[1], '.sub2');
    });

    test('getChildren - not existing', () async {
      final resp = await layer2Api.getChildren('.schema.itsnotthere');
      expect(resp.isPresent, false);
    });

    test('getLastNonce', () async {
      final nonceBefore = await layer2Api.getLastNonce('TODO');
      expect(nonceBefore, 0);

      final domain = randomDomain();
      // TODO: register a random domain

      final nonceAfter = await layer2Api.getLastNonce('TODO');
      // TODO delete the domain
      expect(nonceAfter, 1);
    });*/
  });
}

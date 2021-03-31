@Timeout(Duration(seconds: 60))

import 'dart:math';

import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/layer2.dart';
import 'package:iop_sdk/network.dart';
import 'package:iop_sdk/src/coeus/operation.dart';
import 'package:test/test.dart';

import '../util.dart';

final network = Network.TestNet;
final networkConfig = NetworkConfig.fromNetwork(network);
final layer1Api = Layer1Api.createApi(networkConfig);
final layer2Api = Layer2Api.createCoeusApi(networkConfig);

Future<void> registerDomain(
  String domain,
  PublicKey owner,
  String data,
  int expiresAt,
  String fromAddress,
  HydraPrivate hydraPrivate,
) async {
  final registerOp = UserOperation.register(
    domain,
    owner,
    SubtreePolicies.create(),
    data,
    expiresAt,
  );

  final txId = await layer1Api.sendCoeusTx(
    fromAddress,
    [registerOp],
    hydraPrivate,
  );

  await waitForCoeusLayer2Confirmation(txId, true);
}

void main() async {
  final unlockPassword = '+*7=_X8<3yH:v2@s';
  final hydraAccount = 0;
  final random = Random();

  final registeredDomain = '.schema.apitest${random.nextInt(1000000)}';
  final registeredDomainData =
      '{"The_Answer_to_the_Ultimate_Question_of_Life_the_Universe_and_Everything_is":42}';
  final registeredDomainExpiresAtHeight =
      (await layer1Api.getCurrentHeight()) + 10;
  final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
  HydraPlugin.init(vault, unlockPassword, network, hydraAccount);

  final hydraPlugin = HydraPlugin.get(vault, network, hydraAccount);
  final hydraPrivate = hydraPlugin.private(unlockPassword);
  final fromAddress = hydraPlugin.public.key(0).address;
  final secpPubKey = hydraPrivate.public.keyByAddress(fromAddress).publicKey();
  final domainOwnerPublicKey = PublicKey.fromSecp(secpPubKey);

  group('api', () {
    setUpAll(() async {
      await registerDomain(
        registeredDomain,
        domainOwnerPublicKey,
        registeredDomainData,
        registeredDomainExpiresAtHeight,
        fromAddress,
        hydraPrivate,
      );
    });

    test('resolve', () async {
      final resp = await layer2Api.resolve(registeredDomain);

      expect(resp, isNotNull);
      expect(resp, registeredDomainData);
    });

    test('resolve - not existing', () async {
      final resp = await layer2Api.resolve('.schema.itsnotthere');
      expect(resp, isNull);
    });

    test('getMetadata', () async {
      final resp = await layer2Api.getMetadata(registeredDomain);
      expect(resp, isNotNull);
      expect(resp!.expiresAtHeight, registeredDomainExpiresAtHeight);
      expect(resp.owner, domainOwnerPublicKey.toString());
      expect(resp.registrationPolicy, DomainRegistrationPolicy.owner);
      expect(resp.subtreePolicies, isNotNull);
      expect(resp.subtreePolicies.expiration, isNull);
      expect(resp.subtreePolicies.schema, isNull);
    });

    test('getMetadata - not existing', () async {
      final resp = await layer2Api.getMetadata('.schema.itsnotthere');
      expect(resp, isNull);
    });

    test('getChildren', () async {
      await registerDomain(
        '$registeredDomain.sub1',
        domainOwnerPublicKey,
        '{"sub1":1}',
        registeredDomainExpiresAtHeight,
        fromAddress,
        hydraPrivate,
      );

      await registerDomain(
        '$registeredDomain.sub2',
        domainOwnerPublicKey,
        '{"sub2":1}',
        registeredDomainExpiresAtHeight,
        fromAddress,
        hydraPrivate,
      );

      final resp = await layer2Api.getChildren(registeredDomain);
      expect(resp, isNotNull);
      expect(resp!.length, 2);
      expect(resp.contains('sub1'), true);
      expect(resp.contains('sub2'), true);
    });

    test('getChildren - not existing', () async {
      final resp = await layer2Api.getChildren('.schema.itsnotthere');
      expect(resp, isNull);
    });

    test('getLastNonce', () async {
      final nonceBefore = await layer2Api.getLastNonce(domainOwnerPublicKey);

      await registerDomain(
        '$registeredDomain.sub3',
        domainOwnerPublicKey,
        '{"sub3":1}',
        registeredDomainExpiresAtHeight,
        fromAddress,
        hydraPrivate,
      );

      final nonceAfter = await layer2Api.getLastNonce(domainOwnerPublicKey);
      expect(nonceAfter, nonceBefore + 1);
    });
  });
}

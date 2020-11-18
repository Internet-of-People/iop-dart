import 'dart:math';

import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/layer2.dart';
import 'package:iop_sdk/network.dart';
import 'package:iop_sdk/src/coeus/operation.dart';
import 'package:optional/optional.dart';
import 'package:test/test.dart';

final network = Network.TestNet;
final networkConfig = NetworkConfig.fromNetwork(network, port: 4703);
final layer1Api = Layer1Api.createApi(networkConfig);
final layer2Api = Layer2Api.createCoeusApi(networkConfig);

void registerDomain(
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

  Optional<TransactionStatusResponse> txStatus;
  do {
    await Future.delayed(Duration(seconds: 2));
    txStatus = await layer1Api.getTxnStatus(txId);
  } while (txStatus.isEmpty);
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
  HydraPlugin.rewind(vault, unlockPassword, network, hydraAccount);

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

      expect(resp.isPresent, true);
      expect(resp.value, registeredDomainData);
    });

    test('resolve - not existing', () async {
      final resp = await layer2Api.resolve('.schema.itsnotthere');
      expect(resp.isPresent, false);
    });

    test('getMetadata', () async {
      final resp = await layer2Api.getMetadata(registeredDomain);
      expect(resp.isPresent, true);
      expect(resp.value.expiresAtHeight, registeredDomainExpiresAtHeight);
      expect(resp.value.owner, domainOwnerPublicKey.toString());
      expect(resp.value.registrationPolicy, DomainRegistrationPolicy.owner);
      expect(resp.value.subtreePolicies, isNotNull);
      expect(resp.value.subtreePolicies.expiration, isNull);
      expect(resp.value.subtreePolicies.schema, isNull);
    });

    test('getMetadata - not existing', () async {
      final resp = await layer2Api.getMetadata('.schema.itsnotthere');
      expect(resp.isPresent, false);
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
      expect(resp.isPresent, true);
      expect(resp.value.length, 2);
      expect(resp.value[0], 'sub1');
      expect(resp.value[1], 'sub2');
    });

    test('getChildren - not existing', () async {
      final resp = await layer2Api.getChildren('.schema.itsnotthere');
      expect(resp.isPresent, false);
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

import 'dart:math';

import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/layer2.dart';
import 'package:iop_sdk/network.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:optional/optional.dart';
import 'package:test/test.dart';

final network = Network.TestNet;
final unlockPassword = '+*7=_X8<3yH:v2@s';
final hydraAccount = 0;
final random = Random();
final layer2Api = Layer2Api.createMorpheusApi(
  NetworkConfig.fromNetwork(Network.TestNet),
);
final layer1Api = Layer1Api.createApi(NetworkConfig.fromNetwork(network));
final beforeProof = ContentId('before-proof-test${random.nextInt(1000000000)}');
var beforeProofHeight;
var beforeProofTxId;
final nonExistingDid = DidData('did:morpheus:ezqztJ6XX6GDxdSgdiySiT3a');

void main() {
  group('api', () {
    setUpAll(() async {
      final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
      HydraPlugin.rewind(vault, unlockPassword, network, hydraAccount);

      final hydraPlugin = HydraPlugin.get(vault, network, hydraAccount);
      final hydraPrivate = hydraPlugin.private(unlockPassword);

      final opAttempts = MorpheusAssetBuilder.create()
          .addRegisterBeforeProof(beforeProof)
          .build();

      final senderAddress = hydraPlugin.public.key(0).address;

      // TODO: querying tx does NOT return block height just id and
      // we don't have an api that returns a block information based on an id.
      beforeProofHeight = await layer1Api.getCurrentHeight();

      beforeProofTxId = await layer1Api.sendMorpheusTx(
        senderAddress,
        opAttempts,
        hydraPrivate,
      );

      final layer2Api = Layer2Api.createMorpheusApi(
        NetworkConfig.fromNetwork(network),
      );

      Optional<bool> txStatus;
      do {
        await Future.delayed(Duration(seconds: 2));
        txStatus = await layer2Api.getTxnStatus(beforeProofTxId);
      } while (txStatus.isEmpty);
      expect(txStatus, Optional.of(true));
    });

    test('getBeforeProofHistory', () async {
      final resp = await layer2Api.getBeforeProofHistory(beforeProof);
      expect(resp.contentId, beforeProof);
      expect(resp.existsFromHeight, isPositive);
      expect(resp.queriedAtHeight, isPositive);
    });

    test('getBeforeProofHistory - non existing', () async {
      final resp = await layer2Api.getBeforeProofHistory(
        ContentId('not-existing'),
      );
      expect(resp.contentId, ContentId('not-existing'));
      expect(resp.existsFromHeight, isNull);
      expect(resp.queriedAtHeight, isNotNull);
    });

    test('beforeProofExists', () async {
      final resp1 = await layer2Api.beforeProofExists(beforeProof);
      expect(resp1, true);

      final resp2 = await layer2Api.beforeProofExists(
        beforeProof,
        height: beforeProofHeight,
      );
      expect(resp2, false);

      final resp3 = await layer2Api.beforeProofExists(
        beforeProof,
        // TODO: we currently don't have the exact height, see the comment above
        height: beforeProofHeight + 5,
      );
      expect(resp3, true);
    });

    test('beforeProofExists - not existing', () async {
      final resp = await layer2Api.beforeProofExists(ContentId('not-existing'));
      expect(resp, false);
    });

    // TODO
    /*test('getDidDocument', () async {
      final resp = await layer2Api.getDidDocument(
        existingDid,
      );
      expect(resp.height, isNotNull);
      expect(resp.did, existingDid);
    });*/

    test('getDidDocument - not existing', () async {
      final resp = await layer2Api.getDidDocument(nonExistingDid);
      expect(resp.height, isNotNull);
      expect(resp.did, nonExistingDid);
    });

    test('getTxnStatus', () async {
      final resp = await layer2Api.getTxnStatus(beforeProofTxId);
      expect(resp.isPresent, true);
      expect(resp.value, true);
    });

    test('getTxnStatus - not existing', () async {
      final resp = await layer2Api.getTxnStatus('not-existing');
      expect(resp.isPresent, false);
    });

    // TODO
    /*test('getLastTxId', () async {
      final resp = await layer2Api.getLastTxId(existingDid);
      expect(resp, isNotNull);
    });*/

    test('getLastTxId - not existing', () async {
      final resp = await layer2Api.getLastTxId(nonExistingDid);
      expect(resp, isNull);
    });

    // TODO
    /*test('getDidTransactionIds', () async {
      final resp = await layer2Api.getDidTransactionIds(existingDid, 1);
      expect(resp.length, greaterThan(0));
    });

    test('getDidTransactionIds - not existing', () async {
      final resp = await layer2Api.getDidTransactionIds(nonExistingDid, 1);
      expect(resp, isEmpty);
    });

    test('getDidTransactionAttemptIds', () async {
      final resp = await layer2Api.getDidTransactionAttemptIds(existingDid, 1);
      expect(resp.length, greaterThan(0));
    });*/

    test('getDidTransactionAttemptIds - not existing', () async {
      final resp =
          await layer2Api.getDidTransactionAttemptIds(nonExistingDid, 1);
      expect(resp, isEmpty);
    });

    // TODO
    /*test('getDidOperations', () async {
      final resp = await layer2Api.getDidOperations(existingDid, 1);
      expect(resp.length, greaterThan(0));
    });*/

    test('getDidOperations - not existing', () async {
      final resp = await layer2Api.getDidOperations(nonExistingDid, 1);
      expect(resp, isEmpty);
    });

    // TODO
    /*test('getDidOperationAttempts', () async {
      final resp = await layer2Api.getDidOperationAttempts(existingDid, 1);
      expect(resp.length, greaterThan(0));
    });*/

    test('getDidOperationAttempts - not existing', () async {
      final resp = await layer2Api.getDidOperationAttempts(nonExistingDid, 1);
      expect(resp, isEmpty);
    });

    test('checkTransactionValidity - valid tx / simple op', () async {
      final beforeProofOp = RegisterBeforeProofData(ContentId('contentId'));
      final resp = await layer2Api.checkTransactionValidity([beforeProofOp]);
      expect(resp, isEmpty);
    });

    // TODO
    /*test('checkTransactionValidity - valid tx / signed ops', () async {
      final vault = TestVault.create();
      final lastTxId = await layer2Api.getLastTxId(existingDid);
      final tombstoneOp = TombstoneDidData(existingDid, lastTxId);
      final signedOp = SignedOperationAttemptsBuilder.tempSign(
        vault.morpheusPrivate,
        vault.id,
        [tombstoneOp],
      );
      final r = await layer2Api.checkTransactionValidity([signedOp]);
      expect(r, isEmpty);
    });*/

    test('checkTransactionValidity - invalid tx', () async {
      final tombstoneOp = TombstoneDidData(DidData('invalid_did'), 'invalid');
      final signedOp = SignedOperationsData(
        [tombstoneOp],
        PublicKeyData('invalid'),
        SignatureData('invalid'),
      );
      final resp = await layer2Api.checkTransactionValidity([signedOp]);
      expect(resp.length, 1);
    });
  });
}

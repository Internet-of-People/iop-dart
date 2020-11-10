import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/layer2.dart';
import 'package:iop_sdk/network.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:test/test.dart';

import '../util.dart';

void main() {
  final existingDid = DidData('did:morpheus:ezqztJ6XX6GDxdSgdiySiT3J');
  final nonExistingDid = DidData('did:morpheus:ezqztJ6XX6GDxdSgdiySiT3a');
  final existingBeforeProof = ContentId(
    'cju6m5xQ-8oSsIY0k9qpOjFIFinmGTpdxw2siJnVPInLCg',
  );
  final api = Layer2Api.createMorpheusApi(
    NetworkConfig.fromNetwork(Network.TestNet),
  );

  group('api', () {
    test('getBeforeProofHistory', () async {
      final resp = await api.getBeforeProofHistory(existingBeforeProof);
      expect(resp.contentId, existingBeforeProof);
      expect(resp.existsFromHeight, 890554);
      expect(resp.queriedAtHeight, isNotNull);
    });

    test('getBeforeProofHistory - non existing', () async {
      final resp = await api.getBeforeProofHistory(ContentId('not-existing'));
      expect(resp.contentId, ContentId('not-existing'));
      expect(resp.existsFromHeight, isNull);
      expect(resp.queriedAtHeight, isNotNull);
    });

    test('beforeProofExists', () async {
      final resp1 = await api.beforeProofExists(existingBeforeProof);
      expect(resp1, true);

      final resp2 = await api.beforeProofExists(
        existingBeforeProof,
        height: 890553,
      );
      expect(resp2, false);

      final resp3 = await api.beforeProofExists(
        existingBeforeProof,
        height: 890554,
      );
      expect(resp3, true);
    });

    test('beforeProofExists - not existing', () async {
      final resp = await api.beforeProofExists(ContentId('not-existing'));
      expect(resp, false);
    });

    test('getDidDocument', () async {
      final resp = await api.getDidDocument(
        existingDid,
      );
      expect(resp.height, isNotNull);
      expect(resp.did, existingDid);
    });

    test('getDidDocument - not existing', () async {
      final resp = await api.getDidDocument(nonExistingDid);
      expect(resp.height, isNotNull);
      expect(resp.did, nonExistingDid);
    });

    test('getTxnStatus', () async {
      final resp = await api.getTxnStatus(
        '2041630ba5c0947759847f0e278f3d7eb17f561196b3116191fb84626d5a0462',
      );
      expect(resp.isPresent, true);
      expect(resp.value, true);
    });

    test('getTxnStatus - not existing', () async {
      final resp = await api.getTxnStatus('not-existing');
      expect(resp.isPresent, false);
    });

    test('getLastTxId', () async {
      final resp = await api.getLastTxId(existingDid);
      expect(resp, isNotNull);
    });

    test('getLastTxId - not existing', () async {
      final resp = await api.getLastTxId(nonExistingDid);
      expect(resp, isNull);
    });

    test('getDidTransactionIds', () async {
      final resp = await api.getDidTransactionIds(existingDid, 1);
      expect(resp.length, greaterThan(0));
    });

    test('getDidTransactionIds - not existing', () async {
      final resp = await api.getDidTransactionIds(nonExistingDid, 1);
      expect(resp, isEmpty);
    });

    test('getDidTransactionAttemptIds', () async {
      final resp = await api.getDidTransactionAttemptIds(existingDid, 1);
      expect(resp.length, greaterThan(0));
    });

    test('getDidTransactionAttemptIds - not existing', () async {
      final resp = await api.getDidTransactionAttemptIds(nonExistingDid, 1);
      expect(resp, isEmpty);
    });

    test('getDidOperations', () async {
      final resp = await api.getDidOperations(existingDid, 1);
      expect(resp.length, greaterThan(0));
    });

    test('getDidOperations - not existing', () async {
      final resp = await api.getDidOperations(nonExistingDid, 1);
      expect(resp, isEmpty);
    });

    test('getDidOperationAttempts', () async {
      final resp = await api.getDidOperationAttempts(existingDid, 1);
      expect(resp.length, greaterThan(0));
    });

    test('getDidOperationAttempts - not existing', () async {
      final resp = await api.getDidOperationAttempts(nonExistingDid, 1);
      expect(resp, isEmpty);
    });

    test('checkTransactionValidity - valid tx / simple op', () async {
      final beforeProofOp = RegisterBeforeProofData(ContentId('contentId'));
      final resp = await api.checkTransactionValidity([beforeProofOp]);
      expect(resp, isEmpty);
    });

    test('checkTransactionValidity - valid tx / signed ops', () async {
      final vault = TestVault.create();
      final lastTxId = await api.getLastTxId(existingDid);
      final tombstoneOp = TombstoneDidData(existingDid, lastTxId);
      final signedOp = SignedOperationAttemptsBuilder.tempSign(
        vault.morpheusPrivate,
        vault.id,
        [tombstoneOp],
      );
      final r = await api.checkTransactionValidity([signedOp]);
      expect(r, isEmpty);
    });

    test('checkTransactionValidity - invalid tx', () async {
      final tombstoneOp = TombstoneDidData(DidData('invalid_did'), 'invalid');
      final signedOp = SignedOperationsData(
        [tombstoneOp],
        PublicKeyData('invalid'),
        SignatureData('invalid'),
      );
      final resp = await api.checkTransactionValidity([signedOp]);
      expect(resp.length, 1);
    });
  });
}

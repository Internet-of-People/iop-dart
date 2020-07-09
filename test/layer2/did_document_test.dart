import 'package:morpheus_sdk/crypto/authentication.dart';
import 'package:morpheus_sdk/crypto/io.dart';
import 'package:morpheus_sdk/layer2/did_document.dart';
import 'package:morpheus_sdk/ssi/io.dart';
import 'package:test/test.dart';

void main() {
  final authData1 = AuthenticationData('iezqztJ6XX6GDxdSgdiySiT3a');
  final authData2 = AuthenticationData('iezqztJ6XX6GDxdSgdiySiT3b');
  final auth1 = authenticationFromData(authData1);
  final auth2 = authenticationFromData(authData2);

  group('DidDocument', () {
    test('fromData', () {
      final defaultKey = KeyData(0, authData1, null, null, true);
      final updateHistory1 = KeyRightHistory(
        KeyLink('#0'),
        [KeyRightHistoryPoint(null, true)],
        true,
      );
      final impersonateHistory1 = KeyRightHistory(
        KeyLink('#0'),
        [KeyRightHistoryPoint(null, true)],
        true,
      );
      final data = DidDocumentData(
        DidData('did'),
        [defaultKey],
        {
          'update': [updateHistory1],
          'impersonate': [impersonateHistory1],
        },
        false,
        null,
        42,
      );
      final didDoc = DidDocument(data);

      expect(didDoc.did, DidData('did'));
      expect(didDoc.height, 42);
      expect(didDoc.hasRightAt(auth1, 'update', 1), true);
    });

    test('hasRightAt', () {
      final defaultKey = KeyData(0, authData1, null, null, true);
      final updateHistory1 = KeyRightHistory(
        KeyLink('#0'),
        [KeyRightHistoryPoint(null, true), KeyRightHistoryPoint(10, false)],
        false,
      );
      final impersonateHistory1 = KeyRightHistory(
        KeyLink('#0'),
        [KeyRightHistoryPoint(null, true)],
        true,
      );
      final data = DidDocumentData(
        DidData('did'),
        [defaultKey],
        {
          'update': [updateHistory1],
          'impersonate': [impersonateHistory1],
        },
        false,
        null,
        42,
      );
      final didDoc = DidDocument(data);

      expect(didDoc.did, DidData('did'));
      expect(didDoc.height, 42);
      expect(didDoc.hasRightAt(auth1, 'update', 9), true);
      expect(didDoc.hasRightAt(auth1, 'update', 10), false);
      expect(didDoc.hasRightAt(auth2, 'update', 1), false);
      expect(didDoc.hasRightAt(auth2, 'impersonate', 1), false);
    });

    test('isTombstonedAt', () {
      final defaultKey = KeyData(0, authData1, null, null, true);
      final updateHistory1 = KeyRightHistory(
        KeyLink('#0'),
        [KeyRightHistoryPoint(null, true)],
        true,
      );
      final impersonateHistory1 = KeyRightHistory(
        KeyLink('#0'),
        [KeyRightHistoryPoint(null, true)],
        true,
      );
      final data = DidDocumentData(
        DidData('did'),
        [defaultKey],
        {
          'update': [updateHistory1],
          'impersonate': [impersonateHistory1],
        },
        true,
        10,
        42,
      );
      final didDoc = DidDocument(data);

      expect(didDoc.did, DidData('did'));
      expect(didDoc.height, 42);
      expect(didDoc.isTombstonedAt(9), false);
      expect(didDoc.isTombstonedAt(10), true);
    });
  });
}

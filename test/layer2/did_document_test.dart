import 'package:morpheus_sdk/crypto/authentication.dart';
import 'package:morpheus_sdk/crypto/core.dart';
import 'package:morpheus_sdk/layer2/did_document.dart';
import 'package:test/test.dart';

void main() {
  final authData = 'iezqztJ6XX6GDxdSgdiySiT3a';
  final auth = authenticationFromData(authData);

  group('DidDocument', () {
    test('fromData', () {
      final defaultKey = KeyData(0, authData, null, null, true);
      final updateHistory1 = KeyRightHistory(
        '#0',
        [KeyRightHistoryPoint(null, true)],
        true,
      );
      final impersonateHistory1 = KeyRightHistory(
        '#0',
        [KeyRightHistoryPoint(null, true)],
        true,
      );
      final data = DidData(
        'did',
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

      expect(didDoc.did, 'did');
      expect(didDoc.height, 42);
      expect(didDoc.hasRightAt(auth, 'update', 1), true);
    });
  });
}

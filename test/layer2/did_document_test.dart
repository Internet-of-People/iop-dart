import 'package:iop_sdk/crypto/authentication.dart';
import 'package:iop_sdk/crypto/io.dart';
import 'package:iop_sdk/layer2/did_document.dart';
import 'package:test/test.dart';

void main() {
  final authData1 = AuthenticationData('iezqztJ6XX6GDxdSgdiySiT3a');
  final authData2 = AuthenticationData('iezqztJ6XX6GDxdSgdiySiT3b');
  final auth1 = authenticationFromData(authData1);
  final auth2 = authenticationFromData(authData2);

  group('DidDocument', () {
    test('fromData', () {
      final didDoc = DidDocument(DidDocumentData.fromJson({
        'did': 'did',
        'keys': [
          {
            'index': 0,
            'auth': authData1.value,
            'validFromHeight': null,
            'validUntilHeight': null,
            'valid': true,
          }
        ],
        'rights': {
          'update': [
            {
              'keyLink': '#0',
              'history': [
                {'height': null, 'valid': true}
              ],
              'valid': true
            }
          ],
          'impersonate': [
            {
              'keyLink': '#0',
              'history': [
                {'height': null, 'valid': true}
              ],
              'valid': true
            }
          ],
        },
        'tombstoned': false,
        'tombstonedAtHeight': null,
        'queriedAtHeight': 42,
      }));

      expect(didDoc.did, DidData('did'));
      expect(didDoc.height, 42);
      expect(didDoc.hasRightAt(auth1, 'update', 1), true);
    });

    test('hasRightAt', () {
      final didDoc = DidDocument(DidDocumentData.fromJson({
        'did': 'did',
        'keys': [
          {
            'index': 0,
            'auth': authData1.value,
            'validFromHeight': null,
            'validUntilHeight': null,
            'valid': true,
          }
        ],
        'rights': {
          'update': [
            {
              'keyLink': '#0',
              'history': [
                {'height': null, 'valid': true},
                {'height': 10, 'valid': false}
              ],
              'valid': true
            }
          ],
          'impersonate': [
            {
              'keyLink': '#0',
              'history': [
                {'height': null, 'valid': true}
              ],
              'valid': true
            }
          ],
        },
        'tombstoned': false,
        'tombstonedAtHeight': null,
        'queriedAtHeight': 42,
      }));

      expect(didDoc.did, DidData('did'));
      expect(didDoc.height, 42);
      expect(didDoc.hasRightAt(auth1, 'update', 9), true);
      expect(didDoc.hasRightAt(auth1, 'update', 10), false);
      expect(didDoc.hasRightAt(auth2, 'update', 1), false);
      expect(didDoc.hasRightAt(auth2, 'impersonate', 1), false);
    });

    test('isTombstonedAt', () {
      final didDoc = DidDocument(DidDocumentData.fromJson({
        'did': 'did',
        'keys': [
          {
            'index': 0,
            'auth': authData1.value,
            'validFromHeight': null,
            'validUntilHeight': null,
            'valid': true,
          }
        ],
        'rights': {
          'update': [
            {
              'keyLink': '#0',
              'history': [
                {'height': null, 'valid': true}
              ],
              'valid': true
            }
          ],
          'impersonate': [
            {
              'keyLink': '#0',
              'history': [
                {'height': null, 'valid': true}
              ],
              'valid': true
            }
          ],
        },
        'tombstoned': true,
        'tombstonedAtHeight': 10,
        'queriedAtHeight': 42,
      }));

      expect(didDoc.did, DidData('did'));
      expect(didDoc.height, 42);
      expect(didDoc.isTombstonedAt(9), false);
      expect(didDoc.isTombstonedAt(10), true);
    });
  });
}

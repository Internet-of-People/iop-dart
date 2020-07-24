import 'dart:convert';
import 'package:morpheus_sdk/crypto/io.dart';
import 'package:morpheus_sdk/layer1/builder.dart';
import 'package:morpheus_sdk/layer1/operation_data.dart';
import 'package:test/test.dart';

import '../util.dart';

void main() {
  final did = DidData('did:morpheus:ezqztJ6XX6GDxdSgdiySiT3J');

  group('serialization and signing', () {
    test('tombstoneDid', () {
      final vault = TestVault.create();
      final tombstoneOp = TombstoneDidData(did, null);
      final signedOp = SignedOperationAttemptsBuilder.tempSign(
        vault.morpheusPrivate,
        vault.id,
        [tombstoneOp],
      );

      final opBytes = SignedOperationsData.serialize(signedOp.signables);
      // The first 'backslash' char is a varint 92, which is the length of the rest
      expect(
        utf8.decode(opBytes.buffer.asUint8List()),
        '\\[{"did":"did:morpheus:ezqztJ6XX6GDxdSgdiySiT3J","lastTxId":null,"operation":"tombstoneDid"}]',
      );

      expect(
        signedOp.signerPublicKey.value,
        'pez2CLkBUjHB8w8G87D3YkREjpRuiqPu6BrRsgHMQy2Pzt6',
      );
      expect(
        signedOp.signature.value,
        'sez8Bn49WGpBwMtinjzSixarhWw2jZY815vafwzdtP4QGcSzQkBxbGL5vA86q2Wt1Y6wUhXpzktxWXq7Yq6YKfzmkfu',
      );
    });
  });
}

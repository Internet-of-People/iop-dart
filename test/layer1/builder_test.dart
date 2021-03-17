import 'dart:convert';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/layer1.dart';
import 'package:test/test.dart';

import '../util.dart';

void main() {
  final did = Did.fromString('did:morpheus:ezqztJ6XX6GDxdSgdiySiT3J');

  group('serialization and signing', () {
    test('tombstoneDid', () {
      final vault = TestVault.create();
      final morpheusPrivate = vault.morpheusPrivate;
      final tombstoneOp =
          MorpheusOperationBuilder.create(did, null).tombstoneDid();

      final signedOps = MorpheusOperationSigner.create()
          .add(tombstoneOp)
          .sign(morpheusPrivate, did.defaultKeyId());
      final signedOpsData =
          SignedOperationsData.fromJson(json.decode(signedOps.toString()));

      expect(
        signedOpsData.signerPublicKey.value,
        'pez2CLkBUjHB8w8G87D3YkREjpRuiqPu6BrRsgHMQy2Pzt6',
      );
      expect(
        signedOpsData.signature.value,
        'sez8Bn49WGpBwMtinjzSixarhWw2jZY815vafwzdtP4QGcSzQkBxbGL5vA86q2Wt1Y6wUhXpzktxWXq7Yq6YKfzmkfu',
      );
    });
  });
}

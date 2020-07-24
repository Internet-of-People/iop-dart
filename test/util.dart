import 'dart:convert';

import 'package:http/http.dart';
import 'package:morpheus_sdk/crypto/core.dart';
import 'package:morpheus_sdk/crypto/did.dart';
import 'package:morpheus_sdk/crypto/io.dart';
import 'package:morpheus_sdk/crypto/morpheus_plugin.dart';
import 'package:morpheus_sdk/crypto/multicipher.dart';
import 'package:morpheus_sdk/crypto/vault.dart';
import 'package:morpheus_sdk/entities/verifier/io.dart';
import 'package:morpheus_sdk/ssi/io.dart';
import 'package:test/test.dart';

Response resp(String body, {int code = 200}) {
  return Response(body, code);
}

class TestVault {
  final MorpheusPrivate morpheusPrivate;
  final Did did;
  final KeyId id;

  TestVault._(this.morpheusPrivate, this.did, this.id);

  DidData get didData => DidData(did.toString());

  static TestVault create() {
    final unlockPassword = 'unlock';
    final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
    MorpheusPlugin.rewind(vault, unlockPassword);
    final morpheusPlugin = MorpheusPlugin.get(vault);
    final morpheusPrivate = morpheusPlugin.private(unlockPassword);
    final did = morpheusPrivate.personas.did(0);
    expect(did.toString(), 'did:morpheus:ezqztJ6XX6GDxdSgdiySiT3J');
    final id = did.defaultKeyId();
    expect(id.toString(), 'iezqztJ6XX6GDxdSgdiySiT3J');
    return TestVault._(morpheusPrivate, did, id);
  }

  Signed<WitnessRequest> createSignedWitnessRequest() {
    final claimString = '{"apple":{}}';
    final evidenceString = '{"banana":{}}';
    final claim = Claim(
      didData,
      Content<DynamicContent>.fromJson(json.decode(claimString)),
    );
    expect(claim.content.content.content.containsKey('apple'), true);
    final claimant = KeyLink('#0');
    final evidence = Content<DynamicContent>.fromJson(
      json.decode(evidenceString),
    );
    final nonce = nonce264();
    final request = WitnessRequest(
      claim,
      claimant,
      ContentId('processId'),
      evidence,
      nonce,
    );

    return morpheusPrivate.signWitnessRequest(id, request);
  }

  Signed<WitnessStatement> createSignedWitnessStatement() {
    final signedWitnessRequest = createSignedWitnessRequest();
    final claim = signedWitnessRequest.content.content.claim;
    final processId = signedWitnessRequest.content.content.processId;
    final constraint = Constraint(
      null,
      null,
      KeyLink('#0'),
      DidData(did.toString()),
      null,
    );
    final statement = WitnessStatement(
      Content(claim, null),
      processId,
      constraint,
      null,
    );
    return morpheusPrivate.signWitnessStatement(id, statement);
  }

  Signed<Presentation> createSignedPresentation() {
    final signedWitnessStatement = createSignedWitnessStatement();
    final nonce = nonce264();
    final issuedTo = didData;
    final purpose = 'Inspection at gate';
    final validFrom = DateTime.now().toUtc();
    final validUntil = validFrom.add(Duration(days: 5));
    final license = License(issuedTo, purpose, validFrom, validUntil);
    final provenClaim = ProvenClaim(
      signedWitnessStatement.content.content.claim.content,
      [signedWitnessStatement],
    );
    final presentation = Presentation([provenClaim], [license], nonce);
    return morpheusPrivate.signClaimPresentation(id, presentation);
  }

  ValidationRequest createValidationRequest() {
    final statement = createSignedWitnessStatement();

    final publicKey = statement.signature.publicKey;
    final contentId = selectiveDigestJson(
      statement.content.content.toJson(),
      '',
    );
    final signature = statement.signature.bytes;
    final onBehalfOf = didData;
    final afterProof = null;
    return ValidationRequest(
      publicKey,
      contentId,
      signature,
      onBehalfOf,
      afterProof,
    );
  }
}

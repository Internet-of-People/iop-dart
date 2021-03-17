import 'dart:convert';

import 'package:http/http.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/layer2.dart';
import 'package:iop_sdk/network.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_sdk/verifier.dart';
import 'package:optional/optional.dart';
import 'package:test/test.dart';


final networkConfig = NetworkConfig.fromNetwork(Network.TestNet);
final layer1 = Layer1Api.createApi(networkConfig);
final coeusLayer2 = Layer2Api.createCoeusApi(networkConfig);
final morpheusLayer2 = Layer2Api.createMorpheusApi(networkConfig);

// TODO generalize the different waitFor...Confirmation functions below
//      with too much shared implementeation
Future<void> waitForLayer1Confirmation(String txId, bool expected) async
{
  bool success;
  for (var i = 0; i < 12; i++) {
    await Future.delayed(const Duration(seconds: 2));
    final status = await layer1.getTxnStatus(txId);
    if (status.isPresent && status.value.id == txId) {
      success = true;
      break;
    }
  }
  expect(success, expected);
}

Future<void> waitForCoeusLayer2Confirmation(String txId, bool expected) async
{
  var txStatus = Optional.empty();
  do {
    await Future.delayed(Duration(seconds: 2));
    txStatus = await coeusLayer2.getTxnStatus(txId);
  } while (txStatus.isEmpty);
  final success = txStatus.value;
  expect(success, expected);
}

Future<void> waitForMorpheusLayer2Confirmation(String txId, bool expected) async
{
  var txStatus = Optional.empty();
  do {
    await Future.delayed(Duration(seconds: 2));
    txStatus = await morpheusLayer2.getTxnStatus(txId);
  } while (txStatus.isEmpty);
  final success = txStatus.value;
  expect(success, expected);
}


Response resp(String body, {int code = 200}) {
  return Response(body, code);
}

bool validateJwtToken(String token, PublicKey publicKey, { String contentId }) {
  try {
    final parser = JwtParser.create(token);
    var result = parser.publicKey.toString() == publicKey.toString();
    if (contentId != null) {
      result &= parser.contentId == contentId;
    }
    parser.dispose();
    return result;
  }
  catch (e) {
    print('Token validation failed: $e');
    return false;
  }
}


class TestVault {
  final MorpheusPrivate morpheusPrivate;
  final Did did;
  final PrivateKey privateKey;
  final KeyId id;

  TestVault._(this.morpheusPrivate, this.privateKey, this.did, this.id);

  DidData get didData => DidData(did.toString());

  static TestVault create() {
    final unlockPassword = 'unlock';
    final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
    MorpheusPlugin.init(vault, unlockPassword);
    final morpheusPlugin = MorpheusPlugin.get(vault);
    final morpheusPrivate = morpheusPlugin.private(unlockPassword);
    final privateKey = morpheusPrivate.personas.key(0).privateKey();
    final did = morpheusPrivate.personas.did(0);
    expect(did.toString(), 'did:morpheus:ezqztJ6XX6GDxdSgdiySiT3J');
    final id = did.defaultKeyId();
    expect(id.toString(), 'iezqztJ6XX6GDxdSgdiySiT3J');
    return TestVault._(morpheusPrivate, privateKey, did, id);
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

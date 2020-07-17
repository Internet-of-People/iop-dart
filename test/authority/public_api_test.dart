import 'dart:convert';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:morpheus_sdk/crypto/core.dart';
import 'package:morpheus_sdk/crypto/did.dart';
import 'package:morpheus_sdk/crypto/io.dart';
import 'package:morpheus_sdk/crypto/morpheus_plugin.dart';
import 'package:morpheus_sdk/crypto/multicipher.dart';
import 'package:morpheus_sdk/crypto/vault.dart';
import 'package:morpheus_sdk/entities/authority/io.dart';
import 'package:morpheus_sdk/entities/authority/public_api.dart';
import 'package:morpheus_sdk/entities/io.dart';
import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/ssi/io.dart';
import 'package:test/test.dart';

import '../util.dart';

final processesResponse = '''{
  "processes": [
    "cjuc1fS3_nrxuK0bRr3P3jZeFeT51naOCMXDPekX8rPqho",
    "cjunI8lB1BEtampkcvotOpF-zr1XmsCRNvntciGl3puOkg",
    "cjujqhFEN_T2BV-TcyGNTHNeUds3m8aAc-vIWUdZSyK9Sw"
  ]
}
''';

class MockApiConfig extends Mock implements ApiConfig {}

class MockClient extends Mock implements Client {}

void main() {
  final client = MockClient();
  final config = MockApiConfig();
  when(config.client).thenReturn(client);
  when(config.host).thenReturn('http://host');
  when(config.port).thenReturn(80);
  final api = AuthorityPublicApi(config);
  final baseUrl = 'http://host:80';

  group('AuthorityPublicApi', () {
    test('listProcesses', () async {
      when(
        client.get('$baseUrl/processes', headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp(processesResponse)));

      final r = await api.listProcesses();
      expect(r.length, 3);
      expect(r[0], ContentId('cjuc1fS3_nrxuK0bRr3P3jZeFeT51naOCMXDPekX8rPqho'));
      expect(r[1], ContentId('cjunI8lB1BEtampkcvotOpF-zr1XmsCRNvntciGl3puOkg'));
      expect(r[2], ContentId('cjujqhFEN_T2BV-TcyGNTHNeUds3m8aAc-vIWUdZSyK9Sw'));
    });

    test('listProcesses - not http200', () async {
      when(
        client.get('$baseUrl/processes', headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp('', code: 500)));

      expect(
        api.listProcesses(),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });

    test('getPublicBlob', () async {
      final id = ContentId('contentId');
      when(
        client.get('$baseUrl/blob/${id.value}', headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp('BLOB')));

      final r = await api.getPublicBlob(id);
      expect(r.isPresent, true);
      expect(r.value, 'BLOB');
    });

    test('getPublicBlob - http404', () async {
      final id = ContentId('contentId');
      when(
        client.get('$baseUrl/blob/${id.value}', headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp('', code: 404)));

      final r = await api.getPublicBlob(id);
      expect(r.isPresent, false);
    });

    test('getPublicBlob - not http200/404', () async {
      final id = ContentId('contentId');
      when(
        client.get('$baseUrl/blob/${id.value}', headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp('', code: 500)));

      expect(
        api.getPublicBlob(id),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });

    test('sendRequest', () async {
      final signedWitnessRequest =
          Fixture.create().createSignedWitnessRequest();
      final link = CapabilityLink('link');
      when(client.post(
        '$baseUrl/requests',
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp(link.value, code: 202)),
      );

      final r = await api.sendRequest(signedWitnessRequest);

      expect(r, link);
    });

    test('sendRequest - not http202', () async {
      final signedWitnessRequest =
          Fixture.create().createSignedWitnessRequest();
      when(client.post(
        '$baseUrl/requests',
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      final rFut = api.sendRequest(signedWitnessRequest);

      await expectLater(rFut, throwsA(const TypeMatcher<HttpResponseError>()));
    });

    test('getRequestStatus - pending', () async {
      final status = RequestStatus(Status.pending, null, null);
      final link = CapabilityLink('link');
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp(json.encode(status.toJson()), code: 200)),
      );

      final r = await api.getRequestStatus(link);

      expect(r.isPresent, true);
    });

    test('getRequestStatus - approved', () async {
      final signedWitnessStatement =
          Fixture.create().createSignedWitnessStatement();
      final link = CapabilityLink('link');
      final status =
          RequestStatus(Status.approved, signedWitnessStatement, null);
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp(json.encode(status.toJson()), code: 200)),
      );

      final r = await api.getRequestStatus(link);

      expect(r.isPresent, true);
    });

    test('getRequestStatus - rejected', () async {
      final link = CapabilityLink('link');
      final status = RequestStatus(Status.rejected, null, 'blurred image');
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp(json.encode(status.toJson()), code: 200)),
      );

      final r = await api.getRequestStatus(link);

      expect(r.isPresent, true);
    });

    test('getRequestStatus - http404', () async {
      final link = CapabilityLink('link');
      when(client.get(
        '$baseUrl/requests/${link.value}/status',
        headers: anyNamed('headers'),
      )).thenAnswer((_) => Future.value(resp('', code: 404)));

      final r = await api.getRequestStatus(link);

      expect(r.isPresent, false);
    });

    test('getRequestStatus - not http200/404', () async {
      final link = CapabilityLink('link');
      when(client.get(
        '$baseUrl/requests/${link.value}/status',
        headers: anyNamed('headers'),
      )).thenAnswer((_) => Future.value(resp('', code: 500)));

      expect(
        api.getRequestStatus(link),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });
  });
}

class Fixture {
  final MorpheusPrivate morpheusPrivate;
  final Did did;
  final KeyId id;

  Fixture._(this.morpheusPrivate, this.did, this.id);

  static Fixture create() {
    final unlockPassword = 'unlock';
    final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
    MorpheusPlugin.rewind(vault, unlockPassword);
    final morpheusPlugin = MorpheusPlugin.get(vault);
    final morpheusPrivate = morpheusPlugin.private(unlockPassword);
    final did = morpheusPrivate.personas.did(0);
    expect(did.toString(), 'did:morpheus:ezqztJ6XX6GDxdSgdiySiT3J');
    final id = did.defaultKeyId();
    expect(id.toString(), 'iezqztJ6XX6GDxdSgdiySiT3J');
    return Fixture._(morpheusPrivate, did, id);
  }

  Signed<WitnessRequest> createSignedWitnessRequest() {
    final claimString = '{"apple":{}}';
    final evidenceString = '{"banana":{}}';
    final claim = Claim(DidData(did.toString()),
        Content<DynamicContent>.fromJson(json.decode(claimString)));
    final claimant = KeyLink('#0');
    final evidence =
        Content<DynamicContent>.fromJson(json.decode(evidenceString));
    final nonce = Nonce(DartApi.instance.nonce264());
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
    final constraint =
        Constraint(null, null, KeyLink('#0'), DidData(did.toString()), null);
    final statement =
        WitnessStatement(Content(claim, null), processId, constraint, null);
    return morpheusPrivate.signWitnessStatement(id, statement);
  }
}

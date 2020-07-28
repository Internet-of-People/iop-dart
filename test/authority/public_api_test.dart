import 'dart:convert';
import 'package:http/http.dart';
import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_sdk/utils.dart';
import 'package:mockito/mockito.dart';
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
          TestVault.create().createSignedWitnessRequest();
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
          TestVault.create().createSignedWitnessRequest();
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
      expect(r.value.status, Status.pending);
      expect(r.value.signedStatement, null);
      expect(r.value.rejectionReason, null);
    });

    test('getRequestStatus - approved', () async {
      final signedWitnessStatement =
          TestVault.create().createSignedWitnessStatement();
      final link = CapabilityLink('link');
      final status =
          RequestStatus(Status.approved, signedWitnessStatement, null);
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp(json.encode(status.toJson()), code: 200)),
      );

      final r = await api.getRequestStatus(link);

      expect(r.isPresent, true);
      expect(r.value.status, Status.approved);
      expect(r.value.signedStatement.signature.publicKey.value,
          'pez2CLkBUjHB8w8G87D3YkREjpRuiqPu6BrRsgHMQy2Pzt6');
      expect(r.value.rejectionReason, null);
    });

    test('getRequestStatus - rejected', () async {
      final link = CapabilityLink('link');
      final status = RequestStatus(Status.rejected, null, 'blurred image');
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp(json.encode(status.toJson()), code: 200)),
      );

      final r = await api.getRequestStatus(link);

      expect(r.isPresent, true);
      expect(r.value.status, Status.rejected);
      expect(r.value.signedStatement, null);
      expect(r.value.rejectionReason, 'blurred image');
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

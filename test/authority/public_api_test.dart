import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:morpheus_sdk/entities/authority/io.dart';
import 'package:morpheus_sdk/entities/authority/public_api.dart';
import 'package:morpheus_sdk/entities/io.dart';
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
      when(client.post(
        '$baseUrl/requests',
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('link', code: 202)),
      );

      /*final unlockPassword = 'unlock';
      final vault = Vault.create(Bip39.DEMO_PHRASE, '', unlockPassword);
      MorpheusPlugin.rewind(vault, unlockPassword);
      final morpheusPlugin = MorpheusPlugin.get(vault);
      final morpheusPrivate = morpheusPlugin.private(unlockPassword);

      final claim = Claim(DidData('did'), ...);
      final claimant = KeyLink();
      final evidence = Content<DynamicContent>(...);
      final nonce = nonce264();
      final request = WitnessRequest(
        claim,
        claimant,
        ContentId('processId'),
        evidence,
        nonce,
      );

      morpheusPrivate.keyByPk(pk).privateKey().sign();*/

      // TODO: finish, when we can create Signed<WitnessRequest>
      /*final r = await api.sendRequest(witnessRequest);
      expect(r, CapabilityLink('link'));*/
    });

    test('sendRequest - not http202', () async {
      when(client.post(
        '$baseUrl/requests',
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      // TODO: finish, when we can create Signed<WitnessRequest>
      //final r = await api.sendRequest(witnessRequest);
    });

    test('getRequestStatus', () async {
      // TODO: finish, when we can create Signed<WitenssStatement>
      /*final status = RequestStatus(Status.approved, signedStatement, ...);
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
            (_) => Future.value(resp(json.encode(status.toJson()), code: 200)),
      );*/
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

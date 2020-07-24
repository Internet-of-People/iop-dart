import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:iop_sdk/entities/authority/io.dart';
import 'package:iop_sdk/entities/authority/private_api.dart';
import 'package:iop_sdk/entities/io.dart';
import 'package:iop_sdk/ssi/io.dart';
import 'package:test/test.dart';

import '../util.dart';

final requestsResponse = '''
{
  "requests": [
    {
      "capabilityLink": "uQePaSVwtgnHGIiLg2zT5JGyn3IGtbzR7Jcp84sNFfKaF",
      "requestId": "cjuaVBr9nuOH-yzal7bdyptBPSnaTYi39BfT-02EusxBFw",
      "dateOfRequest": "2020-03-19T13:05:56.000Z",
      "status": "approved",
      "processId": "cjunI8lB1BEtampkcvotOpF-zr1XmsCRNvntciGl3puOkg",
      "notes": null
    },
    {
      "capabilityLink": "uQFEfIHpM7hBnrWKhOnhxWauBSMKHxChYbwCzDWzt4tfV",
      "requestId": "cjudxI_6qozCQ2k2X0-Q-W8vOm1R2JGqDmQWbNMCpc1TyU",
      "dateOfRequest": "2020-03-20T13:11:20.000Z",
      "status": "approved",
      "processId": "cjunI8lB1BEtampkcvotOpF-zr1XmsCRNvntciGl3puOkg",
      "notes": null
    }
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
  final api = AuthorityPrivateApi(config);
  final baseUrl = 'http://host:80';

  group('AuthorityPrivateApi', () {
    test('listRequests', () async {
      when(
        client.get('$baseUrl/requests', headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp(requestsResponse)));

      final r = await api.listRequests();
      expect(r.length, 2);
      expect(
        r[0].capabilityLink,
        CapabilityLink('uQePaSVwtgnHGIiLg2zT5JGyn3IGtbzR7Jcp84sNFfKaF'),
      );
      expect(
        r[0].requestId,
        ContentId('cjuaVBr9nuOH-yzal7bdyptBPSnaTYi39BfT-02EusxBFw'),
      );
      expect(r[0].dateOfRequest, isNotNull);
      expect(r[0].status, Status.approved);
      expect(
        r[0].processId,
        ContentId('cjunI8lB1BEtampkcvotOpF-zr1XmsCRNvntciGl3puOkg'),
      );
      expect(r[0].notes, isNull);

      expect(
        r[1].capabilityLink,
        CapabilityLink('uQFEfIHpM7hBnrWKhOnhxWauBSMKHxChYbwCzDWzt4tfV'),
      );
      expect(
        r[1].requestId,
        ContentId('cjudxI_6qozCQ2k2X0-Q-W8vOm1R2JGqDmQWbNMCpc1TyU'),
      );
      expect(r[1].dateOfRequest, isNotNull);
      expect(r[1].status, Status.approved);
      expect(
        r[1].processId,
        ContentId('cjunI8lB1BEtampkcvotOpF-zr1XmsCRNvntciGl3puOkg'),
      );
      expect(r[1].notes, isNull);
    });

    test('listRequests - not http200', () async {
      when(
        client.get('$baseUrl/requests', headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp('', code: 500)));

      expect(
        api.listRequests(),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });

    test('getPrivateBlob', () async {
      final id = ContentId('contentId');
      when(client.get(
        '$baseUrl/private-blob/${id.value}',
        headers: anyNamed('headers'),
      )).thenAnswer((_) => Future.value(resp('BLOB')));

      final r = await api.getPrivateBlob(id);
      expect(r.isPresent, true);
      expect(r.value, 'BLOB');
    });

    test('getPrivateBlob - http404', () async {
      final id = ContentId('contentId');
      when(client.get(
        '$baseUrl/private-blob/${id.value}',
        headers: anyNamed('headers'),
      )).thenAnswer((_) => Future.value(resp('', code: 404)));

      final r = await api.getPrivateBlob(id);
      expect(r.isPresent, false);
    });

    test('getPrivateBlob - not http200/404', () async {
      final id = ContentId('contentId');
      when(client.get(
        '$baseUrl/private-blob/${id.value}',
        headers: anyNamed('headers'),
      )).thenAnswer((_) => Future.value(resp('', code: 500)));

      expect(
        api.getPrivateBlob(id),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });

    test('approveRequest', () async {
      final link = CapabilityLink('link');
      final statement = TestVault.create().createSignedWitnessStatement();
      when(client.post(
        '$baseUrl/requests/${link.value}/approve',
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('{"success": true}', code: 200)),
      );

      final rFut = api.approveRequest(link, statement);
      await expectLater(rFut, completes);
    });

    test('approveRequest - not http200', () async {
      final link = CapabilityLink('link');
      final statement = TestVault.create().createSignedWitnessStatement();
      when(client.post(
        '$baseUrl/requests/${link.value}/approve',
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      final rFut = api.approveRequest(link, statement);
      await expectLater(rFut, throwsA(const TypeMatcher<HttpResponseError>()));
    });

    test('rejectRequest', () async {
      final link = CapabilityLink('link');
      when(client.post(
        '$baseUrl/requests/${link.value}/reject',
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('', code: 200)),
      );

      await api.rejectRequest(link, '?');
    });

    test('rejectRequest - not http200', () async {
      final link = CapabilityLink('link');
      when(client.post(
        '$baseUrl/requests/${link.value}/reject',
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      expect(
        api.rejectRequest(link, '?'),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });
  });
}

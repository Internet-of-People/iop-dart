import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:morpheus_sdk/authority/api.dart';
import 'package:morpheus_sdk/authority/io.dart';
import 'package:morpheus_sdk/authority/private_api.dart';
import 'package:morpheus_sdk/ssi/io.dart';
import 'package:morpheus_sdk/utils/io.dart';
import 'package:test/test.dart';

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

class MockAuthorityConfig extends Mock implements AuthorityConfig {}

class MockClient extends Mock implements Client {}

Response resp(String body, {int code = 200}) {
  return Response(body, code);
}

void main() {
  final client = MockClient();
  final config = MockAuthorityConfig();
  final api = AuthorityPrivateApi(config);
  when(config.client).thenReturn(client);

  group('AuthorityPrivateApi', () {
    test('listRequests', () async {
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp(requestsResponse)),
      );

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
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      expect(
        api.listRequests(),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });

    test('getPrivateBlob', () async {
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp('BLOB')),
      );

      final r = await api.getPrivateBlob(ContentId('contentId'));
      expect(r.isPresent, true);
      expect(r.value, 'BLOB');
    });

    test('getPrivateBlob - http404', () async {
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp('', code: 404)),
      );

      final r = await api.getPrivateBlob(ContentId('contentId'));
      expect(r.isPresent, false);
    });

    test('getPrivateBlob - not http200/404', () async {
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      expect(
        api.getPrivateBlob(ContentId('contentId')),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });

    test('approveRequest', () async {
      when(client.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('', code: 200)),
      );

      // TODO: finish, when we can create Signed<WitnessStatement>
      // await api.approveRequest(CapabilityLink('link'),statement);
    });

    test('approveRequest - not http200', () async {
      when(client.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      // TODO: finish, when we can create Signed<WitnessStatement>
      // await api.approveRequest(CapabilityLink('link'),statement);
    });

    test('rejectRequest', () async {
      when(client.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('', code: 200)),
      );

      await api.rejectRequest(CapabilityLink('link'), '?');
    });

    test('rejectRequest - not http200', () async {
      when(client.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      expect(
        api.rejectRequest(CapabilityLink('link'), '?'),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });
  });
}

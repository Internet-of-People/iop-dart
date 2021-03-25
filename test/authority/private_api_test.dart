import 'package:http/http.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/utils.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:test/test.dart';

import '../util.dart';
import 'public_api_test.mocks.dart';

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

Future<Response> jwtResp(Response response, Invocation req, PublicKey pk,
    {String? contentId}) {
  final authorizationHeader =
      req.namedArguments[#headers]['Authorization'].toString();
  final token = authorizationHeader.replaceFirst('Bearer ', '');
  final valid = validateJwtToken(token, pk, contentId: contentId);
  pk.dispose();
  return Future.value(valid ? response : resp('', code: 403));
}

@GenerateMocks([Client, ApiConfig])
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
      final sk = TestVault.create().privateKey;
      when(
        client.get(Uri.parse('$baseUrl/requests'),
            headers: anyNamed('headers')),
      ).thenAnswer(
          (req) => jwtResp(resp(requestsResponse), req, sk.publicKey()));

      final r = await api.listRequests(sk);
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
        client.get(Uri.parse('$baseUrl/requests'),
            headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp('', code: 500)));

      final sk = TestVault.create().privateKey;
      expect(
        api.listRequests(sk),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });

    test('getPrivateBlob', () async {
      final sk = TestVault.create().privateKey;
      final id = ContentId('contentId');
      when(client.get(
        Uri.parse('$baseUrl/private-blob/${id.value}'),
        headers: anyNamed('headers'),
      )).thenAnswer((req) => jwtResp(resp('BLOB'), req, sk.publicKey()));

      final r = await api.getPrivateBlob(id, sk);
      expect(r.isPresent, true);
      expect(r.value, 'BLOB');
    });

    test('getPrivateBlob - http404', () async {
      final id = ContentId('contentId');
      when(client.get(
        Uri.parse('$baseUrl/private-blob/${id.value}'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) => Future.value(resp('', code: 404)));

      final sk = TestVault.create().privateKey;
      final r = await api.getPrivateBlob(id, sk);
      expect(r.isPresent, false);
    });

    test('getPrivateBlob - not http200/404', () async {
      final id = ContentId('contentId');
      when(client.get(
        Uri.parse('$baseUrl/private-blob/${id.value}'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) => Future.value(resp('', code: 500)));

      final sk = TestVault.create().privateKey;
      expect(
        api.getPrivateBlob(id, sk),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });

    test('approveRequest', () async {
      final sk = TestVault.create().privateKey;
      final link = CapabilityLink('link');
      final statement = TestVault.create().createSignedWitnessStatement();
      when(client.post(
        Uri.parse('$baseUrl/requests/${link.value}/approve'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (req) =>
            jwtResp(resp('{"success": true}', code: 200), req, sk.publicKey()),
      );

      final rFut = api.approveRequest(link, statement, sk);
      await expectLater(rFut, completes);
    });

    test('approveRequest - not http200', () async {
      final link = CapabilityLink('link');
      final statement = TestVault.create().createSignedWitnessStatement();
      when(client.post(
        Uri.parse('$baseUrl/requests/${link.value}/approve'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      final sk = TestVault.create().privateKey;
      final rFut = api.approveRequest(link, statement, sk);
      await expectLater(rFut, throwsA(const TypeMatcher<HttpResponseError>()));
    });

    test('rejectRequest', () async {
      final sk = TestVault.create().privateKey;
      final link = CapabilityLink('link');
      when(client.post(
        Uri.parse('$baseUrl/requests/${link.value}/reject'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (req) => jwtResp(resp('', code: 200), req, sk.publicKey()),
      );

      await api.rejectRequest(link, '?', sk);
    });

    test('rejectRequest - not http200', () async {
      final link = CapabilityLink('link');
      when(client.post(
        Uri.parse('$baseUrl/requests/${link.value}/reject'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      final sk = TestVault.create().privateKey;
      expect(
        api.rejectRequest(link, '?', sk),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });
  });
}

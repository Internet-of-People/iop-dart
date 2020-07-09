import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:morpheus_sdk/authority/api.dart';
import 'package:morpheus_sdk/authority/io.dart';
import 'package:morpheus_sdk/authority/public_api.dart';
import 'package:morpheus_sdk/ssi/io.dart';
import 'package:morpheus_sdk/utils/io.dart';
import 'package:test/test.dart';

final processesResponse = '''{
  "processes": [
    "cjuc1fS3_nrxuK0bRr3P3jZeFeT51naOCMXDPekX8rPqho",
    "cjunI8lB1BEtampkcvotOpF-zr1XmsCRNvntciGl3puOkg",
    "cjujqhFEN_T2BV-TcyGNTHNeUds3m8aAc-vIWUdZSyK9Sw"
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
  final api = AuthorityPublicApi(config);
  when(config.client).thenReturn(client);

  group('AuthorityPublicApi', () {
    test('listProcesses', () async {
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp(processesResponse)),
      );

      final r = await api.listProcesses();
      expect(r.length, 3);
      expect(r[0], ContentId('cjuc1fS3_nrxuK0bRr3P3jZeFeT51naOCMXDPekX8rPqho'));
      expect(r[1], ContentId('cjunI8lB1BEtampkcvotOpF-zr1XmsCRNvntciGl3puOkg'));
      expect(r[2], ContentId('cjujqhFEN_T2BV-TcyGNTHNeUds3m8aAc-vIWUdZSyK9Sw'));
    });

    test('listProcesses - not http200', () async {
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      expect(
        api.listProcesses(),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });

    test('getPublicBlob', () async {
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp('BLOB')),
      );

      final r = await api.getPublicBlob(ContentId('contentId'));
      expect(r.isPresent, true);
      expect(r.value, 'BLOB');
    });

    test('getPublicBlob - http404', () async {
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp('', code: 404)),
      );

      final r = await api.getPublicBlob(ContentId('contentId'));
      expect(r.isPresent, false);
    });

    test('getPublicBlob - not http200/404', () async {
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      expect(
        api.getPublicBlob(ContentId('contentId')),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });

    test('sendRequest', () async {
      when(client.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('link', code: 202)),
      );

      // TODO: finish, when we can create Signed<WitnessRequest>
      /*final r = await api.sendRequest(witnessRequest);
      expect(r, CapabilityLink('link'));*/
    });

    test('sendRequest - not http202', () async {
      when(client.post(
        any,
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
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp('', code: 404)),
      );

      final r = await api.getRequestStatus(CapabilityLink('link'));
      expect(r.isPresent, false);
    });

    test('getRequestStatus - not http200/404', () async {
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      expect(
        api.getRequestStatus(CapabilityLink('link')),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
      ;
    });
  });
}

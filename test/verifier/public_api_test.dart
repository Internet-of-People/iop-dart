import 'dart:convert';

import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:morpheus_sdk/src/io.dart';
import 'package:morpheus_sdk/verifier/public_api.dart';
import 'package:test/test.dart';

import '../util.dart';

class MockApiConfig extends Mock implements ApiConfig {}

class MockClient extends Mock implements Client {}

void main() {
  final client = MockClient();
  final config = MockApiConfig();
  when(config.client).thenReturn(client);
  when(config.host).thenReturn('http://host');
  when(config.port).thenReturn(80);
  final api = VerifierPublicApi(config);
  final baseUrl = 'http://host:80';

  group('VerifierPublicApi', () {
    test('getAfterProof', () async {
      when(
        client.get('$baseUrl/after-proof', headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp(
            json.encode({'blockHash': 'hash', 'blockHeight': 42}),
          )));

      final r = await api.getAfterProof();
      expect(r.blockHash, 'hash');
      expect(r.blockHeight, 42);
    });

    test('getAfterProof - not http200', () async {
      when(
        client.get('$baseUrl/after-proof', headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp('', code: 500)));

      expect(
        api.getAfterProof(),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });

    test('validate', () async {
      when(client.post(
        '$baseUrl/validate',
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp(json.encode({'errors': [], 'warnings': []}))),
      );

      // TODO: finish, when we can create ValidationRequest
      // final r = await api.validate(request);
    });

    test('validate - not http200', () async {
      when(client.post(
        '$baseUrl/validate',
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      // TODO: finish, when we can create ValidationRequest
      /*expect(
        api.validate(request),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );*/
    });
  });
}

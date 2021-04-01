import 'dart:convert';

import 'package:http/http.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/utils.dart';
import 'package:iop_sdk/verifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../util.dart';
import 'public_api_test.mocks.dart';

@GenerateMocks([Client, ApiConfig])
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
        client.get(Uri.parse('$baseUrl/afterProof'),
            headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp(
            json.encode({'blockHash': 'hash', 'blockHeight': 42}),
          )));

      final r = await api.getAfterProof();
      expect(r.blockHash, 'hash');
      expect(r.blockHeight, 42);
    });

    test('getAfterProof - not http200', () async {
      when(
        client.get(Uri.parse('$baseUrl/afterProof'),
            headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp('', code: 500)));

      expect(
        api.getAfterProof(),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });

    test('validate', () async {
      final request = TestVault.create().createValidationRequest();
      when(client.post(
        Uri.parse('$baseUrl/validate'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp(json.encode({'errors': [], 'warnings': []}))),
      );

      final r = await api.validate(request);
      expect(r.warnings, isEmpty);
      expect(r.errors, isEmpty);
    });

    test('validate - not http200', () async {
      final request = TestVault.create().createValidationRequest();
      when(client.post(
        Uri.parse('$baseUrl/validate'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      expect(
        api.validate(request),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });
  });
}

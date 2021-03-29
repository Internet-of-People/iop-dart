import 'package:http/http.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/inspector.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_sdk/utils.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../util.dart';
import 'public_api_test.mocks.dart';

final scenariosResponse = '''
{
  "scenarios": [
    "cjuFURvWkcd-82J83erY_dEUhlRf9Yn8OiWWl7SxVpBvf4"
  ]
}
''';

@GenerateMocks([Client, ApiConfig])
void main() {
  final client = MockClient();
  final config = MockApiConfig();
  when(config.client).thenReturn(client);
  when(config.host).thenReturn('http://host');
  when(config.port).thenReturn(80);
  final api = InspectorPublicApi(config);
  final baseUrl = 'http://host:80';

  group('InspectorPublicApi', () {
    test('listScenarios', () async {
      when(
        client.get(Uri.parse('$baseUrl/scenarios'),
            headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp(scenariosResponse)));

      final r = await api.listScenarios();
      expect(r.length, 1);
      expect(r[0], ContentId('cjuFURvWkcd-82J83erY_dEUhlRf9Yn8OiWWl7SxVpBvf4'));
    });

    test('listScenarios - not http200', () async {
      when(
        client.get(Uri.parse('$baseUrl/scenarios'),
            headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp('', code: 500)));

      expect(
        api.listScenarios(),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });

    test('getPublicBlob', () async {
      final id = ContentId('contentId');
      when(
        client.get(Uri.parse('$baseUrl/blob/${id.value}'),
            headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp('BLOB')));

      final r = await api.getPublicBlob(id);
      expect(r, isNotNull);
      expect(r, 'BLOB');
    });

    test('getPublicBlob - http404', () async {
      final id = ContentId('contentId');
      when(
        client.get(Uri.parse('$baseUrl/blob/${id.value}'),
            headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp('', code: 404)));

      final r = await api.getPublicBlob(id);
      expect(r, isNull);
    });

    test('getPublicBlob - not http200/404', () async {
      final id = ContentId('contentId');
      when(
        client.get(Uri.parse('$baseUrl/blob/${id.value}'),
            headers: anyNamed('headers')),
      ).thenAnswer((_) => Future.value(resp('', code: 500)));

      expect(
        api.getPublicBlob(id),
        throwsA(const TypeMatcher<HttpResponseError>()),
      );
    });

    test('uploadPresentation', () async {
      final presentation = TestVault.create().createSignedPresentation();
      when(client.post(
        Uri.parse('$baseUrl/presentation'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('contentId', code: 202)),
      );

      final r = await api.uploadPresentation(presentation);
      expect(r.value, 'contentId');
    });

    test('uploadPresentation - not http202', () async {
      final presentation = TestVault.create().createSignedPresentation();
      when(client.post(
        Uri.parse('$baseUrl/presentation'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) => Future.value(resp('', code: 500)),
      );

      final rFut = api.uploadPresentation(presentation);
      await expectLater(rFut, throwsA(const TypeMatcher<HttpResponseError>()));
    });
  });
}

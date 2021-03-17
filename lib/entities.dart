import 'package:http/http.dart';
import 'package:iop_sdk/crypto.dart';

abstract class Api {
  static final Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json',
  };

  final ApiConfig _config;
  final String _baseUrl;

  Api(this._config) : _baseUrl = '${_config.host}:${_config.port}';

  static Map<String, String> headers(Map<String, String> customHeaders) {
    final headers = Map<String, String>.from(_jsonHeaders);
    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }
    return headers;
  }

  Future<Response> post(String path, dynamic body,
      {Map<String, String> customHeaders}) async {
    return _config.client.post(
      Uri.parse('${_baseUrl}$path'),
      headers: headers(customHeaders),
      body: body,
    );
  }

  Future<Response> get(String path, {Map<String, String> customHeaders}) async {
    return _config.client.get(
      Uri.parse('${_baseUrl}$path'),
      headers: headers(customHeaders),
    );
  }

  Future<Response> getAuth(String path, PrivateKey withPrivateKey) async {
    return await get(path, customHeaders: _authHeader(withPrivateKey));
  }

  Future<Response> postAuth(
      String path, dynamic content, PrivateKey withPrivateKey) async {
    return await post(path, content,
        customHeaders: _authHeader(withPrivateKey, content: content));
  }

  String _jwtToken(PrivateKey privateKey, {dynamic content}) {
    final builder = content == null
        ? JwtBuilder.create()
        : JwtBuilder.withContentId(digestJson(content).toString());
    final token = builder.sign(privateKey);
    builder.dispose();
    return token;
  }

  Map<String, String> _authHeader(PrivateKey privateKey, {dynamic content}) {
    final token = _jwtToken(privateKey, content: content);
    return {'Authorization': 'Bearer $token'};
  }
}

class ApiConfig {
  final String host;
  final int port;
  final Client _client = Client();

  ApiConfig(this.host, this.port);

  Client get client => _client;
}

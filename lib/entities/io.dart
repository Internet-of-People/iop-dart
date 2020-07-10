import 'package:http/http.dart';

class HttpResponseError {
  HttpResponseError(this.code, this.message, {this.method});

  final String method;
  final int code;
  final String message;

  @override
  String toString() {
    final content = method == null ? '' : 'Method: $method\n';
    return '$content${'ErrorCode: $code\n Message: $message'}';
  }
}

abstract class Api {
  static final Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json',
  };
  final ApiConfig _config;
  final String _baseUrl;

  Api(this._config) : _baseUrl = '${_config.host}:${_config.port}';

  Future<Response> post(String path, dynamic body) async {
    return _config.client.post(
      '${_baseUrl}$path',
      headers: _jsonHeaders,
      body: body,
    );
  }

  Future<Response> get(String path) async {
    return _config.client.get(
      '${_baseUrl}$path',
      headers: _jsonHeaders,
    );
  }
}

class ApiConfig {
  final String host;
  final int port;
  final Client _client = Client();

  ApiConfig(this.host, this.port);

  Client get client => _client;
}

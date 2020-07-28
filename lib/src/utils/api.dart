import 'package:http/http.dart';
import 'package:iop_sdk/network.dart';

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

abstract class LayerApi {
  static final Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json',
  };
  final Client _client = Client();
  final Network network;

  LayerApi(this.network);

  Future<Response> layer1ApiPost(String path, dynamic body) async {
    return _client.post(
      '${network.layer1ApiUrl}$path',
      headers: _jsonHeaders,
      body: body,
    );
  }

  Future<Response> layer1ApiGet(String path) async {
    return _client.get(
      '${network.layer1ApiUrl}$path',
      headers: _jsonHeaders,
    );
  }

  Future<Response> layer2ApiGet(String path) async {
    return _client.get(
      '${network.layer2ApiUrl}$path',
      headers: _jsonHeaders,
    );
  }

  Future<Response> layer2ApiPost(String path, dynamic body) async {
    return _client.post(
      '${network.layer2ApiUrl}$path',
      headers: _jsonHeaders,
      body: body,
    );
  }
}

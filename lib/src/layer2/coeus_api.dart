import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/network.dart';
import 'package:iop_sdk/utils.dart';

import 'io.dart';

class CoeusApi {
  final Client _client = Client();
  final NetworkConfig _networkConfig;

  CoeusApi(this._networkConfig);

  Future<bool?> getTxnStatus(String txId) async {
    final resp = await _layer2ApiGet('/txn-status/$txId');

    if (resp.statusCode == HttpStatus.ok) {
      return json.decode(resp.body);
    } else if (resp.statusCode == HttpStatus.notFound) {
      return null;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<String?> resolve(String name) async {
    final resp = await _layer2ApiGet('/resolve/$name');
    if (resp.statusCode == HttpStatus.ok) {
      final body = json.decode(resp.body);
      return json.encode(body['data']);
    } else if (resp.statusCode == HttpStatus.notFound) {
      return null;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<DomainMetadata?> getMetadata(String name) async {
    final resp = await _layer2ApiGet('/metadata/$name');

    if (resp.statusCode == HttpStatus.ok) {
      final body = json.decode(resp.body);
      final metadata = DomainMetadata.fromJson(body);
      return metadata;
    } else if (resp.statusCode == HttpStatus.notFound) {
      return null;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<List<String>?> getChildren(String name) async {
    final resp = await _layer2ApiGet('/children/$name');

    if (resp.statusCode == HttpStatus.ok) {
      final body = json.decode(resp.body);
      final children =
          (body['children'] as List<dynamic>).map((e) => e as String).toList();
      return children;
    } else if (resp.statusCode == HttpStatus.notFound) {
      return null;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<int> getLastNonce(PublicKey publicKey) async {
    final resp = await _layer2ApiGet('/last-nonce/${publicKey.toString()}');

    if (resp.statusCode == HttpStatus.ok) {
      return int.parse(json.decode(resp.body)['nonce']);
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<Response> _layer2ApiGet(String path) async {
    return _client.get(
      Uri.parse('${_networkConfig.host}:${_networkConfig.port}/coeus/v1$path'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }
}

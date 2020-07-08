import 'dart:convert';
import 'dart:io';
import 'package:morpheus_sdk/layer1/operation_data.dart';
import 'package:morpheus_sdk/layer2/did_document.dart';
import 'package:morpheus_sdk/network.dart';
import 'package:morpheus_sdk/utils/api.dart';
import 'package:morpheus_sdk/utils/io.dart';
import 'package:morpheus_sdk/layer2/io.dart';
import 'package:optional/optional.dart';

class Layer2Api extends LayerApi {
  Layer2Api(Network network) : super(network);

  Future<BeforeProofHistoryResponse> getBeforeProofHistory(
    String contentId,
  ) async {
    final resp = await layer2ApiGet('/before-proof/$contentId/history');

    if (resp.statusCode == HttpStatus.ok) {
      final body = json.decode(resp.body);
      return BeforeProofHistoryResponse.fromJson(body);
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<bool> beforeProofExists(String contentId, {int height}) async {
    final resp = await layer2ApiGet(
      _widthHeight('/before-proof/${contentId}/exists', height),
    );
    return json.decode(resp.body);
  }

  Future<DidDocument> getDidDocument(String did, {int height}) async {
    final resp = await layer2ApiGet(_widthHeight('/did/$did/document', height));

    if (resp.statusCode == HttpStatus.ok) {
      final body = json.decode(resp.body);
      final didData = DidDocumentData.fromJson(body);
      return DidDocument(didData);
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<Optional<bool>> getTxnStatus(String txId) async {
    final resp = await layer2ApiGet('/txn-status/$txId');

    if (resp.statusCode == HttpStatus.ok) {
      return Optional.of(json.decode(resp.body));
    } else if (resp.statusCode == HttpStatus.notFound) {
      return Optional.empty();
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<String> getLastTxId(String did) async {
    final resp = await layer2ApiGet('/did/$did/transactions/last');

    if (resp.statusCode == HttpStatus.ok) {
      return json.decode(resp.body)['transactionId'];
    } else if (resp.statusCode == HttpStatus.notFound) {
      return null;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<List<TransactionIdHeight>> getDidTransactionIds(
    String did,
    int fromHeight, {
    int untilHeight,
  }) async {
    return _didTransactionIdsQuery(
      false,
      did,
      fromHeight,
      untilHeight: untilHeight,
    );
  }

  Future<List<TransactionIdHeight>> getDidTransactionAttemptIds(
    String did,
    int fromHeight, {
    int untilHeight,
  }) async {
    return _didTransactionIdsQuery(
      true,
      did,
      fromHeight,
      untilHeight: untilHeight,
    );
  }

  Future<List<DidOperation>> getDidOperations(
    String did,
    int fromHeight, {
    int untilHeight,
  }) async {
    return _didOperationsQuery(
      false,
      did,
      fromHeight,
      untilHeight: untilHeight,
    );
  }

  Future<List<DidOperation>> getDidOperationAttempts(
    String did,
    int fromHeight, {
    int untilHeight,
  }) async {
    return _didOperationsQuery(
      true,
      did,
      fromHeight,
      untilHeight: untilHeight,
    );
  }

  Future<List<DryRunOperationError>> checkTransactionValidity(
    OperationData data,
  ) async {
    final resp = await layer1ApiPost(
      '/check-transaction-validity',
      json.encode(data.toJson()),
    );

    if (resp.statusCode == HttpStatus.ok) {
      return (json.decode(resp.body) as List<Map<String, dynamic>>)
          .map((e) => DryRunOperationError.fromJson(e))
          .toList();
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<List<DidOperation>> _didOperationsQuery(
    bool includeAttempts,
    String did,
    int fromHeight, {
    int untilHeight,
  }) async {
    final path = includeAttempts ? 'operation-attempts' : 'operations';
    final resp = await layer2ApiGet(
      _widthHeight('/did/$did/$path/$fromHeight', untilHeight),
    );

    if (resp.statusCode == HttpStatus.ok) {
      return (json.decode(resp.body) as List<dynamic>)
          .map((e) => DidOperation.fromJson(e))
          .toList();
    } else if (resp.statusCode == HttpStatus.notFound) {
      return null;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<List<TransactionIdHeight>> _didTransactionIdsQuery(
    bool includeAttempts,
    String did,
    int fromHeight, {
    int untilHeight,
  }) async {
    final path = includeAttempts ? 'transaction-attempts' : 'transactions';
    final resp = await layer2ApiGet(
      _widthHeight('/did/$did/$path/$fromHeight', untilHeight),
    );

    if (resp.statusCode == HttpStatus.ok) {
      return (json.decode(resp.body) as List<dynamic>)
          .map((e) => TransactionIdHeight.fromJson(e))
          .toList();
    } else if (resp.statusCode == HttpStatus.notFound) {
      return null;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  String _widthHeight(String path, int height) {
    return height == null ? path : '$path/$height';
  }
}

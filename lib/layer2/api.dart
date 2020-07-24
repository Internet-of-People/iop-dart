import 'dart:convert';
import 'dart:io';
import 'package:iop_sdk/crypto/io.dart';
import 'package:iop_sdk/entities/io.dart';
import 'package:iop_sdk/layer1/operation_data.dart';
import 'package:iop_sdk/layer2/did_document.dart';
import 'package:iop_sdk/network.dart';
import 'package:iop_sdk/ssi/io.dart';
import 'package:iop_sdk/utils/api.dart';
import 'package:iop_sdk/layer2/io.dart';
import 'package:optional/optional.dart';

class Layer2Api extends LayerApi {
  Layer2Api(Network network) : super(network);

  Future<BeforeProofHistoryResponse> getBeforeProofHistory(
    ContentId contentId,
  ) async {
    final resp = await layer2ApiGet('/before-proof/${contentId.value}/history');

    if (resp.statusCode == HttpStatus.ok) {
      final body = json.decode(resp.body);
      return BeforeProofHistoryResponse.fromJson(body);
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<bool> beforeProofExists(ContentId contentId, {int height}) async {
    final resp = await layer2ApiGet(
      _widthHeight('/before-proof/${contentId.value}/exists', height),
    );
    return json.decode(resp.body);
  }

  Future<DidDocument> getDidDocument(DidData did, {int height}) async {
    final resp = await layer2ApiGet(
      _widthHeight('/did/${did.value}/document', height),
    );

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

  Future<String> getLastTxId(DidData did) async {
    final resp = await layer2ApiGet('/did/${did.value}/transactions/last');

    if (resp.statusCode == HttpStatus.ok) {
      return json.decode(resp.body)['transactionId'];
    } else if (resp.statusCode == HttpStatus.notFound) {
      return null;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<List<TransactionIdHeight>> getDidTransactionIds(
    DidData did,
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
    DidData did,
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
    DidData did,
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
    DidData did,
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
    List<OperationData> operationAttempts,
  ) async {
    final resp = await layer2ApiPost(
      '/check-transaction-validity',
      json.encode(operationAttempts),
    );

    if (resp.statusCode == HttpStatus.ok) {
      return (json.decode(resp.body) as List<dynamic>)
          .map((e) => DryRunOperationError.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<List<DidOperation>> _didOperationsQuery(
    bool includeAttempts,
    DidData did,
    int fromHeight, {
    int untilHeight,
  }) async {
    final path = includeAttempts ? 'operation-attempts' : 'operations';
    final resp = await layer2ApiGet(
      _widthHeight('/did/${did.value}/$path/$fromHeight', untilHeight),
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
    DidData did,
    int fromHeight, {
    int untilHeight,
  }) async {
    final path = includeAttempts ? 'transaction-attempts' : 'transactions';
    final resp = await layer2ApiGet(
      _widthHeight('/did/${did.value}/$path/$fromHeight', untilHeight),
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

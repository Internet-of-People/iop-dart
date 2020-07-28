import 'dart:io';
import 'dart:convert';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/utils.dart';
import 'package:iop_sdk/network.dart';
import 'package:optional/optional.dart';

class Layer1Api extends LayerApi {
  Layer1Api(Network network) : super(network);

  Future<NodeCryptoConfigResponse> getNodeCryptoConfig() async {
    final resp = await layer1ApiGet('/node/configuration/crypto');

    if (resp.statusCode == HttpStatus.ok) {
      final body = json.decode(resp.body);
      return NodeCryptoConfigResponse.fromJson(body['data']);
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<int> getCurrentHeight() async {
    final resp = await layer1ApiGet('/blockchain');

    if (resp.statusCode == HttpStatus.ok) {
      final body = json.decode(resp.body);
      final blockchainResp = BlockchainResponse.fromJson(body['data']);
      return blockchainResp.block.height;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<Optional<TransactionStatusResponse>> getTxnStatus(String txId) async {
    final resp = await layer1ApiGet('/transactions/$txId');

    if (resp.statusCode == HttpStatus.ok) {
      final body = json.decode(resp.body);
      return Optional.of(TransactionStatusResponse.fromJson(body['data']));
    } else if (resp.statusCode == HttpStatus.notFound) {
      return Optional.empty();
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<Optional<WalletResponse>> getWallet(String addressOrPublicKey) async {
    final resp = await layer1ApiGet('/wallets/$addressOrPublicKey');

    if (resp.statusCode == HttpStatus.ok) {
      final body = json.decode(resp.body);
      return Optional.of(WalletResponse.fromJson(body['data']));
    } else if (resp.statusCode == HttpStatus.notFound) {
      return Optional.empty();
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<int> getWalletNonce(String addressOrPublicKey) async {
    final wallet = await getWallet(addressOrPublicKey);
    return wallet.isPresent ? int.parse(wallet.value.nonce) : 0;
  }

  Future<int> getWalletBalance(String addressOrPublicKey) async {
    final wallet = await getWallet(addressOrPublicKey);
    return wallet.isPresent ? int.parse(wallet.value.balance) : 0;
  }

  Future<String> sendTransferTx(
    String senderAddress,
    String targetAddress,
    int amountInFlake,
    HydraPrivate hydraPrivate, {
    int nonce,
  }) async {
    final senderBip44PubKey = hydraPrivate.public.keyByAddress(senderAddress);
    nonce ??= (await getWalletNonce(senderAddress)) + 1;

    final transferTx = DartApi.instance.hydraTransferTx(
      network.RustApiId,
      senderBip44PubKey.publicKey().toString(),
      targetAddress,
      amountInFlake,
      nonce,
    );

    final signedTx = hydraPrivate.signHydraTransaction(senderAddress, transferTx);

    final resp = await sendSignedTx(signedTx.toString());
    return resp;
  }

  Future<String> sendTransferTxWithPassphrase(
    String passphrase,
    String targetAddress,
    int amountInFlake, {
    int nonce,
  }) async {
    final secpPrivKey = SecpPrivateKey.fromArkPassphrase(passphrase);
    final senderPubKey = secpPrivKey.publicKey().toString();
    nonce ??= (await getWalletNonce(senderPubKey)) + 1;

    final transferTx = DartApi.instance
        .hydraTransferTx(network.RustApiId, senderPubKey, targetAddress, amountInFlake, nonce);

    final signedTx = secpPrivKey.signHydraTransaction(transferTx);

    final resp = await sendSignedTx(signedTx.toString());
    return resp;
  }

  Future<String> sendMorpheusTx(
    String senderAddress,
    List<OperationData> attempts,
    HydraPrivate hydraPrivate, {
    int nonce,
  }) async {
    final senderBip44PubKey = hydraPrivate.public.keyByAddress(senderAddress);
    nonce ??= (await getWalletNonce(senderAddress)) + 1;

    final transferTx = DartApi.instance.morpheusTx(
      network.RustApiId,
      senderBip44PubKey.publicKey().toString(),
      attempts,
      nonce,
    );

    final signedTx = hydraPrivate.signHydraTransaction(senderAddress, transferTx);

    final resp = await sendSignedTx(signedTx.toString());
    return resp;
  }

  Future<String> sendMorpheusTxWithPassphrase(
    List<OperationData> attempts,
    String passphrase, {
    int nonce,
  }) async {
    final secpPrivKey = SecpPrivateKey.fromArkPassphrase(passphrase);
    final senderPubKey = secpPrivKey.publicKey().toString();
    nonce ??= (await getWalletNonce(senderPubKey)) + 1;

    final transferTx = DartApi.instance.morpheusTx(
      network.RustApiId,
      senderPubKey,
      attempts,
      nonce,
    );

    final signedTx = secpPrivKey.signHydraTransaction(transferTx);

    final resp = await sendSignedTx(signedTx.toString());
    return resp;
  }

  Future<String> sendSignedTx(String signedTx) async {
    final resp = await layer1ApiPost('/transactions', signedTx);

    if (resp.statusCode != HttpStatus.ok) {
      return Future.error(HttpResponseError(resp.statusCode, resp.body));
    }

    final body = json.decode(resp.body);
    final txResp = SendTransactionResponse.fromJson(body['data']);

    if (txResp.invalid.isNotEmpty) {
      return Future.error(HttpResponseError(
        resp.statusCode,
        'Transaction failed: ${json.encode(txResp.errors)}',
      ));
    }

    if (txResp.accept.length > 1) {
      return Future.error(HttpResponseError(
        resp.statusCode,
        'sendTx expected 1 accepted tx, got ${txResp.accept.length}. Response: ${resp.body}',
      ));
    }
    return txResp.accept[0];
  }
}

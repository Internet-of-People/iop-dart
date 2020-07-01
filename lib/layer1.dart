import 'dart:io';
import 'dart:convert';
import 'package:meta/meta.dart';

import 'sdk.dart';

// TODO should these be moved to types instead?
enum Network {
  LocalTestNet,
  TestNet,
  DevNet,
  MainNet,
}

extension NetworkProperties on Network {
  // TODO consider if this duplication is needed here or could be connected directly to Rust types
  String get Id => const {
        Network.LocalTestNet: 'HYD testnet',
        Network.TestNet: 'HYD testnet',
        Network.DevNet: 'HYD devnet',
        Network.MainNet: 'HYD mainnet',
      }[this];

  String get seedServerUrlBase => const {
        Network.LocalTestNet: 'http://127.0.0.1',
        Network.TestNet: 'http://35.187.56.222',
        Network.DevNet: 'http://35.240.62.119',
        Network.MainNet: 'http://35.195.150.223',
      }[this];

  String get seedServerRestUrl => seedServerUrlBase + ':4703/api/v2';
}

// TODO what goes here?
class HydraAddress {
  String address;

  HydraAddress(this.address) {
    // TODO validate address
  }
}

class TransactionId {
  String txId;

  TransactionId(this.txId);

  @override
  String toString() {
    return txId;
  }
}

// TODO work this out
abstract class Transaction {}

class HydraTransferTransaction extends Transaction {
  HydraAddress toAddress;
  BigInt flakes;
  BigInt fee;

  HydraTransferTransaction(
      {@required this.toAddress, @required this.flakes, this.fee
      // TODO hexencoded binary
      // String vendorField,
      }) {
    // TODO validate recipient address format
  }

  @override
  String toString() {
    throw UnimplementedError();
  }
}

// TODO work this out
class MorpheusOperationAttempt {}

class MorpheusSignableOperationAttempt extends MorpheusOperationAttempt {}

class MorpheusOperationBuilder {}

class MorpheusTransaction extends Transaction {
  @override
  String toString() {
    throw UnimplementedError();
  }
}

class MorpheusTransactionBuilder {}

class Layer1 {
  Network network;
  HttpClient client;

  Layer1(this.network) {
    client = HttpClient();
  }

  // TODO should return a typed wallet struct
  Future<String> getWallet(String addressOrPublicKey) async {
    final url =
        Uri.parse(network.seedServerRestUrl + '/wallets/${addressOrPublicKey}');
    final req = await client.getUrl(url);
    final resp = await req.close();
    resp.transform(utf8.decoder).listen((content) {
      print('GetWallet response: ${content}');
    });
    return Future.value('TODO content');
  }

  Future<bool> getTransactionStatus(TransactionId txId) async {
    // TODO implement properly
    return Future.value(true);
  }

  Future<TransactionId> sendTransaction(SignedHydraTransaction hydraTx) async {
    var url = Uri.parse(network.seedServerRestUrl + '/transactions');
    var req = await client.postUrl(url)
      ..headers.contentType = ContentType.json
      ..write(hydraTx.toString());
    var resp = await req.close();
    resp.transform(utf8.decoder).listen((content) {
      print('Transaction response: ${content}');
    });
    // TODO process received response content to create a transactioId
    return Future.value(TransactionId('transactionId'));
  }

// TODO implement sendTransferTx() and sendMorpheusTx() here
// TODO getWallet(nonce/balance/etc), sendTx(RawTxJson), getCurrentHeight()
}

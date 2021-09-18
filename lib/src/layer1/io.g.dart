// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'io.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendTransactionResponseData _$SendTransactionResponseDataFromJson(
        Map<String, dynamic> json) =>
    SendTransactionResponseData(
      (json['accept'] as List<dynamic>).map((e) => e as String).toList(),
      (json['broadcast'] as List<dynamic>).map((e) => e as String).toList(),
      (json['excess'] as List<dynamic>).map((e) => e as String).toList(),
      (json['invalid'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SendTransactionResponseDataToJson(
        SendTransactionResponseData instance) =>
    <String, dynamic>{
      'accept': instance.accept,
      'broadcast': instance.broadcast,
      'excess': instance.excess,
      'invalid': instance.invalid,
    };

SendTransactionResponse _$SendTransactionResponseFromJson(
        Map<String, dynamic> json) =>
    SendTransactionResponse(
      SendTransactionResponseData.fromJson(
          json['data'] as Map<String, dynamic>),
      json['errors'],
    );

Map<String, dynamic> _$SendTransactionResponseToJson(
        SendTransactionResponse instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
      'errors': instance.errors,
    };

BlockchainResponse _$BlockchainResponseFromJson(Map<String, dynamic> json) =>
    BlockchainResponse(
      BlockchainBlock.fromJson(json['block'] as Map<String, dynamic>),
      json['supply'] as String,
    );

Map<String, dynamic> _$BlockchainResponseToJson(BlockchainResponse instance) =>
    <String, dynamic>{
      'block': instance.block.toJson(),
      'supply': instance.supply,
    };

BlockchainBlock _$BlockchainBlockFromJson(Map<String, dynamic> json) =>
    BlockchainBlock(
      json['id'] as String,
      json['height'] as int,
    );

Map<String, dynamic> _$BlockchainBlockToJson(BlockchainBlock instance) =>
    <String, dynamic>{
      'id': instance.id,
      'height': instance.height,
    };

WalletResponse _$WalletResponseFromJson(Map<String, dynamic> json) =>
    WalletResponse(
      json['address'] as String,
      json['publicKey'] as String,
      json['nonce'] as String,
      json['balance'] as String,
      json['attributes'],
      json['isDelegate'] as bool,
      json['isResigned'] as bool,
    );

Map<String, dynamic> _$WalletResponseToJson(WalletResponse instance) =>
    <String, dynamic>{
      'address': instance.address,
      'publicKey': instance.publicKey,
      'nonce': instance.nonce,
      'balance': instance.balance,
      'attributes': instance.attributes,
      'isDelegate': instance.isDelegate,
      'isResigned': instance.isResigned,
    };

NodeCryptoConfigResponse _$NodeCryptoConfigResponseFromJson(
        Map<String, dynamic> json) =>
    NodeCryptoConfigResponse(
      NodeCryptoConfigExceptions.fromJson(
          json['exceptions'] as Map<String, dynamic>),
      json['genesisBlock'] as Map<String, dynamic>,
      (json['milestones'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      NodeCryptoConfigNetwork.fromJson(json['network'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NodeCryptoConfigResponseToJson(
        NodeCryptoConfigResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions.toJson(),
      'genesisBlock': instance.genesisBlock,
      'milestones': instance.milestones,
      'network': instance.network.toJson(),
    };

NodeCryptoConfigExceptions _$NodeCryptoConfigExceptionsFromJson(
        Map<String, dynamic> json) =>
    NodeCryptoConfigExceptions(
      (json['blocks'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['transactions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      (json['outlookTable'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      (json['transactionIdFixTable'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$NodeCryptoConfigExceptionsToJson(
        NodeCryptoConfigExceptions instance) =>
    <String, dynamic>{
      'blocks': instance.blocks,
      'transactions': instance.transactions,
      'outlookTable': instance.outlookTable,
      'transactionIdFixTable': instance.transactionIdFixTable,
    };

NodeCryptoConfigNetwork _$NodeCryptoConfigNetworkFromJson(
        Map<String, dynamic> json) =>
    NodeCryptoConfigNetwork(
      json['name'] as String,
      json['messagePrefix'] as String,
      Map<String, int>.from(json['bip32'] as Map),
      json['pubKeyHash'] as int,
      json['nethash'] as String,
      json['wif'] as int,
      json['slip44'] as int,
      json['aip20'] as int,
      Map<String, String>.from(json['client'] as Map),
    );

Map<String, dynamic> _$NodeCryptoConfigNetworkToJson(
        NodeCryptoConfigNetwork instance) =>
    <String, dynamic>{
      'name': instance.name,
      'messagePrefix': instance.messagePrefix,
      'bip32': instance.bip32,
      'pubKeyHash': instance.pubKeyHash,
      'nethash': instance.nethash,
      'wif': instance.wif,
      'slip44': instance.slip44,
      'aip20': instance.aip20,
      'client': instance.client,
    };

Timestamp _$TimestampFromJson(Map<String, dynamic> json) => Timestamp(
      json['epoch'] as int,
      json['unix'] as int,
      json['human'] as String,
    );

Map<String, dynamic> _$TimestampToJson(Timestamp instance) => <String, dynamic>{
      'epoch': instance.epoch,
      'unix': instance.unix,
      'human': instance.human,
    };

TransactionStatusResponse _$TransactionStatusResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionStatusResponse(
      json['id'] as String?,
      json['blockId'] as String?,
      json['version'] as int?,
      json['type'] as int,
      json['typeGroup'] as int?,
      json['amount'] as String,
      json['fee'] as String,
      json['sender'] as String,
      json['senderPublicKey'] as String,
      json['recipient'] as String,
      json['signature'] as String?,
      json['signSignature'] as String?,
      (json['signatures'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['vendorField'] as String?,
      json['asset'] as Map<String, dynamic>?,
      json['confirmations'] as int,
      json['timestamp'] == null
          ? null
          : Timestamp.fromJson(json['timestamp'] as Map<String, dynamic>),
      json['nonce'] as String?,
    );

Map<String, dynamic> _$TransactionStatusResponseToJson(
    TransactionStatusResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['blockId'] = instance.blockId;
  val['version'] = instance.version;
  val['type'] = instance.type;
  val['typeGroup'] = instance.typeGroup;
  val['amount'] = instance.amount;
  val['fee'] = instance.fee;
  val['sender'] = instance.sender;
  val['senderPublicKey'] = instance.senderPublicKey;
  val['recipient'] = instance.recipient;
  val['signature'] = instance.signature;
  val['signSignature'] = instance.signSignature;
  val['signatures'] = instance.signatures;
  val['vendorField'] = instance.vendorField;
  val['asset'] = instance.asset;
  val['confirmations'] = instance.confirmations;
  val['timestamp'] = instance.timestamp?.toJson();
  val['nonce'] = instance.nonce;
  return val;
}

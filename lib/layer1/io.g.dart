// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'io.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendTransactionResponse _$SendTransactionResponseFromJson(
    Map<String, dynamic> json) {
  return SendTransactionResponse(
    (json['accept'] as List)?.map((e) => e as String)?.toList(),
    (json['broadcast'] as List)?.map((e) => e as String)?.toList(),
    (json['excess'] as List)?.map((e) => e as String)?.toList(),
    (json['invalid'] as List)?.map((e) => e as String)?.toList(),
    (json['errors'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$SendTransactionResponseToJson(
        SendTransactionResponse instance) =>
    <String, dynamic>{
      'accept': instance.accept,
      'broadcast': instance.broadcast,
      'excess': instance.excess,
      'invalid': instance.invalid,
      'errors': instance.errors,
    };

BlockchainResponse _$BlockchainResponseFromJson(Map<String, dynamic> json) {
  return BlockchainResponse(
    json['block'] == null
        ? null
        : BlockchainBlock.fromJson(json['block'] as Map<String, dynamic>),
    json['supply'] as String,
  );
}

Map<String, dynamic> _$BlockchainResponseToJson(BlockchainResponse instance) =>
    <String, dynamic>{
      'block': instance.block?.toJson(),
      'supply': instance.supply,
    };

BlockchainBlock _$BlockchainBlockFromJson(Map<String, dynamic> json) {
  return BlockchainBlock(
    json['id'] as String,
    json['height'] as int,
  );
}

Map<String, dynamic> _$BlockchainBlockToJson(BlockchainBlock instance) =>
    <String, dynamic>{
      'id': instance.id,
      'height': instance.height,
    };

WalletResponse _$WalletResponseFromJson(Map<String, dynamic> json) {
  return WalletResponse(
    json['address'] as String,
    json['publicKey'] as String,
    json['nonce'] as String,
    json['balance'] as String,
    json['attributes'],
    json['isDelegate'] as bool,
    json['isResigned'] as bool,
  );
}

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
    Map<String, dynamic> json) {
  return NodeCryptoConfigResponse(
    json['exceptions'] == null
        ? null
        : NodeCryptoConfigExceptions.fromJson(
            json['exceptions'] as Map<String, dynamic>),
    json['genesisBlock'] as Map<String, dynamic>,
    (json['milestones'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
    json['network'] == null
        ? null
        : NodeCryptoConfigNetwork.fromJson(
            json['network'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NodeCryptoConfigResponseToJson(
        NodeCryptoConfigResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions?.toJson(),
      'genesisBlock': instance.genesisBlock,
      'milestones': instance.milestones,
      'network': instance.network?.toJson(),
    };

NodeCryptoConfigExceptions _$NodeCryptoConfigExceptionsFromJson(
    Map<String, dynamic> json) {
  return NodeCryptoConfigExceptions(
    (json['blocks'] as List)?.map((e) => e as String)?.toList(),
    (json['transactions'] as List)?.map((e) => e as String)?.toList(),
    (json['outlookTable'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    (json['transactionIdFixTable'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$NodeCryptoConfigExceptionsToJson(
        NodeCryptoConfigExceptions instance) =>
    <String, dynamic>{
      'blocks': instance.blocks,
      'transactions': instance.transactions,
      'outlookTable': instance.outlookTable,
      'transactionIdFixTable': instance.transactionIdFixTable,
    };

NodeCryptoConfigNetwork _$NodeCryptoConfigNetworkFromJson(
    Map<String, dynamic> json) {
  return NodeCryptoConfigNetwork(
    json['name'] as String,
    json['messagePrefix'] as String,
    (json['bip32'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
    json['pubKeyHash'] as int,
    json['nethash'] as String,
    json['wif'] as int,
    json['slip44'] as int,
    json['aip20'] as int,
    (json['client'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

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

TransactionStatusResponse _$TransactionStatusResponseFromJson(
    Map<String, dynamic> json) {
  return TransactionStatusResponse(
    json['version'] as int,
    json['network'] as int,
    json['typeGroup'] as int,
    json['type'] as int,
    json['timestamp'] as Map<String, dynamic>,
    json['nonce'] as String,
    json['senderPublicKey'] as String,
    json['fee'] as String,
    json['amount'] as String,
    json['expiration'] as int,
    json['recipientId'] as String,
    json['asset'] as Map<String, dynamic>,
    json['vendorField'] as String,
    json['id'] as String,
    json['signature'] as String,
    json['secondSignature'] as String,
    json['signSignature'] as String,
    (json['signatures'] as List)?.map((e) => e as String)?.toList(),
    json['blockId'] as String,
    json['sequence'] as int,
    json['ipfsHash'] as String,
  );
}

Map<String, dynamic> _$TransactionStatusResponseToJson(
        TransactionStatusResponse instance) =>
    <String, dynamic>{
      'version': instance.version,
      'network': instance.network,
      'typeGroup': instance.typeGroup,
      'type': instance.type,
      'timestamp': instance.timestamp,
      'nonce': instance.nonce,
      'senderPublicKey': instance.senderPublicKey,
      'fee': instance.fee,
      'amount': instance.amount,
      'expiration': instance.expiration,
      'recipientId': instance.recipientId,
      'asset': instance.asset,
      'vendorField': instance.vendorField,
      'id': instance.id,
      'signature': instance.signature,
      'secondSignature': instance.secondSignature,
      'signSignature': instance.signSignature,
      'signatures': instance.signatures,
      'blockId': instance.blockId,
      'sequence': instance.sequence,
      'ipfsHash': instance.ipfsHash,
    };

import 'package:json_annotation/json_annotation.dart';

part 'io.g.dart';

@JsonSerializable(explicitToJson: true)
class WalletResponse {
  final String address;
  final String publicKey;
  final String nonce;
  final String balance;
  final dynamic attributes;
  final bool isDelegate;
  final bool isResigned;

  WalletResponse(
    this.address,
    this.publicKey,
    this.nonce,
    this.balance,
    this.attributes,
    this.isDelegate,
    this.isResigned,
  );

  factory WalletResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NodeCryptoConfigResponse {
  final NodeCryptoConfigExceptions exceptions;
  final Map<String, dynamic> genesisBlock;
  final List<Map<String, dynamic>> milestones;
  final NodeCryptoConfigNetwork network;

  NodeCryptoConfigResponse(
    this.exceptions,
    this.genesisBlock,
    this.milestones,
    this.network,
  );

  factory NodeCryptoConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$NodeCryptoConfigResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NodeCryptoConfigResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NodeCryptoConfigExceptions {
  final List<String> blocks;
  final List<String> transactions;
  final Map<String, String> outlookTable;
  final Map<String, String> transactionIdFixTable;

  NodeCryptoConfigExceptions(
    this.blocks,
    this.transactions,
    this.outlookTable,
    this.transactionIdFixTable,
  );

  factory NodeCryptoConfigExceptions.fromJson(Map<String, dynamic> json) =>
      _$NodeCryptoConfigExceptionsFromJson(json);

  Map<String, dynamic> toJson() => _$NodeCryptoConfigExceptionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NodeCryptoConfigNetwork {
  final String name;
  final String messagePrefix;
  final Map<String, int> bip32;
  final int pubKeyHash;
  final String nethash;
  final int wif;
  final int slip44;
  final int aip20;
  final Map<String, String> client;

  NodeCryptoConfigNetwork(
    this.name,
    this.messagePrefix,
    this.bip32,
    this.pubKeyHash,
    this.nethash,
    this.wif,
    this.slip44,
    this.aip20,
    this.client,
  );

  factory NodeCryptoConfigNetwork.fromJson(Map<String, dynamic> json) =>
      _$NodeCryptoConfigNetworkFromJson(json);

  Map<String, dynamic> toJson() => _$NodeCryptoConfigNetworkToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TransactionStatusResponse {
  final int version;
  final int network;
  final int typeGroup;
  final int type;
  final int timestamp;
  final String nonce;
  final String senderPublicKey;
  final String fee;
  final String amount;
  final int expiration;
  final String recipientId;
  final Map<String, dynamic> asset;
  final String vendorField;
  final String id;
  final String signature;
  final String secondSignature;
  final String signSignature;
  final List<String> signatures;
  final String blockId;
  final int sequence;
  final String ipfsHash;

  TransactionStatusResponse(
    this.version,
    this.network,
    this.typeGroup,
    this.type,
    this.timestamp,
    this.nonce,
    this.senderPublicKey,
    this.fee,
    this.amount,
    this.expiration,
    this.recipientId,
    this.asset,
    this.vendorField,
    this.id,
    this.signature,
    this.secondSignature,
    this.signSignature,
    this.signatures,
    this.blockId,
    this.sequence,
    this.ipfsHash,
  );

  factory TransactionStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionStatusResponseToJson(this);
}

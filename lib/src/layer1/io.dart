import 'package:json_annotation/json_annotation.dart';

part 'io.g.dart';

@JsonSerializable(explicitToJson: true)
class SendTransactionResponseData {
  final List<String> accept;
  final List<String> broadcast;
  final List<String> excess;
  final List<String> invalid;

  SendTransactionResponseData(
    this.accept,
    this.broadcast,
    this.excess,
    this.invalid,
  );

  factory SendTransactionResponseData.fromJson(Map<String, dynamic> json) =>
      _$SendTransactionResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$SendTransactionResponseDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SendTransactionResponse {
  final SendTransactionResponseData data;
  final dynamic errors;

  SendTransactionResponse(
    this.data,
    this.errors,
  );

  factory SendTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$SendTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendTransactionResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BlockchainResponse {
  final BlockchainBlock block;
  final String supply;

  BlockchainResponse(this.block, this.supply);

  factory BlockchainResponse.fromJson(Map<String, dynamic> json) =>
      _$BlockchainResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlockchainResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BlockchainBlock {
  final String id;
  final int height;

  BlockchainBlock(this.id, this.height);

  factory BlockchainBlock.fromJson(Map<String, dynamic> json) =>
      _$BlockchainBlockFromJson(json);

  Map<String, dynamic> toJson() => _$BlockchainBlockToJson(this);
}

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
  @JsonKey(nullable: true)
  final List<String> blocks;
  @JsonKey(nullable: true)
  final List<String> transactions;
  @JsonKey(nullable: true)
  final Map<String, String> outlookTable;
  @JsonKey(nullable: true)
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
class Timestamp {
  final int epoch;
  final int unix;
  final String human;

  Timestamp(
    this.epoch,
    this.unix,
    this.human,
  );

  factory Timestamp.fromJson(Map<String, dynamic> json) =>
      _$TimestampFromJson(json);

  Map<String, dynamic> toJson() => _$TimestampToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TransactionStatusResponse {
  @JsonKey(nullable: true, includeIfNull: false)
  final String id;
  @JsonKey(nullable: true)
  final String blockId;
  @JsonKey(nullable: true)
  final int version;
  final int type;
  @JsonKey(nullable: true)
  final int typeGroup;
  final String amount;
  final String fee;
  final String sender;
  final String senderPublicKey;
  final String recipient;
  @JsonKey(nullable: true)
  final String signature;
  @JsonKey(nullable: true)
  final String signSignature;
  @JsonKey(nullable: true)
  final List<String> signatures;
  @JsonKey(nullable: true)
  final String vendorField;
  @JsonKey(nullable: true)
  final Map<String, dynamic> asset;
  final int confirmations;
  @JsonKey(nullable: true)
  final Timestamp timestamp;
  @JsonKey(nullable: true)
  final String nonce;

  TransactionStatusResponse(
    this.id,
    this.blockId,
    this.version,
    this.type,
    this.typeGroup,
    this.amount,
    this.fee,
    this.sender,
    this.senderPublicKey,
    this.recipient,
    this.signature,
    this.signSignature,
    this.signatures,
    this.vendorField,
    this.asset,
    this.confirmations,
    this.timestamp,
    this.nonce,
  );

  factory TransactionStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionStatusResponseToJson(this);
}

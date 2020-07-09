import 'package:json_annotation/json_annotation.dart';

part 'io.g.dart';

@JsonSerializable(explicitToJson: true)
class SendTransactionResponse {
  final List<String> accept;
  final List<String> broadcast;
  final List<String> excess;
  final List<String> invalid;
  final List<String> errors;

  SendTransactionResponse(
    this.accept,
    this.broadcast,
    this.excess,
    this.invalid,
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
class TransactionStatusResponse {
  @JsonKey(nullable: true)
  final int version;
  @JsonKey(nullable: true)
  final int network;
  @JsonKey(nullable: true)
  final int typeGroup;
  final int type;
  @JsonKey(nullable: true)
  final Map<String, dynamic> timestamp;
  @JsonKey(nullable: true)
  final String nonce;
  final String senderPublicKey;
  final String fee;
  final String amount;
  @JsonKey(nullable: true)
  final int expiration;
  @JsonKey(nullable: true)
  final String recipientId;
  @JsonKey(nullable: true)
  final Map<String, dynamic> asset;
  final String vendorField;
  @JsonKey(nullable: true)
  final String id;
  @JsonKey(nullable: true)
  final String signature;
  @JsonKey(nullable: true)
  final String secondSignature;
  @JsonKey(nullable: true)
  final String signSignature;
  @JsonKey(nullable: true)
  final List<String> signatures;
  @JsonKey(nullable: true)
  final String blockId;
  @JsonKey(nullable: true)
  final int sequence;
  @JsonKey(nullable: true)
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

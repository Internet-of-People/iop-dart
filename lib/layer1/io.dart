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
  final Map<String, dynamic> timestamp;
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

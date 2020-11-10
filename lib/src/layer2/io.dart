import 'package:json_annotation/json_annotation.dart';
import 'package:iop_sdk/layer1.dart';
import 'package:iop_sdk/ssi.dart';

part 'io.g.dart';

@JsonSerializable(explicitToJson: true)
class BeforeProofHistoryResponse {
  final ContentId contentId;
  final int existsFromHeight;
  final int queriedAtHeight;

  BeforeProofHistoryResponse(
    this.contentId,
    this.existsFromHeight,
    this.queriedAtHeight,
  );

  factory BeforeProofHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$BeforeProofHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BeforeProofHistoryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TransactionIdHeight {
  final String transactionId;
  final int height;

  TransactionIdHeight(this.transactionId, this.height);

  factory TransactionIdHeight.fromJson(Map<String, dynamic> json) =>
      _$TransactionIdHeightFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionIdHeightToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DidOperation {
  final String transactionId;
  final int blockHeight;
  final SignableOperationData data;
  final bool valid;

  DidOperation(this.transactionId, this.blockHeight, this.data, this.valid);

  factory DidOperation.fromJson(Map<String, dynamic> json) =>
      _$DidOperationFromJson(json);

  Map<String, dynamic> toJson() => _$DidOperationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DryRunOperationError<T extends OperationData> {
  @JsonKey(nullable: true, fromJson: _dataFromJson, toJson: _dataToJson)
  final T invalidOperationAttempt;
  final String message;

  DryRunOperationError(this.invalidOperationAttempt, this.message);

  factory DryRunOperationError.fromJson(Map<String, dynamic> json) =>
      _$DryRunOperationErrorFromJson(json);

  Map<String, dynamic> toJson() => _$DryRunOperationErrorToJson(this);
}

T _dataFromJson<T>(Map<String, dynamic> input) => input['content'] as T;

Map<String, dynamic> _dataToJson<T>(T input) => {'content': input};

@JsonSerializable(explicitToJson: true)
class DomainSubtreePolicies {
  @JsonKey(nullable: true)
  final int expiration;
  @JsonKey(nullable: true)
  final dynamic schema;

  DomainSubtreePolicies(this.expiration, this.schema);

  factory DomainSubtreePolicies.fromJson(Map<String, dynamic> json) =>
      _$DomainSubtreePoliciesFromJson(json);

  Map<String, dynamic> toJson() => _$DomainSubtreePoliciesToJson(this);
}

enum DomainRegistraionPolicy {
  owner, any
}

@JsonSerializable(explicitToJson: true)
class DomainMetadata {
  final String owner;
  final DomainSubtreePolicies subtreePolicies;
  final DomainRegistraionPolicy registraionPolicy;
  final int expiresAtHeight;

  DomainMetadata(this.owner, this.subtreePolicies, this.registraionPolicy, this.expiresAtHeight);

  factory DomainMetadata.fromJson(Map<String, dynamic> json) =>
      _$DomainMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$DomainMetadataToJson(this);
}
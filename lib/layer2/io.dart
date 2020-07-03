import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_sdk/layer1/operation_data.dart';

part 'io.g.dart';

@JsonSerializable(explicitToJson: true)
class BeforeProofHistoryResponse {
  final String contentId;
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
class DryRunOperationError {
  final invalidOperationAttempt;
  final String message;

  DryRunOperationError(this.invalidOperationAttempt, this.message);

  factory DryRunOperationError.fromJson(Map<String, dynamic> json) =>
      _$DryRunOperationErrorFromJson(json);

  Map<String, dynamic> toJson() => _$DryRunOperationErrorToJson(this);
}
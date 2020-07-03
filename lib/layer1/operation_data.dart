import 'package:json_annotation/json_annotation.dart';

part 'operation_data.g.dart';

enum OperationType {
  signed,
  registerBeforeProof,
}

enum SignableOperationType {
  addKey,
  revokeKey,
  addRight,
  revokeRight,
  tombstoneDid,
}

@JsonSerializable(explicitToJson: true)
class SignableOperationData {
  final String did;
  final String lastTxId;
  final SignableOperationType operation;

  SignableOperationData(this.did, this.lastTxId, this.operation);

  factory SignableOperationData.fromJson(Map<String, dynamic> json) =>
      _$SignableOperationDataFromJson(json);

  Map<String, dynamic> toJson() => _$SignableOperationDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OperationData {
  final OperationType operation;

  OperationData(this.operation);

  factory OperationData.fromJson(Map<String, dynamic> json) =>
      _$OperationDataFromJson(json);

  Map<String, dynamic> toJson() => _$OperationDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignedOperationsData extends OperationData {
  final List<SignableOperationData> signables;
  final String signerPublicKey;
  final String signature;

  SignedOperationsData(this.signables, this.signerPublicKey, this.signature)
      : super(OperationType.signed);

  factory SignedOperationsData.fromJson(Map<String, dynamic> json) =>
      _$SignedOperationsDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignedOperationsDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RegisterBeforeProofData extends OperationData {
  final String contentId;

  RegisterBeforeProofData(this.contentId)
      : super(OperationType.registerBeforeProof);

  factory RegisterBeforeProofData.fromJson(Map<String, dynamic> json) =>
      _$RegisterBeforeProofDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RegisterBeforeProofDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddKeyData extends SignableOperationData {
  final String auth; // AuthenticationData in Ts
  final int expiresAtHeight;

  AddKeyData(
    String did,
    String lastTxId,
    this.auth, {
    int expiresAtHeight,
  })  : expiresAtHeight = expiresAtHeight,
        super(did, lastTxId, SignableOperationType.addKey);

  factory AddKeyData.fromJson(Map<String, dynamic> json) =>
      _$AddKeyDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AddKeyDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RevokeKeyData extends SignableOperationData {
  final String auth; // AuthenticationData in Ts

  RevokeKeyData(
    String did,
    String lastTxId,
    this.auth,
  ) : super(did, lastTxId, SignableOperationType.revokeKey);

  factory RevokeKeyData.fromJson(Map<String, dynamic> json) =>
      _$RevokeKeyDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RevokeKeyDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddRightData extends SignableOperationData {
  final String auth; // AuthenticationData in Ts
  final String right;

  AddRightData(
    String did,
    String lastTxId,
    this.auth,
    this.right,
  ) : super(did, lastTxId, SignableOperationType.addRight);

  factory AddRightData.fromJson(Map<String, dynamic> json) =>
      _$AddRightDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AddRightDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RevokeRightData extends SignableOperationData {
  final String auth; // AuthenticationData in Ts
  final String right;

  RevokeRightData(
    String did,
    String lastTxId,
    this.auth,
    this.right,
  ) : super(did, lastTxId, SignableOperationType.revokeRight);

  factory RevokeRightData.fromJson(Map<String, dynamic> json) =>
      _$RevokeRightDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RevokeRightDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TombstoneDidData extends SignableOperationData {
  TombstoneDidData(String did, String lastTxId)
      : super(did, lastTxId, SignableOperationType.tombstoneDid);

  factory TombstoneDidData.fromJson(Map<String, dynamic> json) =>
      _$TombstoneDidDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TombstoneDidDataToJson(this);
}

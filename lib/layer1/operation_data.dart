import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:iop_sdk/crypto/core.dart';
import 'package:iop_sdk/crypto/io.dart';
import 'package:iop_sdk/layer1/serde.dart' as serde;
import 'package:iop_sdk/ssi/io.dart';

part 'operation_data.g.dart';

enum OperationType {
  signed,
  registerBeforeProof,
}

extension OperationTypeExt on OperationType {
  String toJson() => toString().replaceAll('${runtimeType.toString()}.', '');
}

enum SignableOperationType {
  addKey,
  revokeKey,
  addRight,
  revokeRight,
  tombstoneDid,
}

extension SignableOperationTypeExt on SignableOperationType {
  String toJson() => toString().replaceAll('${runtimeType.toString()}.', '');
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
class SignableOperationData {
  final DidData did;
  final String lastTxId;
  final SignableOperationType operation;

  SignableOperationData(this.did, this.lastTxId, this.operation);

  factory SignableOperationData.fromJson(Map<String, dynamic> json) =>
      _$SignableOperationDataFromJson(json);

  Map<String, dynamic> toJson() => _$SignableOperationDataToJson(this);
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class SignedOperationsData extends OperationData {
  final List<SignableOperationData> signables;
  final PublicKeyData signerPublicKey;
  final SignatureData signature;

  SignedOperationsData(this.signables, this.signerPublicKey, this.signature)
      : super(OperationType.signed);

  factory SignedOperationsData.fromJson(Map<String, dynamic> json) =>
      _$SignedOperationsDataFromJson(json);

  static ByteData serialize(List<SignableOperationData> signables) {
    final canonicalJsonString = stringifyJson(
      signables.map((op) => op.toJson()).toList(),
    );
    return serde.serialize(canonicalJsonString);
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'operation': operation.toJson(),
        'signables': signables?.map((e) => e?.toJson())?.toList(),
        'signerPublicKey': signerPublicKey?.toJson(),
        'signature': signature?.toJson(),
      };
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class RegisterBeforeProofData extends OperationData {
  final ContentId contentId;

  RegisterBeforeProofData(this.contentId)
      : super(OperationType.registerBeforeProof);

  factory RegisterBeforeProofData.fromJson(Map<String, dynamic> json) =>
      _$RegisterBeforeProofDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'operation': operation.toJson(),
        'contentId': contentId?.toJson(),
      };
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class AddKeyData extends SignableOperationData {
  final AuthenticationData auth;
  final int expiresAtHeight;

  AddKeyData(
    DidData did,
    String lastTxId,
    this.auth, {
    int expiresAtHeight,
  })  : expiresAtHeight = expiresAtHeight,
        super(did, lastTxId, SignableOperationType.addKey);

  factory AddKeyData.fromJson(Map<String, dynamic> json) =>
      _$AddKeyDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'operation': operation.toJson(),
        'did': did?.toJson(),
        'lastTxId': lastTxId,
        'auth': auth?.toJson(),
        'expiresAtHeight': expiresAtHeight,
      };
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class RevokeKeyData extends SignableOperationData {
  final AuthenticationData auth;

  RevokeKeyData(
    DidData did,
    String lastTxId,
    this.auth,
  ) : super(did, lastTxId, SignableOperationType.revokeKey);

  factory RevokeKeyData.fromJson(Map<String, dynamic> json) =>
      _$RevokeKeyDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'operation': operation.toJson(),
        'did': did?.toJson(),
        'lastTxId': lastTxId,
        'auth': auth?.toJson(),
      };
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class AddRightData extends SignableOperationData {
  final AuthenticationData auth;
  final String right;

  AddRightData(
    DidData did,
    String lastTxId,
    this.auth,
    this.right,
  ) : super(did, lastTxId, SignableOperationType.addRight);

  factory AddRightData.fromJson(Map<String, dynamic> json) =>
      _$AddRightDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'operation': operation.toJson(),
        'did': did?.toJson(),
        'lastTxId': lastTxId,
        'auth': auth?.toJson(),
        'right': right,
      };
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class RevokeRightData extends SignableOperationData {
  final AuthenticationData auth;
  final String right;

  RevokeRightData(
    DidData did,
    String lastTxId,
    this.auth,
    this.right,
  ) : super(did, lastTxId, SignableOperationType.revokeRight);

  factory RevokeRightData.fromJson(Map<String, dynamic> json) =>
      _$RevokeRightDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'operation': operation.toJson(),
        'did': did?.toJson(),
        'lastTxId': lastTxId,
        'auth': auth?.toJson(),
        'right': right,
      };
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class TombstoneDidData extends SignableOperationData {
  TombstoneDidData(DidData did, String lastTxId)
      : super(did, lastTxId, SignableOperationType.tombstoneDid);

  factory TombstoneDidData.fromJson(Map<String, dynamic> json) =>
      _$TombstoneDidDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'operation': operation.toJson(),
        'did': did?.toJson(),
        'lastTxId': lastTxId,
      };
}

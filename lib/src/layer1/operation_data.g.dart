// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationData _$OperationDataFromJson(Map<String, dynamic> json) =>
    OperationData(
      $enumDecode(_$OperationTypeEnumMap, json['operation']),
    );

Map<String, dynamic> _$OperationDataToJson(OperationData instance) =>
    <String, dynamic>{
      'operation': _$OperationTypeEnumMap[instance.operation]!,
    };

const _$OperationTypeEnumMap = {
  OperationType.signed: 'signed',
  OperationType.registerBeforeProof: 'registerBeforeProof',
};

SignableOperationData _$SignableOperationDataFromJson(
        Map<String, dynamic> json) =>
    SignableOperationData(
      DidData.fromJson(json['did'] as String),
      json['lastTxId'] as String?,
      $enumDecode(_$SignableOperationTypeEnumMap, json['operation']),
    );

Map<String, dynamic> _$SignableOperationDataToJson(
        SignableOperationData instance) =>
    <String, dynamic>{
      'did': instance.did.toJson(),
      'lastTxId': instance.lastTxId,
      'operation': _$SignableOperationTypeEnumMap[instance.operation]!,
    };

const _$SignableOperationTypeEnumMap = {
  SignableOperationType.addKey: 'addKey',
  SignableOperationType.revokeKey: 'revokeKey',
  SignableOperationType.addRight: 'addRight',
  SignableOperationType.revokeRight: 'revokeRight',
  SignableOperationType.tombstoneDid: 'tombstoneDid',
};

SignedOperationsData _$SignedOperationsDataFromJson(
        Map<String, dynamic> json) =>
    SignedOperationsData(
      (json['signables'] as List<dynamic>)
          .map((e) => SignableOperationData.fromJson(e as Map<String, dynamic>))
          .toList(),
      PublicKeyData.fromJson(json['signerPublicKey'] as String),
      SignatureData.fromJson(json['signature'] as String),
    );

RegisterBeforeProofData _$RegisterBeforeProofDataFromJson(
        Map<String, dynamic> json) =>
    RegisterBeforeProofData(
      ContentId.fromJson(json['contentId'] as String),
    );

AddKeyData _$AddKeyDataFromJson(Map<String, dynamic> json) => AddKeyData(
      DidData.fromJson(json['did'] as String),
      json['lastTxId'] as String,
      AuthenticationData.fromJson(json['auth'] as String),
      expiresAtHeight: json['expiresAtHeight'] as int?,
    );

RevokeKeyData _$RevokeKeyDataFromJson(Map<String, dynamic> json) =>
    RevokeKeyData(
      DidData.fromJson(json['did'] as String),
      json['lastTxId'] as String,
      AuthenticationData.fromJson(json['auth'] as String),
    );

AddRightData _$AddRightDataFromJson(Map<String, dynamic> json) => AddRightData(
      DidData.fromJson(json['did'] as String),
      json['lastTxId'] as String,
      AuthenticationData.fromJson(json['auth'] as String),
      json['right'] as String,
    );

RevokeRightData _$RevokeRightDataFromJson(Map<String, dynamic> json) =>
    RevokeRightData(
      DidData.fromJson(json['did'] as String),
      json['lastTxId'] as String,
      AuthenticationData.fromJson(json['auth'] as String),
      json['right'] as String,
    );

TombstoneDidData _$TombstoneDidDataFromJson(Map<String, dynamic> json) =>
    TombstoneDidData(
      DidData.fromJson(json['did'] as String),
      json['lastTxId'] as String,
    );

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationData _$OperationDataFromJson(Map<String, dynamic> json) {
  return OperationData(
    _$enumDecodeNullable(_$OperationTypeEnumMap, json['operation']),
  );
}

Map<String, dynamic> _$OperationDataToJson(OperationData instance) =>
    <String, dynamic>{
      'operation': _$OperationTypeEnumMap[instance.operation],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$OperationTypeEnumMap = {
  OperationType.signed: 'signed',
  OperationType.registerBeforeProof: 'registerBeforeProof',
};

SignableOperationData _$SignableOperationDataFromJson(
    Map<String, dynamic> json) {
  return SignableOperationData(
    json['did'] == null ? null : DidData.fromJson(json['did'] as String),
    json['lastTxId'] as String,
    _$enumDecodeNullable(_$SignableOperationTypeEnumMap, json['operation']),
  );
}

Map<String, dynamic> _$SignableOperationDataToJson(
        SignableOperationData instance) =>
    <String, dynamic>{
      'did': instance.did?.toJson(),
      'lastTxId': instance.lastTxId,
      'operation': _$SignableOperationTypeEnumMap[instance.operation],
    };

const _$SignableOperationTypeEnumMap = {
  SignableOperationType.addKey: 'addKey',
  SignableOperationType.revokeKey: 'revokeKey',
  SignableOperationType.addRight: 'addRight',
  SignableOperationType.revokeRight: 'revokeRight',
  SignableOperationType.tombstoneDid: 'tombstoneDid',
};

SignedOperationsData _$SignedOperationsDataFromJson(Map<String, dynamic> json) {
  return SignedOperationsData(
    (json['signables'] as List)
        ?.map((e) => e == null
            ? null
            : SignableOperationData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['signerPublicKey'] == null
        ? null
        : PublicKeyData.fromJson(json['signerPublicKey'] as String),
    json['signature'] == null
        ? null
        : SignatureData.fromJson(json['signature'] as String),
  );
}

RegisterBeforeProofData _$RegisterBeforeProofDataFromJson(
    Map<String, dynamic> json) {
  return RegisterBeforeProofData(
    json['contentId'] == null
        ? null
        : ContentId.fromJson(json['contentId'] as String),
  );
}

AddKeyData _$AddKeyDataFromJson(Map<String, dynamic> json) {
  return AddKeyData(
    json['did'] == null ? null : DidData.fromJson(json['did'] as String),
    json['lastTxId'] as String,
    json['auth'] == null
        ? null
        : AuthenticationData.fromJson(json['auth'] as String),
    expiresAtHeight: json['expiresAtHeight'] as int,
  );
}

RevokeKeyData _$RevokeKeyDataFromJson(Map<String, dynamic> json) {
  return RevokeKeyData(
    json['did'] == null ? null : DidData.fromJson(json['did'] as String),
    json['lastTxId'] as String,
    json['auth'] == null
        ? null
        : AuthenticationData.fromJson(json['auth'] as String),
  );
}

AddRightData _$AddRightDataFromJson(Map<String, dynamic> json) {
  return AddRightData(
    json['did'] == null ? null : DidData.fromJson(json['did'] as String),
    json['lastTxId'] as String,
    json['auth'] == null
        ? null
        : AuthenticationData.fromJson(json['auth'] as String),
    json['right'] as String,
  );
}

RevokeRightData _$RevokeRightDataFromJson(Map<String, dynamic> json) {
  return RevokeRightData(
    json['did'] == null ? null : DidData.fromJson(json['did'] as String),
    json['lastTxId'] as String,
    json['auth'] == null
        ? null
        : AuthenticationData.fromJson(json['auth'] as String),
    json['right'] as String,
  );
}

TombstoneDidData _$TombstoneDidDataFromJson(Map<String, dynamic> json) {
  return TombstoneDidData(
    json['did'] == null ? null : DidData.fromJson(json['did'] as String),
    json['lastTxId'] as String,
  );
}

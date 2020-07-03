// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignableOperationData _$SignableOperationDataFromJson(
    Map<String, dynamic> json) {
  return SignableOperationData(
    json['did'] as String,
    json['lastTxId'] as String,
    _$enumDecodeNullable(_$SignableOperationTypeEnumMap, json['operation']),
  );
}

Map<String, dynamic> _$SignableOperationDataToJson(
        SignableOperationData instance) =>
    <String, dynamic>{
      'did': instance.did,
      'lastTxId': instance.lastTxId,
      'operation': _$SignableOperationTypeEnumMap[instance.operation],
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

const _$SignableOperationTypeEnumMap = {
  SignableOperationType.addKey: 'addKey',
  SignableOperationType.revokeKey: 'revokeKey',
  SignableOperationType.addRight: 'addRight',
  SignableOperationType.revokeRight: 'revokeRight',
  SignableOperationType.tombstoneDid: 'tombstoneDid',
};

OperationData _$OperationDataFromJson(Map<String, dynamic> json) {
  return OperationData(
    _$enumDecodeNullable(_$OperationTypeEnumMap, json['operation']),
  );
}

Map<String, dynamic> _$OperationDataToJson(OperationData instance) =>
    <String, dynamic>{
      'operation': _$OperationTypeEnumMap[instance.operation],
    };

const _$OperationTypeEnumMap = {
  OperationType.signed: 'signed',
  OperationType.registerBeforeProof: 'registerBeforeProof',
};

SignedOperationsData _$SignedOperationsDataFromJson(Map<String, dynamic> json) {
  return SignedOperationsData(
    (json['signables'] as List)
        ?.map((e) => e == null
            ? null
            : SignableOperationData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['signerPublicKey'] as String,
    json['signature'] as String,
  );
}

Map<String, dynamic> _$SignedOperationsDataToJson(
        SignedOperationsData instance) =>
    <String, dynamic>{
      'signables': instance.signables?.map((e) => e?.toJson())?.toList(),
      'signerPublicKey': instance.signerPublicKey,
      'signature': instance.signature,
    };

RegisterBeforeProofData _$RegisterBeforeProofDataFromJson(
    Map<String, dynamic> json) {
  return RegisterBeforeProofData(
    json['contentId'] as String,
  );
}

Map<String, dynamic> _$RegisterBeforeProofDataToJson(
        RegisterBeforeProofData instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
    };

AddKeyData _$AddKeyDataFromJson(Map<String, dynamic> json) {
  return AddKeyData(
    json['did'] as String,
    json['lastTxId'] as String,
    json['auth'] as String,
    expiresAtHeight: json['expiresAtHeight'] as int,
  );
}

Map<String, dynamic> _$AddKeyDataToJson(AddKeyData instance) =>
    <String, dynamic>{
      'did': instance.did,
      'lastTxId': instance.lastTxId,
      'auth': instance.auth,
      'expiresAtHeight': instance.expiresAtHeight,
    };

RevokeKeyData _$RevokeKeyDataFromJson(Map<String, dynamic> json) {
  return RevokeKeyData(
    json['did'] as String,
    json['lastTxId'] as String,
    json['auth'] as String,
  );
}

Map<String, dynamic> _$RevokeKeyDataToJson(RevokeKeyData instance) =>
    <String, dynamic>{
      'did': instance.did,
      'lastTxId': instance.lastTxId,
      'auth': instance.auth,
    };

AddRightData _$AddRightDataFromJson(Map<String, dynamic> json) {
  return AddRightData(
    json['did'] as String,
    json['lastTxId'] as String,
    json['auth'] as String,
    json['right'] as String,
  );
}

Map<String, dynamic> _$AddRightDataToJson(AddRightData instance) =>
    <String, dynamic>{
      'did': instance.did,
      'lastTxId': instance.lastTxId,
      'auth': instance.auth,
      'right': instance.right,
    };

RevokeRightData _$RevokeRightDataFromJson(Map<String, dynamic> json) {
  return RevokeRightData(
    json['did'] as String,
    json['lastTxId'] as String,
    json['auth'] as String,
    json['right'] as String,
  );
}

Map<String, dynamic> _$RevokeRightDataToJson(RevokeRightData instance) =>
    <String, dynamic>{
      'did': instance.did,
      'lastTxId': instance.lastTxId,
      'auth': instance.auth,
      'right': instance.right,
    };

TombstoneDidData _$TombstoneDidDataFromJson(Map<String, dynamic> json) {
  return TombstoneDidData(
    json['did'] as String,
    json['lastTxId'] as String,
  );
}

Map<String, dynamic> _$TombstoneDidDataToJson(TombstoneDidData instance) =>
    <String, dynamic>{
      'did': instance.did,
      'lastTxId': instance.lastTxId,
    };

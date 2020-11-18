// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'io.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeforeProofHistoryResponse _$BeforeProofHistoryResponseFromJson(
    Map<String, dynamic> json) {
  return BeforeProofHistoryResponse(
    json['contentId'] == null
        ? null
        : ContentId.fromJson(json['contentId'] as String),
    json['existsFromHeight'] as int,
    json['queriedAtHeight'] as int,
  );
}

Map<String, dynamic> _$BeforeProofHistoryResponseToJson(
        BeforeProofHistoryResponse instance) =>
    <String, dynamic>{
      'contentId': instance.contentId?.toJson(),
      'existsFromHeight': instance.existsFromHeight,
      'queriedAtHeight': instance.queriedAtHeight,
    };

TransactionIdHeight _$TransactionIdHeightFromJson(Map<String, dynamic> json) {
  return TransactionIdHeight(
    json['transactionId'] as String,
    json['height'] as int,
  );
}

Map<String, dynamic> _$TransactionIdHeightToJson(
        TransactionIdHeight instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'height': instance.height,
    };

DidOperation _$DidOperationFromJson(Map<String, dynamic> json) {
  return DidOperation(
    json['transactionId'] as String,
    json['blockHeight'] as int,
    json['data'] == null
        ? null
        : SignableOperationData.fromJson(json['data'] as Map<String, dynamic>),
    json['valid'] as bool,
  );
}

Map<String, dynamic> _$DidOperationToJson(DidOperation instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'blockHeight': instance.blockHeight,
      'data': instance.data?.toJson(),
      'valid': instance.valid,
    };

DryRunOperationError<T> _$DryRunOperationErrorFromJson<T extends OperationData>(
    Map<String, dynamic> json) {
  return DryRunOperationError<T>(
    _dataFromJson(json['invalidOperationAttempt'] as Map<String, dynamic>),
    json['message'] as String,
  );
}

Map<String, dynamic> _$DryRunOperationErrorToJson<T extends OperationData>(
        DryRunOperationError<T> instance) =>
    <String, dynamic>{
      'invalidOperationAttempt': _dataToJson(instance.invalidOperationAttempt),
      'message': instance.message,
    };

DomainSubtreePolicies _$DomainSubtreePoliciesFromJson(
    Map<String, dynamic> json) {
  return DomainSubtreePolicies(
    json['expiration'] as int,
    json['schema'],
  );
}

Map<String, dynamic> _$DomainSubtreePoliciesToJson(
        DomainSubtreePolicies instance) =>
    <String, dynamic>{
      'expiration': instance.expiration,
      'schema': instance.schema,
    };

DomainMetadata _$DomainMetadataFromJson(Map<String, dynamic> json) {
  return DomainMetadata(
    json['owner'] as String,
    json['subtreePolicies'] == null
        ? null
        : DomainSubtreePolicies.fromJson(
            json['subtreePolicies'] as Map<String, dynamic>),
    _$enumDecodeNullable(
        _$DomainRegistrationPolicyEnumMap, json['registrationPolicy']),
    json['expiresAtHeight'] as int,
  );
}

Map<String, dynamic> _$DomainMetadataToJson(DomainMetadata instance) =>
    <String, dynamic>{
      'owner': instance.owner,
      'subtreePolicies': instance.subtreePolicies?.toJson(),
      'registrationPolicy':
          _$DomainRegistrationPolicyEnumMap[instance.registrationPolicy],
      'expiresAtHeight': instance.expiresAtHeight,
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

const _$DomainRegistrationPolicyEnumMap = {
  DomainRegistrationPolicy.owner: 'owner',
  DomainRegistrationPolicy.any: 'any',
};

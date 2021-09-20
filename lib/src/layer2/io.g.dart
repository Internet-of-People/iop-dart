// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'io.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeforeProofHistoryResponse _$BeforeProofHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    BeforeProofHistoryResponse(
      ContentId.fromJson(json['contentId'] as String),
      json['existsFromHeight'] as int?,
      json['txid'] as String?,
      json['queriedAtHeight'] as int,
    );

Map<String, dynamic> _$BeforeProofHistoryResponseToJson(
        BeforeProofHistoryResponse instance) =>
    <String, dynamic>{
      'contentId': instance.contentId.toJson(),
      'existsFromHeight': instance.existsFromHeight,
      'txid': instance.txid,
      'queriedAtHeight': instance.queriedAtHeight,
    };

TransactionIdHeight _$TransactionIdHeightFromJson(Map<String, dynamic> json) =>
    TransactionIdHeight(
      json['transactionId'] as String,
      json['height'] as int,
    );

Map<String, dynamic> _$TransactionIdHeightToJson(
        TransactionIdHeight instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'height': instance.height,
    };

DidOperation _$DidOperationFromJson(Map<String, dynamic> json) => DidOperation(
      json['transactionId'] as String,
      json['blockHeight'] as int,
      SignableOperationData.fromJson(json['data'] as Map<String, dynamic>),
      json['valid'] as bool,
    );

Map<String, dynamic> _$DidOperationToJson(DidOperation instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'blockHeight': instance.blockHeight,
      'data': instance.data.toJson(),
      'valid': instance.valid,
    };

DryRunOperationError<T> _$DryRunOperationErrorFromJson<T extends OperationData>(
        Map<String, dynamic> json) =>
    DryRunOperationError<T>(
      _dataFromJson(json['invalidOperationAttempt'] as Map<String, dynamic>),
      json['message'] as String,
    );

Map<String, dynamic> _$DryRunOperationErrorToJson<T extends OperationData>(
        DryRunOperationError<T> instance) =>
    <String, dynamic>{
      'invalidOperationAttempt': _dataToJson(instance.invalidOperationAttempt),
      'message': instance.message,
    };

DomainSubtreePolicies _$DomainSubtreePoliciesFromJson(
        Map<String, dynamic> json) =>
    DomainSubtreePolicies(
      json['expiration'] as int?,
      json['schema'],
    );

Map<String, dynamic> _$DomainSubtreePoliciesToJson(
        DomainSubtreePolicies instance) =>
    <String, dynamic>{
      'expiration': instance.expiration,
      'schema': instance.schema,
    };

DomainMetadata _$DomainMetadataFromJson(Map<String, dynamic> json) =>
    DomainMetadata(
      json['owner'] as String,
      DomainSubtreePolicies.fromJson(
          json['subtreePolicies'] as Map<String, dynamic>),
      _$enumDecode(
          _$DomainRegistrationPolicyEnumMap, json['registrationPolicy']),
      json['expiresAtHeight'] as int,
    );

Map<String, dynamic> _$DomainMetadataToJson(DomainMetadata instance) =>
    <String, dynamic>{
      'owner': instance.owner,
      'subtreePolicies': instance.subtreePolicies.toJson(),
      'registrationPolicy':
          _$DomainRegistrationPolicyEnumMap[instance.registrationPolicy],
      'expiresAtHeight': instance.expiresAtHeight,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$DomainRegistrationPolicyEnumMap = {
  DomainRegistrationPolicy.owner: 'owner',
  DomainRegistrationPolicy.any: 'any',
};

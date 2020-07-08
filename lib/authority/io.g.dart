// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'io.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestEntry _$RequestEntryFromJson(Map<String, dynamic> json) {
  return RequestEntry(
    json['capabilityLink'] == null
        ? null
        : CapabilityLink.fromJson(
            json['capabilityLink'] as Map<String, dynamic>),
    json['requestId'] == null
        ? null
        : ContentId.fromJson(json['requestId'] as Map<String, dynamic>),
    json['dateOfRequest'] == null
        ? null
        : DateTime.parse(json['dateOfRequest'] as String),
    _$enumDecodeNullable(_$StatusEnumMap, json['status']),
    json['processId'] == null
        ? null
        : ContentId.fromJson(json['processId'] as Map<String, dynamic>),
    json['notes'] as String,
  );
}

Map<String, dynamic> _$RequestEntryToJson(RequestEntry instance) =>
    <String, dynamic>{
      'capabilityLink': instance.capabilityLink?.toJson(),
      'requestId': instance.requestId?.toJson(),
      'dateOfRequest': instance.dateOfRequest?.toIso8601String(),
      'status': _$StatusEnumMap[instance.status],
      'processId': instance.processId?.toJson(),
      'notes': instance.notes,
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

const _$StatusEnumMap = {
  Status.pending: 'pending',
  Status.approved: 'approved',
  Status.rejected: 'rejected',
};

CapabilityLink _$CapabilityLinkFromJson(Map<String, dynamic> json) {
  return CapabilityLink(
    json['value'] as String,
  );
}

Map<String, dynamic> _$CapabilityLinkToJson(CapabilityLink instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

RequestStatus _$RequestStatusFromJson(Map<String, dynamic> json) {
  return RequestStatus(
    _$enumDecodeNullable(_$StatusEnumMap, json['status']),
    json['signedStatement'] == null
        ? null
        : WitnessStatement.fromJson(
            json['signedStatement'] as Map<String, dynamic>),
    json['rejectionReason'] as String,
  );
}

Map<String, dynamic> _$RequestStatusToJson(RequestStatus instance) =>
    <String, dynamic>{
      'status': _$StatusEnumMap[instance.status],
      'signedStatement': instance.signedStatement?.toJson(),
      'rejectionReason': instance.rejectionReason,
    };

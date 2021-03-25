// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'io.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestEntry _$RequestEntryFromJson(Map<String, dynamic> json) {
  return RequestEntry(
    CapabilityLink.fromJson(json['capabilityLink'] as String),
    ContentId.fromJson(json['requestId'] as String),
    DateTime.parse(json['dateOfRequest'] as String),
    _$enumDecode(_$StatusEnumMap, json['status']),
    ContentId.fromJson(json['processId'] as String),
    json['notes'] as String?,
  );
}

Map<String, dynamic> _$RequestEntryToJson(RequestEntry instance) =>
    <String, dynamic>{
      'capabilityLink': instance.capabilityLink.toJson(),
      'requestId': instance.requestId.toJson(),
      'dateOfRequest': instance.dateOfRequest.toIso8601String(),
      'status': _$StatusEnumMap[instance.status],
      'processId': instance.processId.toJson(),
      'notes': instance.notes,
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
    _$enumDecode(_$StatusEnumMap, json['status']),
    json['signedStatement'] == null
        ? null
        : Signed.fromJson(json['signedStatement'] as Map<String, dynamic>),
    json['rejectionReason'] as String?,
  );
}

Map<String, dynamic> _$RequestStatusToJson(RequestStatus instance) =>
    <String, dynamic>{
      'status': _$StatusEnumMap[instance.status],
      'signedStatement': instance.signedStatement?.toJson(),
      'rejectionReason': instance.rejectionReason,
    };

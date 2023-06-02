// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'io.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Process _$ProcessFromJson(Map<String, dynamic> json) => Process(
      json['name'] as String,
      json['version'] as int,
      json['description'] as String,
      Content<DynamicContent>.fromJson(json['claimSchema']),
      json['evidenceSchema'] == null
          ? null
          : Content<DynamicContent>.fromJson(json['evidenceSchema']),
      json['constraintsSchema'] == null
          ? null
          : Content<DynamicContent>.fromJson(json['constraintsSchema']),
    );

Map<String, dynamic> _$ProcessToJson(Process instance) => <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
      'description': instance.description,
      'claimSchema': instance.claimSchema.toJson(),
      'evidenceSchema': instance.evidenceSchema?.toJson(),
      'constraintsSchema': instance.constraintsSchema?.toJson(),
    };

RequestEntry _$RequestEntryFromJson(Map<String, dynamic> json) => RequestEntry(
      CapabilityLink.fromJson(json['capabilityLink'] as String),
      ContentId.fromJson(json['requestId'] as String),
      DateTime.parse(json['dateOfRequest'] as String),
      $enumDecode(_$StatusEnumMap, json['status']),
      ContentId.fromJson(json['processId'] as String),
      json['notes'] as String?,
    );

Map<String, dynamic> _$RequestEntryToJson(RequestEntry instance) =>
    <String, dynamic>{
      'capabilityLink': instance.capabilityLink.toJson(),
      'requestId': instance.requestId.toJson(),
      'dateOfRequest': instance.dateOfRequest.toIso8601String(),
      'status': _$StatusEnumMap[instance.status]!,
      'processId': instance.processId.toJson(),
      'notes': instance.notes,
    };

const _$StatusEnumMap = {
  Status.pending: 'pending',
  Status.approved: 'approved',
  Status.rejected: 'rejected',
};

CapabilityLink _$CapabilityLinkFromJson(Map<String, dynamic> json) =>
    CapabilityLink(
      json['value'] as String,
    );

Map<String, dynamic> _$CapabilityLinkToJson(CapabilityLink instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

RequestStatus _$RequestStatusFromJson(Map<String, dynamic> json) =>
    RequestStatus(
      $enumDecode(_$StatusEnumMap, json['status']),
      json['signedStatement'] == null
          ? null
          : Signed<WitnessStatement>.fromJson(
              json['signedStatement'] as Map<String, dynamic>),
      json['rejectionReason'] as String?,
    );

Map<String, dynamic> _$RequestStatusToJson(RequestStatus instance) =>
    <String, dynamic>{
      'status': _$StatusEnumMap[instance.status]!,
      'signedStatement': instance.signedStatement?.toJson(),
      'rejectionReason': instance.rejectionReason,
    };

SendRequestResponse _$SendRequestResponseFromJson(Map<String, dynamic> json) =>
    SendRequestResponse(
      CapabilityLink.fromJson(json['capabilityLink'] as String),
    );

Map<String, dynamic> _$SendRequestResponseToJson(
        SendRequestResponse instance) =>
    <String, dynamic>{
      'capabilityLink': instance.capabilityLink.toJson(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListProcessesResponse _$ListProcessesResponseFromJson(
    Map<String, dynamic> json) {
  return ListProcessesResponse(
    (json['processes'] as List)
        ?.map((e) => e == null ? null : ContentId.fromJson(e as String))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListProcessesResponseToJson(
        ListProcessesResponse instance) =>
    <String, dynamic>{
      'processes': instance.processes?.map((e) => e?.toJson())?.toList(),
    };

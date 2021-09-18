// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListRequestsResponse _$ListRequestsResponseFromJson(
        Map<String, dynamic> json) =>
    ListRequestsResponse(
      (json['requests'] as List<dynamic>)
          .map((e) => RequestEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListRequestsResponseToJson(
        ListRequestsResponse instance) =>
    <String, dynamic>{
      'requests': instance.requests.map((e) => e.toJson()).toList(),
    };

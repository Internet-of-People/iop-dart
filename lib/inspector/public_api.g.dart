// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListScenariosResponse _$ListScenariosResponseFromJson(
    Map<String, dynamic> json) {
  return ListScenariosResponse(
    (json['scenarios'] as List)
        ?.map((e) => e == null ? null : ContentId.fromJson(e as String))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListScenariosResponseToJson(
        ListScenariosResponse instance) =>
    <String, dynamic>{
      'scenarios': instance.scenarios?.map((e) => e?.toJson())?.toList(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyData _$KeyDataFromJson(Map<String, dynamic> json) {
  return KeyData(
    json['index'] as int,
    json['auth'] as String,
    json['validFromHeight'] as int,
    json['validUntilHeight'] as int,
    json['valid'] as bool,
  );
}

Map<String, dynamic> _$KeyDataToJson(KeyData instance) => <String, dynamic>{
      'index': instance.index,
      'auth': instance.auth,
      'validFromHeight': instance.validFromHeight,
      'validUntilHeight': instance.validUntilHeight,
      'valid': instance.valid,
    };

KeyRightHistoryPoint _$KeyRightHistoryPointFromJson(Map<String, dynamic> json) {
  return KeyRightHistoryPoint(
    json['height'] as int,
    json['valid'] as bool,
  );
}

Map<String, dynamic> _$KeyRightHistoryPointToJson(
        KeyRightHistoryPoint instance) =>
    <String, dynamic>{
      'height': instance.height,
      'valid': instance.valid,
    };

KeyRightHistory _$KeyRightHistoryFromJson(Map<String, dynamic> json) {
  return KeyRightHistory(
    json['keyLink'] as String,
    (json['history'] as List)
        ?.map((e) => e == null
            ? null
            : KeyRightHistoryPoint.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['valid'] as bool,
  );
}

Map<String, dynamic> _$KeyRightHistoryToJson(KeyRightHistory instance) =>
    <String, dynamic>{
      'keyLink': instance.keyLink,
      'history': instance.history?.map((e) => e?.toJson())?.toList(),
      'valid': instance.valid,
    };

DidData _$DidDataFromJson(Map<String, dynamic> json) {
  return DidData(
    json['did'] as String,
    (json['keys'] as List)
        ?.map((e) =>
            e == null ? null : KeyData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['rights'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          (e as List)
              ?.map((e) => e == null
                  ? null
                  : KeyRightHistory.fromJson(e as Map<String, dynamic>))
              ?.toList()),
    ),
    json['tombstoned'] as bool,
    json['tombstonedAtHeight'] as int,
    json['queriedAtHeight'] as int,
  );
}

Map<String, dynamic> _$DidDataToJson(DidData instance) => <String, dynamic>{
      'did': instance.did,
      'keys': instance.keys?.map((e) => e?.toJson())?.toList(),
      'rights': instance.rights
          ?.map((k, e) => MapEntry(k, e?.map((e) => e?.toJson())?.toList())),
      'tombstoned': instance.tombstoned,
      'tombstonedAtHeight': instance.tombstonedAtHeight,
      'queriedAtHeight': instance.queriedAtHeight,
    };

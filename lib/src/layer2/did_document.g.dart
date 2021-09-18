// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyData _$KeyDataFromJson(Map<String, dynamic> json) => KeyData(
      json['index'] as int,
      AuthenticationData.fromJson(json['auth'] as String),
      json['validFromHeight'] as int?,
      json['validUntilHeight'] as int?,
      json['valid'] as bool,
    );

Map<String, dynamic> _$KeyDataToJson(KeyData instance) => <String, dynamic>{
      'index': instance.index,
      'auth': instance.auth.toJson(),
      'validFromHeight': instance.validFromHeight,
      'validUntilHeight': instance.validUntilHeight,
      'valid': instance.valid,
    };

KeyRightHistoryPoint _$KeyRightHistoryPointFromJson(
        Map<String, dynamic> json) =>
    KeyRightHistoryPoint(
      json['height'] as int?,
      json['valid'] as bool,
    );

Map<String, dynamic> _$KeyRightHistoryPointToJson(
        KeyRightHistoryPoint instance) =>
    <String, dynamic>{
      'height': instance.height,
      'valid': instance.valid,
    };

KeyRightHistory _$KeyRightHistoryFromJson(Map<String, dynamic> json) =>
    KeyRightHistory(
      KeyLink.fromJson(json['keyLink'] as String),
      (json['history'] as List<dynamic>)
          .map((e) => KeyRightHistoryPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['valid'] as bool,
    );

Map<String, dynamic> _$KeyRightHistoryToJson(KeyRightHistory instance) =>
    <String, dynamic>{
      'keyLink': instance.keyLink.toJson(),
      'history': instance.history.map((e) => e.toJson()).toList(),
      'valid': instance.valid,
    };

DidDocumentData _$DidDocumentDataFromJson(Map<String, dynamic> json) =>
    DidDocumentData(
      DidData.fromJson(json['did'] as String),
      (json['keys'] as List<dynamic>)
          .map((e) => KeyData.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['rights'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => KeyRightHistory.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      json['tombstoned'] as bool,
      json['tombstonedAtHeight'] as int?,
      json['queriedAtHeight'] as int,
    );

Map<String, dynamic> _$DidDocumentDataToJson(DidDocumentData instance) {
  final val = <String, dynamic>{
    'did': instance.did.toJson(),
    'keys': instance.keys.map((e) => e.toJson()).toList(),
    'rights': instance.rights
        .map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
    'tombstoned': instance.tombstoned,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tombstonedAtHeight', instance.tombstonedAtHeight);
  val['queriedAtHeight'] = instance.queriedAtHeight;
  return val;
}

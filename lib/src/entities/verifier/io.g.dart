// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'io.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidationResult _$ValidationResultFromJson(Map<String, dynamic> json) {
  return ValidationResult(
    (json['errors'] as List)?.map((e) => e as String)?.toList(),
    (json['warnings'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ValidationResultToJson(ValidationResult instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'warnings': instance.warnings,
    };

ValidationRequest _$ValidationRequestFromJson(Map<String, dynamic> json) {
  return ValidationRequest(
    json['publicKey'] == null
        ? null
        : PublicKeyData.fromJson(json['publicKey'] as String),
    json['contentId'] == null
        ? null
        : ContentId.fromJson(json['contentId'] as String),
    json['signature'] == null
        ? null
        : SignatureData.fromJson(json['signature'] as String),
    json['onBehalfOf'] == null
        ? null
        : DidData.fromJson(json['onBehalfOf'] as String),
    json['afterProof'] == null
        ? null
        : AfterProof.fromJson(json['afterProof'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ValidationRequestToJson(ValidationRequest instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey?.toJson(),
      'contentId': instance.contentId?.toJson(),
      'signature': instance.signature?.toJson(),
      'onBehalfOf': instance.onBehalfOf?.toJson(),
      'afterProof': instance.afterProof?.toJson(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'io.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidationResult _$ValidationResultFromJson(Map<String, dynamic> json) =>
    ValidationResult(
      (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      (json['warnings'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ValidationResultToJson(ValidationResult instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'warnings': instance.warnings,
    };

ValidationRequest _$ValidationRequestFromJson(Map<String, dynamic> json) =>
    ValidationRequest(
      PublicKeyData.fromJson(json['publicKey'] as String),
      ContentId.fromJson(json['contentId'] as String),
      SignatureData.fromJson(json['signature'] as String),
      DidData.fromJson(json['onBehalfOf'] as String),
      json['afterProof'] == null
          ? null
          : AfterProof.fromJson(json['afterProof'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValidationRequestToJson(ValidationRequest instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey.toJson(),
      'contentId': instance.contentId.toJson(),
      'signature': instance.signature.toJson(),
      'onBehalfOf': instance.onBehalfOf.toJson(),
      'afterProof': instance.afterProof?.toJson(),
    };

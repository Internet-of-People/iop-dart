// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'io.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scenario _$ScenarioFromJson(Map<String, dynamic> json) => Scenario(
      json['name'] as String,
      json['version'] as int,
      json['description'] as String,
      (json['prerequisites'] as List<dynamic>)
          .map((e) => Prerequisite.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['requiredLicenses'] as List<dynamic>)
          .map((e) => LicenseSpecification.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['resultSchema'] == null
          ? null
          : Content.fromJson(json['resultSchema']),
    );

Map<String, dynamic> _$ScenarioToJson(Scenario instance) => <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
      'description': instance.description,
      'prerequisites': instance.prerequisites.map((e) => e.toJson()).toList(),
      'requiredLicenses':
          instance.requiredLicenses.map((e) => e.toJson()).toList(),
      'resultSchema': instance.resultSchema?.toJson(),
    };

Prerequisite _$PrerequisiteFromJson(Map<String, dynamic> json) => Prerequisite(
      Content.fromJson(json['process']),
      (json['claimFields'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PrerequisiteToJson(Prerequisite instance) =>
    <String, dynamic>{
      'process': instance.process.toJson(),
      'claimFields': instance.claimFields,
    };

LicenseSpecification _$LicenseSpecificationFromJson(
        Map<String, dynamic> json) =>
    LicenseSpecification(
      DidData.fromJson(json['issuedTo'] as String),
      json['purpose'] as String,
      json['expiry'] as String,
    );

Map<String, dynamic> _$LicenseSpecificationToJson(
        LicenseSpecification instance) =>
    <String, dynamic>{
      'issuedTo': instance.issuedTo.toJson(),
      'purpose': instance.purpose,
      'expiry': instance.expiry,
    };

UploadPresentationResponse _$UploadPresentationResponseFromJson(
        Map<String, dynamic> json) =>
    UploadPresentationResponse(
      ContentId.fromJson(json['contentId'] as String),
    );

Map<String, dynamic> _$UploadPresentationResponseToJson(
        UploadPresentationResponse instance) =>
    <String, dynamic>{
      'contentId': instance.contentId.toJson(),
    };

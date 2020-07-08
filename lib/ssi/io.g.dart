// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'io.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyLink _$KeyLinkFromJson(Map<String, dynamic> json) {
  return KeyLink(
    json['value'] as String,
  );
}

Map<String, dynamic> _$KeyLinkToJson(KeyLink instance) => <String, dynamic>{
      'value': instance.value,
    };

ContentId _$ContentIdFromJson(Map<String, dynamic> json) {
  return ContentId(
    json['value'] as String,
  );
}

Map<String, dynamic> _$ContentIdToJson(ContentId instance) => <String, dynamic>{
      'value': instance.value,
    };

DynamicContent _$DynamicContentFromJson(Map<String, dynamic> json) {
  return DynamicContent(
    json['content'] as Map<String, dynamic>,
    Content.fromJson(json['schema'] as Map<String, dynamic>),
    Nonce.fromJson(json['nonce'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DynamicContentToJson(DynamicContent instance) =>
    <String, dynamic>{
      'nonce': instance.nonce.toJson(),
      'content': instance.content,
      'schema': instance.schema.toJson(),
    };

Content<T> _$ContentFromJson<T>(Map<String, dynamic> json) {
  return Content<T>(
    _dataFromJson(json['content'] as Map<String, dynamic>),
    json['contentId'] == null
        ? null
        : ContentId.fromJson(json['contentId'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ContentToJson<T>(Content<T> instance) =>
    <String, dynamic>{
      'content': _dataToJson(instance.content),
      'contentId': instance.contentId?.toJson(),
    };

Signed<T> _$SignedFromJson<T>(Map<String, dynamic> json) {
  return Signed<T>(
    json['signature'] == null
        ? null
        : Signature.fromJson(json['signature'] as Map<String, dynamic>),
    json['content'] == null
        ? null
        : Content.fromJson(json['content'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SignedToJson<T>(Signed<T> instance) => <String, dynamic>{
      'signature': instance.signature?.toJson(),
      'content': instance.content?.toJson(),
    };

WithNonce _$WithNonceFromJson(Map<String, dynamic> json) {
  return WithNonce(
    Nonce.fromJson(json['nonce'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WithNonceToJson(WithNonce instance) => <String, dynamic>{
      'nonce': instance.nonce.toJson(),
    };

Signature _$SignatureFromJson(Map<String, dynamic> json) {
  return Signature(
    json['publicKey'] == null
        ? null
        : PublicKeyData.fromJson(json['publicKey'] as Map<String, dynamic>),
    json['bytes'] == null
        ? null
        : SignatureData.fromJson(json['bytes'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SignatureToJson(Signature instance) => <String, dynamic>{
      'publicKey': instance.publicKey?.toJson(),
      'bytes': instance.bytes?.toJson(),
    };

Claim _$ClaimFromJson(Map<String, dynamic> json) {
  return Claim(
    json['subject'] == null
        ? null
        : DidData.fromJson(json['subject'] as Map<String, dynamic>),
    json['content'] == null
        ? null
        : Content.fromJson(json['content'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ClaimToJson(Claim instance) => <String, dynamic>{
      'subject': instance.subject?.toJson(),
      'content': instance.content?.toJson(),
    };

WitnessRequest _$WitnessRequestFromJson(Map<String, dynamic> json) {
  return WitnessRequest(
    json['claim'] == null
        ? null
        : Claim.fromJson(json['claim'] as Map<String, dynamic>),
    json['claimant'] == null
        ? null
        : KeyLink.fromJson(json['claimant'] as Map<String, dynamic>),
    json['processId'] == null
        ? null
        : ContentId.fromJson(json['processId'] as Map<String, dynamic>),
    Content.fromJson(json['evidence'] as Map<String, dynamic>),
    Nonce.fromJson(json['nonce'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WitnessRequestToJson(WitnessRequest instance) =>
    <String, dynamic>{
      'nonce': instance.nonce.toJson(),
      'claim': instance.claim?.toJson(),
      'claimant': instance.claimant?.toJson(),
      'processId': instance.processId?.toJson(),
      'evidence': instance.evidence.toJson(),
    };

Constraint _$ConstraintFromJson(Map<String, dynamic> json) {
  return Constraint(
    DateTime.parse(json['after'] as String),
    DateTime.parse(json['before'] as String),
    json['witness'] == null
        ? null
        : KeyLink.fromJson(json['witness'] as Map<String, dynamic>),
    json['authority'] == null
        ? null
        : DidData.fromJson(json['authority'] as Map<String, dynamic>),
    Content.fromJson(json['content'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ConstraintToJson(Constraint instance) =>
    <String, dynamic>{
      'after': instance.after.toIso8601String(),
      'before': instance.before.toIso8601String(),
      'witness': instance.witness?.toJson(),
      'authority': instance.authority?.toJson(),
      'content': instance.content.toJson(),
    };

WitnessStatement _$WitnessStatementFromJson(Map<String, dynamic> json) {
  return WitnessStatement(
    json['claim'] == null
        ? null
        : Content.fromJson(json['claim'] as Map<String, dynamic>),
    json['processId'] == null
        ? null
        : ContentId.fromJson(json['processId'] as Map<String, dynamic>),
    json['constraints'] == null
        ? null
        : Constraint.fromJson(json['constraints'] as Map<String, dynamic>),
    Nonce.fromJson(json['nonce'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WitnessStatementToJson(WitnessStatement instance) =>
    <String, dynamic>{
      'nonce': instance.nonce.toJson(),
      'claim': instance.claim?.toJson(),
      'processId': instance.processId?.toJson(),
      'constraints': instance.constraints?.toJson(),
    };
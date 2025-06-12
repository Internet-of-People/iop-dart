// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'io.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyLink _$KeyLinkFromJson(Map<String, dynamic> json) => KeyLink(
      json['value'] as String,
    );

Map<String, dynamic> _$KeyLinkToJson(KeyLink instance) => <String, dynamic>{
      'value': instance.value,
    };

ContentId _$ContentIdFromJson(Map<String, dynamic> json) => ContentId(
      json['value'] as String,
    );

Map<String, dynamic> _$ContentIdToJson(ContentId instance) => <String, dynamic>{
      'value': instance.value,
    };

DynamicContent _$DynamicContentFromJson(Map<String, dynamic> json) =>
    DynamicContent(
      json['content'] as Map<String, dynamic>,
      json['schema'] == null
          ? null
          : Content<DynamicContent>.fromJson(json['schema']),
      json['nonce'] == null ? null : Nonce.fromJson(json['nonce'] as String),
    );

Map<String, dynamic> _$DynamicContentToJson(DynamicContent instance) =>
    <String, dynamic>{
      if (instance.nonce?.toJson() case final value?) 'nonce': value,
      'content': instance.content,
      if (instance.schema?.toJson() case final value?) 'schema': value,
    };

Content<T> _$ContentFromJson<T>(Map<String, dynamic> json) => Content<T>(
      _genericContentFromJson(json['content']),
      json['contentId'] == null
          ? null
          : ContentId.fromJson(json['contentId'] as String),
    );

Signed<T> _$SignedFromJson<T>(Map<String, dynamic> json) => Signed<T>(
      Signature.fromJson(json['signature'] as Map<String, dynamic>),
      Content<T>.fromJson(json['content']),
    );

Map<String, dynamic> _$SignedToJson<T>(Signed<T> instance) => <String, dynamic>{
      'signature': instance.signature.toJson(),
      'content': instance.content.toJson(),
    };

WithNonce _$WithNonceFromJson(Map<String, dynamic> json) => WithNonce(
      json['nonce'] == null ? null : Nonce.fromJson(json['nonce'] as String),
    );

Map<String, dynamic> _$WithNonceToJson(WithNonce instance) => <String, dynamic>{
      if (instance.nonce?.toJson() case final value?) 'nonce': value,
    };

NoncedValue<T> _$NoncedValueFromJson<T>(Map<String, dynamic> json) =>
    NoncedValue<T>(
      Nonce.fromJson(json['nonce'] as String),
      NoncedValueConverter<T>().fromJson(json['value'] as Object),
    );

Map<String, dynamic> _$NoncedValueToJson<T>(NoncedValue<T> instance) =>
    <String, dynamic>{
      'nonce': instance.nonce.toJson(),
      'value': NoncedValueConverter<T>().toJson(instance.value),
    };

Signature _$SignatureFromJson(Map<String, dynamic> json) => Signature(
      PublicKeyData.fromJson(json['publicKey'] as String),
      SignatureData.fromJson(json['bytes'] as String),
    );

Map<String, dynamic> _$SignatureToJson(Signature instance) => <String, dynamic>{
      'publicKey': instance.publicKey.toJson(),
      'bytes': instance.bytes.toJson(),
    };

Claim _$ClaimFromJson(Map<String, dynamic> json) => Claim(
      DidData.fromJson(json['subject'] as String),
      Content<DynamicContent>.fromJson(json['content']),
    );

Map<String, dynamic> _$ClaimToJson(Claim instance) => <String, dynamic>{
      'subject': instance.subject.toJson(),
      'content': instance.content.toJson(),
    };

WitnessRequest _$WitnessRequestFromJson(Map<String, dynamic> json) =>
    WitnessRequest(
      Claim.fromJson(json['claim'] as Map<String, dynamic>),
      KeyLink.fromJson(json['claimant'] as String),
      ContentId.fromJson(json['processId'] as String),
      Content<DynamicContent>.fromJson(json['evidence']),
      json['nonce'] == null ? null : Nonce.fromJson(json['nonce'] as String),
    );

Map<String, dynamic> _$WitnessRequestToJson(WitnessRequest instance) =>
    <String, dynamic>{
      if (instance.nonce?.toJson() case final value?) 'nonce': value,
      'claim': instance.claim.toJson(),
      'claimant': instance.claimant.toJson(),
      'processId': instance.processId.toJson(),
      'evidence': instance.evidence.toJson(),
    };

Constraint _$ConstraintFromJson(Map<String, dynamic> json) => Constraint(
      json['after'] == null ? null : DateTime.parse(json['after'] as String),
      json['before'] == null ? null : DateTime.parse(json['before'] as String),
      KeyLink.fromJson(json['witness'] as String),
      DidData.fromJson(json['authority'] as String),
      json['content'] == null
          ? null
          : Content<DynamicContent>.fromJson(json['content']),
    );

Map<String, dynamic> _$ConstraintToJson(Constraint instance) =>
    <String, dynamic>{
      'after': instance.after?.toIso8601String(),
      'before': instance.before?.toIso8601String(),
      'witness': instance.witness.toJson(),
      'authority': instance.authority.toJson(),
      'content': instance.content?.toJson(),
    };

WitnessStatement _$WitnessStatementFromJson(Map<String, dynamic> json) =>
    WitnessStatement(
      Content<Claim>.fromJson(json['claim']),
      ContentId.fromJson(json['processId'] as String),
      Constraint.fromJson(json['constraints'] as Map<String, dynamic>),
      json['nonce'] == null ? null : Nonce.fromJson(json['nonce'] as String),
    );

Map<String, dynamic> _$WitnessStatementToJson(WitnessStatement instance) =>
    <String, dynamic>{
      if (instance.nonce?.toJson() case final value?) 'nonce': value,
      'claim': instance.claim.toJson(),
      'processId': instance.processId.toJson(),
      'constraints': instance.constraints.toJson(),
    };

ProvenClaim _$ProvenClaimFromJson(Map<String, dynamic> json) => ProvenClaim(
      Claim.fromJson(json['claim'] as Map<String, dynamic>),
      _statementListFromJson(json['statements'] as List),
    );

Map<String, dynamic> _$ProvenClaimToJson(ProvenClaim instance) =>
    <String, dynamic>{
      'claim': instance.claim.toJson(),
      'statements': instance.statements.map((e) => e.toJson()).toList(),
    };

License _$LicenseFromJson(Map<String, dynamic> json) => License(
      DidData.fromJson(json['issuedTo'] as String),
      json['purpose'] as String,
      DateTime.parse(json['validFrom'] as String),
      DateTime.parse(json['validUntil'] as String),
    );

Map<String, dynamic> _$LicenseToJson(License instance) => <String, dynamic>{
      'issuedTo': instance.issuedTo.toJson(),
      'purpose': instance.purpose,
      'validFrom': instance.validFrom.toIso8601String(),
      'validUntil': instance.validUntil.toIso8601String(),
    };

Presentation _$PresentationFromJson(Map<String, dynamic> json) => Presentation(
      (json['provenClaims'] as List<dynamic>)
          .map((e) => ProvenClaim.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['licenses'] as List<dynamic>)
          .map((e) => License.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['nonce'] == null ? null : Nonce.fromJson(json['nonce'] as String),
    );

Map<String, dynamic> _$PresentationToJson(Presentation instance) =>
    <String, dynamic>{
      if (instance.nonce?.toJson() case final value?) 'nonce': value,
      'provenClaims': instance.provenClaims.map((e) => e.toJson()).toList(),
      'licenses': instance.licenses.map((e) => e.toJson()).toList(),
    };

AfterProof _$AfterProofFromJson(Map<String, dynamic> json) => AfterProof(
      (json['blockHeight'] as num).toInt(),
      json['blockHash'] as String,
    );

Map<String, dynamic> _$AfterProofToJson(AfterProof instance) =>
    <String, dynamic>{
      'blockHeight': instance.blockHeight,
      'blockHash': instance.blockHash,
    };

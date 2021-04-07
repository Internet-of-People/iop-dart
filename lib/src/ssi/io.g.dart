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
    json['schema'] == null ? null : Content.fromJson(json['schema']),
    json['nonce'] == null ? null : Nonce.fromJson(json['nonce'] as String),
  );
}

Map<String, dynamic> _$DynamicContentToJson(DynamicContent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nonce', instance.nonce?.toJson());
  val['content'] = instance.content;
  writeNotNull('schema', instance.schema?.toJson());
  return val;
}

Content<T> _$ContentFromJson<T>(Map<String, dynamic> json) {
  return Content<T>(
    _genericContentFromJson(json['content']),
    json['contentId'] == null
        ? null
        : ContentId.fromJson(json['contentId'] as String),
  );
}

Signed<T> _$SignedFromJson<T>(Map<String, dynamic> json) {
  return Signed<T>(
    Signature.fromJson(json['signature'] as Map<String, dynamic>),
    Content.fromJson(json['content']),
  );
}

Map<String, dynamic> _$SignedToJson<T>(Signed<T> instance) => <String, dynamic>{
      'signature': instance.signature.toJson(),
      'content': instance.content.toJson(),
    };

WithNonce _$WithNonceFromJson(Map<String, dynamic> json) {
  return WithNonce(
    json['nonce'] == null ? null : Nonce.fromJson(json['nonce'] as String),
  );
}

Map<String, dynamic> _$WithNonceToJson(WithNonce instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nonce', instance.nonce?.toJson());
  return val;
}

Signature _$SignatureFromJson(Map<String, dynamic> json) {
  return Signature(
    PublicKeyData.fromJson(json['publicKey'] as String),
    SignatureData.fromJson(json['bytes'] as String),
  );
}

Map<String, dynamic> _$SignatureToJson(Signature instance) => <String, dynamic>{
      'publicKey': instance.publicKey.toJson(),
      'bytes': instance.bytes.toJson(),
    };

Claim _$ClaimFromJson(Map<String, dynamic> json) {
  return Claim(
    DidData.fromJson(json['subject'] as String),
    Content.fromJson(json['content']),
  );
}

Map<String, dynamic> _$ClaimToJson(Claim instance) => <String, dynamic>{
      'subject': instance.subject.toJson(),
      'content': instance.content.toJson(),
    };

WitnessRequest _$WitnessRequestFromJson(Map<String, dynamic> json) {
  return WitnessRequest(
    Claim.fromJson(json['claim'] as Map<String, dynamic>),
    KeyLink.fromJson(json['claimant'] as String),
    ContentId.fromJson(json['processId'] as String),
    Content.fromJson(json['evidence']),
    json['nonce'] == null ? null : Nonce.fromJson(json['nonce'] as String),
  );
}

Map<String, dynamic> _$WitnessRequestToJson(WitnessRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nonce', instance.nonce?.toJson());
  val['claim'] = instance.claim.toJson();
  val['claimant'] = instance.claimant.toJson();
  val['processId'] = instance.processId.toJson();
  val['evidence'] = instance.evidence.toJson();
  return val;
}

Constraint _$ConstraintFromJson(Map<String, dynamic> json) {
  return Constraint(
    json['after'] == null ? null : DateTime.parse(json['after'] as String),
    json['before'] == null ? null : DateTime.parse(json['before'] as String),
    KeyLink.fromJson(json['witness'] as String),
    DidData.fromJson(json['authority'] as String),
    json['content'] == null ? null : Content.fromJson(json['content']),
  );
}

Map<String, dynamic> _$ConstraintToJson(Constraint instance) =>
    <String, dynamic>{
      'after': instance.after?.toIso8601String(),
      'before': instance.before?.toIso8601String(),
      'witness': instance.witness.toJson(),
      'authority': instance.authority.toJson(),
      'content': instance.content?.toJson(),
    };

WitnessStatement _$WitnessStatementFromJson(Map<String, dynamic> json) {
  return WitnessStatement(
    Content.fromJson(json['claim']),
    ContentId.fromJson(json['processId'] as String),
    Constraint.fromJson(json['constraints'] as Map<String, dynamic>),
    json['nonce'] == null ? null : Nonce.fromJson(json['nonce'] as String),
  );
}

Map<String, dynamic> _$WitnessStatementToJson(WitnessStatement instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nonce', instance.nonce?.toJson());
  val['claim'] = instance.claim.toJson();
  val['processId'] = instance.processId.toJson();
  val['constraints'] = instance.constraints.toJson();
  return val;
}

ProvenClaim _$ProvenClaimFromJson(Map<String, dynamic> json) {
  return ProvenClaim(
    Claim.fromJson(json['claim'] as Map<String, dynamic>),
    _statementListFromJson(json['statements'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProvenClaimToJson(ProvenClaim instance) =>
    <String, dynamic>{
      'claim': instance.claim.toJson(),
      'statements': instance.statements.map((e) => e.toJson()).toList(),
    };

License _$LicenseFromJson(Map<String, dynamic> json) {
  return License(
    DidData.fromJson(json['issuedTo'] as String),
    json['purpose'] as String,
    DateTime.parse(json['validFrom'] as String),
    DateTime.parse(json['validUntil'] as String),
  );
}

Map<String, dynamic> _$LicenseToJson(License instance) => <String, dynamic>{
      'issuedTo': instance.issuedTo.toJson(),
      'purpose': instance.purpose,
      'validFrom': instance.validFrom.toIso8601String(),
      'validUntil': instance.validUntil.toIso8601String(),
    };

Presentation _$PresentationFromJson(Map<String, dynamic> json) {
  return Presentation(
    (json['provenClaims'] as List<dynamic>)
        .map((e) => ProvenClaim.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['licenses'] as List<dynamic>)
        .map((e) => License.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['nonce'] == null ? null : Nonce.fromJson(json['nonce'] as String),
  );
}

Map<String, dynamic> _$PresentationToJson(Presentation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nonce', instance.nonce?.toJson());
  val['provenClaims'] = instance.provenClaims.map((e) => e.toJson()).toList();
  val['licenses'] = instance.licenses.map((e) => e.toJson()).toList();
  return val;
}

AfterProof _$AfterProofFromJson(Map<String, dynamic> json) {
  return AfterProof(
    json['blockHeight'] as int,
    json['blockHash'] as String,
  );
}

Map<String, dynamic> _$AfterProofToJson(AfterProof instance) =>
    <String, dynamic>{
      'blockHeight': instance.blockHeight,
      'blockHash': instance.blockHash,
    };

import 'dart:mirrors';
import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_sdk/crypto/io.dart';
import 'package:morpheus_sdk/scalar_box.dart';

part 'io.g.dart';

@JsonSerializable(explicitToJson: true)
class KeyLink extends ScalarBox<String> {
  KeyLink(String value) : super(value);

  factory KeyLink.fromJson(String value) => _$KeyLinkFromJson({'value': value});

  String toJson() => _$KeyLinkToJson(this)['value'];
}

@JsonSerializable(explicitToJson: true)
class ContentId extends ScalarBox<String> {
  ContentId(String value) : super(value);

  factory ContentId.fromJson(String value) =>
      _$ContentIdFromJson({'value': value});

  String toJson() => _$ContentIdToJson(this)['value'];
}

@JsonSerializable(explicitToJson: true)
class DynamicContent extends WithNonce {
  static List<String> topLevelKeys = ['schema', 'nonce'];

  final Map<String, dynamic> content;
  @JsonKey(nullable: true, includeIfNull: false)
  final Content<DynamicContent> schema;

  DynamicContent(this.content, this.schema, Nonce nonce) : super(nonce);

  factory DynamicContent.fromJson(Map<String, dynamic> json) {
    final content = Map.fromEntries(
        json.entries.where((e) => !topLevelKeys.contains(e.key)));
    final transformed = Map.fromEntries(
        json.entries.where((e) => topLevelKeys.contains(e.key)));
    transformed['content'] = content;
    return _$DynamicContentFromJson(transformed);
  }

  @override
  Map<String, dynamic> toJson() {
    final transformed = _$DynamicContentToJson(this);
    final content = transformed.remove('content');
    return Map.fromEntries(transformed.entries.followedBy(content.entries));
  }
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class Content<T> {
  @JsonKey(fromJson: _genericFromJson)
  final T content;
  final ContentId contentId;

  Content(this.content, this.contentId);

  factory Content.fromJson(dynamic json) {
    final transformed = <String, dynamic>{};
    if (json is Map) {
      transformed['content'] = json;
    } else if (json is String) {
      transformed['contentId'] = json;
    }
    return _$ContentFromJson(transformed);
  }

  dynamic toJson() {
    if (content != null) {
      return (content as dynamic).toJson();
    } else {
      return contentId?.value;
    }
  }
}

T _genericFromJson<T>(Map<String, dynamic> input) {
  final refT = reflectClass(T);
  // fromJson is not a static method, so this does not work:
  // return refT.invoke(#fromJson, [input]).reflectee;
  return refT.newInstance(#fromJson, [input]).reflectee;
}

@JsonSerializable(explicitToJson: true)
class Signed<T> {
  final Signature signature;
  final Content<T> content;

  Signed(this.signature, this.content);

  factory Signed.fromJson(Map<String, dynamic> json) => _$SignedFromJson(json);

  Map<String, dynamic> toJson() => _$SignedToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WithNonce {
  @JsonKey(nullable: true, includeIfNull: false)
  final Nonce nonce;

  WithNonce(this.nonce);

  factory WithNonce.fromJson(Map<String, dynamic> json) =>
      _$WithNonceFromJson(json);

  Map<String, dynamic> toJson() => _$WithNonceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Signature {
  final PublicKeyData publicKey;
  final SignatureData bytes;

  Signature(this.publicKey, this.bytes);

  factory Signature.fromJson(Map<String, dynamic> json) =>
      _$SignatureFromJson(json);

  Map<String, dynamic> toJson() => _$SignatureToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Claim {
  final DidData subject;
  final Content<DynamicContent> content;

  Claim(this.subject, this.content);

  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WitnessRequest extends WithNonce {
  final Claim claim;
  final KeyLink claimant;
  final ContentId processId;
  @JsonKey(nullable: true)
  final Content<DynamicContent> evidence;

  WitnessRequest(
    this.claim,
    this.claimant,
    this.processId,
    this.evidence,
    Nonce nonce,
  ) : super(nonce);

  factory WitnessRequest.fromJson(Map<String, dynamic> json) =>
      _$WitnessRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WitnessRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Constraint {
  @JsonKey(nullable: true)
  final DateTime after;
  @JsonKey(nullable: true)
  final DateTime before;
  final KeyLink witness;
  final DidData authority;
  @JsonKey(nullable: true)
  final Content<DynamicContent> content;

  Constraint(
    this.after,
    this.before,
    this.witness,
    this.authority,
    this.content,
  );

  factory Constraint.fromJson(Map<String, dynamic> json) =>
      _$ConstraintFromJson(json);

  Map<String, dynamic> toJson() => _$ConstraintToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WitnessStatement extends WithNonce {
  final Content<Claim> claim;
  final ContentId processId;
  final Constraint constraints;

  WitnessStatement(
    this.claim,
    this.processId,
    this.constraints,
    Nonce nonce,
  ) : super(nonce);

  factory WitnessStatement.fromJson(Map<String, dynamic> json) =>
      _$WitnessStatementFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WitnessStatementToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProvenClaim {
  final Claim claim;
  final List<Signed<WitnessStatement>> statements;

  ProvenClaim(this.claim, this.statements);

  factory ProvenClaim.fromJson(Map<String, dynamic> json) =>
      _$ProvenClaimFromJson(json);

  Map<String, dynamic> toJson() => _$ProvenClaimToJson(this);
}

@JsonSerializable(explicitToJson: true)
class License {
  final DidData issuedTo;
  final String purpose;
  final DateTime validFrom;
  final DateTime validUntil;

  License(this.issuedTo, this.purpose, this.validFrom, this.validUntil);

  factory License.fromJson(Map<String, dynamic> json) =>
      _$LicenseFromJson(json);

  Map<String, dynamic> toJson() => _$LicenseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Presentation extends WithNonce {
  final List<ProvenClaim> provenClaims;
  final List<License> licenses;

  Presentation(this.provenClaims, this.licenses, Nonce nonce) : super(nonce);

  factory Presentation.fromJson(Map<String, dynamic> json) =>
      _$PresentationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PresentationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AfterProof {
  final int blockHeight;
  final String blockHash;

  AfterProof(this.blockHeight, this.blockHash);

  factory AfterProof.fromJson(Map<String, dynamic> json) =>
      _$AfterProofFromJson(json);

  Map<String, dynamic> toJson() => _$AfterProofToJson(this);
}

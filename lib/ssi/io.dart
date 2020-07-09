import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_sdk/crypto/io.dart';
import 'package:morpheus_sdk/src/scalar_box.dart';

part 'io.g.dart';

@JsonSerializable(explicitToJson: true)
class KeyLink extends ScalarBox<String> {
  KeyLink(String value) : super(value);

  factory KeyLink.fromJson(Map<String, dynamic> json) =>
      _$KeyLinkFromJson(json);

  String toJson() => _$KeyLinkToJson(this)['value'];
}

@JsonSerializable(explicitToJson: true)
class ContentId extends ScalarBox<String> {
  ContentId(String value) : super(value);

  factory ContentId.fromJson(String value) =>
      _$ContentIdFromJson({'value':value});

  String toJson() => _$ContentIdToJson(this)['value'];
}

@JsonSerializable(explicitToJson: true)
class DynamicContent extends WithNonce {
  final Map<String, dynamic> content;
  @JsonKey(nullable: false)
  final Content<DynamicContent> schema;

  DynamicContent(this.content, this.schema, Nonce nonce) : super(nonce);

  factory DynamicContent.fromJson(Map<String, dynamic> json) =>
      _$DynamicContentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DynamicContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content<T> {
  // TODO: https://stackoverflow.com/questions/60659078/flutter-deserialisation-using-generics-error
  // TODO: will this work?
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  final T content;
  final ContentId contentId;

  Content(this.content, this.contentId);

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

T _dataFromJson<T>(Map<String, dynamic> input) => input['content'] as T;

Map<String, dynamic> _dataToJson<T>(T input) => {'content': input};

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
  @JsonKey(nullable: false)
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
  @JsonKey(nullable: false)
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
  @JsonKey(nullable: false)
  final DateTime after;
  @JsonKey(nullable: false)
  final DateTime before;
  final KeyLink witness;
  final DidData authority;
  @JsonKey(nullable: false)
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

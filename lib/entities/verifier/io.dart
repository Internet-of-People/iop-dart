import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_sdk/crypto/io.dart';
import 'package:morpheus_sdk/ssi/io.dart';

part 'io.g.dart';

@JsonSerializable(explicitToJson: true)
class ValidationResult {
  final List<String> errors;
  final List<String> warnings;

  ValidationResult(this.errors, this.warnings);

  factory ValidationResult.fromJson(Map<String, dynamic> json) =>
      _$ValidationResultFromJson(json);

  Map<String, dynamic> toJson() => _$ValidationResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ValidationRequest {
  final PublicKeyData publicKey;
  final ContentId contentId;
  final SignatureData signature;
  final DidData onBehalfOf;
  @JsonKey(nullable: true)
  final AfterProof afterProof;

  ValidationRequest(
    this.publicKey,
    this.contentId,
    this.signature,
    this.onBehalfOf,
    this.afterProof,
  );

  factory ValidationRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ValidationRequestToJson(this);
}

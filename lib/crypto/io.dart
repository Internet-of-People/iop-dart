import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_sdk/src/scalar_box.dart';

part 'io.g.dart';

@JsonSerializable(explicitToJson: true)
class Nonce extends ScalarBox<String> {
  Nonce(String value) : super(value);

  factory Nonce.fromJson(Map<String, dynamic> json) => _$NonceFromJson(json);

  Map<String, dynamic> toJson() => _$NonceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DidData extends ScalarBox<String> {
  DidData(String value) : super(value);

  factory DidData.fromJson(Map<String, dynamic> json) =>
      _$DidDataFromJson(json);

  Map<String, dynamic> toJson() => _$DidDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PublicKeyData extends ScalarBox<String> {
  PublicKeyData(String value) : super(value);

  factory PublicKeyData.fromJson(Map<String, dynamic> json) =>
      _$PublicKeyDataFromJson(json);

  Map<String, dynamic> toJson() => _$PublicKeyDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignatureData extends ScalarBox<String> {
  SignatureData(String value) : super(value);

  factory SignatureData.fromJson(Map<String, dynamic> json) =>
      _$SignatureDataFromJson(json);

  Map<String, dynamic> toJson() => _$SignatureDataToJson(this);
}

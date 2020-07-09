import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_sdk/src/scalar_box.dart';

part 'io.g.dart';

@JsonSerializable(explicitToJson: true)
class Nonce extends ScalarBox<String> {
  Nonce(String value) : super(value);

  factory Nonce.fromJson(Map<String, dynamic> json) => _$NonceFromJson(json);

  String toJson() => _$NonceToJson(this)['value'];
}

@JsonSerializable(explicitToJson: true)
class DidData extends ScalarBox<String> {
  DidData(String value) : super(value);

  factory DidData.fromJson(Map<String, dynamic> json) =>
      _$DidDataFromJson(json);

  String toJson() => _$DidDataToJson(this)['value'];
}

@JsonSerializable(explicitToJson: true)
class PublicKeyData extends ScalarBox<String> {
  PublicKeyData(String value) : super(value);

  factory PublicKeyData.fromJson(Map<String, dynamic> json) =>
      _$PublicKeyDataFromJson(json);

  String toJson() => _$PublicKeyDataToJson(this)['value'];
}

@JsonSerializable(explicitToJson: true)
class SignatureData extends ScalarBox<String> {
  SignatureData(String value) : super(value);

  factory SignatureData.fromJson(Map<String, dynamic> json) =>
      _$SignatureDataFromJson(json);

  String toJson() => _$SignatureDataToJson(this)['value'];
}

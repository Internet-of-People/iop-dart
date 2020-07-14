import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_sdk/scalar_box.dart';

part 'io.g.dart';

@JsonSerializable(explicitToJson: true)
class Nonce extends ScalarBox<String> {
  Nonce(String value) : super(value);

  factory Nonce.fromJson(String value) => _$NonceFromJson({'value': value});

  String toJson() => _$NonceToJson(this)['value'];
}

@JsonSerializable(explicitToJson: true)
class AuthenticationData extends ScalarBox<String> {
  AuthenticationData(String value) : super(value);

  factory AuthenticationData.fromJson(String value) =>
      _$AuthenticationDataFromJson({'value': value});

  String toJson() => _$AuthenticationDataToJson(this)['value'];
}

@JsonSerializable(explicitToJson: true)
class DidData extends ScalarBox<String> {
  DidData(String value) : super(value);

  factory DidData.fromJson(String value) => _$DidDataFromJson({'value': value});

  String toJson() => _$DidDataToJson(this)['value'];
}

@JsonSerializable(explicitToJson: true)
class PublicKeyData extends ScalarBox<String> {
  PublicKeyData(String value) : super(value);

  factory PublicKeyData.fromJson(String value) =>
      _$PublicKeyDataFromJson({'value': value});

  String toJson() => _$PublicKeyDataToJson(this)['value'];
}

@JsonSerializable(explicitToJson: true)
class SignatureData extends ScalarBox<String> {
  SignatureData(String value) : super(value);

  factory SignatureData.fromJson(String value) =>
      _$SignatureDataFromJson({'value': value});

  String toJson() => _$SignatureDataToJson(this)['value'];
}

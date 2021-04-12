import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/entities/authority/io.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:json_annotation/json_annotation.dart';

part 'io.g.dart';

@JsonSerializable(explicitToJson: true)
class Scenario {
  final String name;
  final int version;
  final String description;
  final List<Prerequisite> prerequisites;
  final List<LicenseSpecification> requiredLicenses;
  final Content<DynamicContent>? resultSchema;

  Scenario(
    this.name,
    this.version,
    this.description,
    this.prerequisites,
    this.requiredLicenses,
    this.resultSchema,
  );

  factory Scenario.fromJson(Map<String, dynamic> json) =>
      _$ScenarioFromJson(json);

  Map<String, dynamic> toJson() => _$ScenarioToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Prerequisite {
  final Content<Process> process;
  final List<String> claimFields;

  Prerequisite(this.process, this.claimFields);

  factory Prerequisite.fromJson(Map<String, dynamic> json) =>
      _$PrerequisiteFromJson(json);

  Map<String, dynamic> toJson() => _$PrerequisiteToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LicenseSpecification {
  final DidData issuedTo;
  final String purpose;
  final String expiry;

  LicenseSpecification(this.issuedTo, this.purpose, this.expiry);

  factory LicenseSpecification.fromJson(Map<String, dynamic> json) =>
      _$LicenseSpecificationFromJson(json);

  Map<String, dynamic> toJson() => _$LicenseSpecificationToJson(this);
}
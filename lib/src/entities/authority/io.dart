import 'package:json_annotation/json_annotation.dart';
import 'package:iop_sdk/scalar_box.dart';
import 'package:iop_sdk/ssi.dart';

part 'io.g.dart';

@JsonSerializable(explicitToJson: true)
class Process {
  final String name;
  final int version;
  final String description;
  final Content<DynamicContent> claimSchema;
  final Content<DynamicContent>? evidenceSchema;
  final Content<DynamicContent>? constraintsSchema;

  Process(
    this.name,
    this.version,
    this.description,
    this.claimSchema,
    this.evidenceSchema,
    this.constraintsSchema,
  );

  factory Process.fromJson(Map<String, dynamic> json) =>
      _$ProcessFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RequestEntry {
  final CapabilityLink capabilityLink;
  final ContentId requestId;
  final DateTime dateOfRequest;
  final Status status;
  final ContentId processId;
  final String? notes;

  RequestEntry(
    this.capabilityLink,
    this.requestId,
    this.dateOfRequest,
    this.status,
    this.processId,
    this.notes,
  );

  factory RequestEntry.fromJson(Map<String, dynamic> json) =>
      _$RequestEntryFromJson(json);

  Map<String, dynamic> toJson() => _$RequestEntryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CapabilityLink extends ScalarBox<String> {
  CapabilityLink(String value) : super(value);

  factory CapabilityLink.fromJson(String value) =>
      _$CapabilityLinkFromJson({'value': value});

  String toJson() => _$CapabilityLinkToJson(this)['value'];
}

enum Status { pending, approved, rejected }

@JsonSerializable(explicitToJson: true)
class RequestStatus {
  final Status status;
  final Signed<WitnessStatement>? signedStatement;
  final String? rejectionReason;

  RequestStatus(this.status, this.signedStatement, this.rejectionReason);

  factory RequestStatus.fromJson(Map<String, dynamic> json) =>
      _$RequestStatusFromJson(json);

  Map<String, dynamic> toJson() => _$RequestStatusToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SendRequestResponse {
  final CapabilityLink capabilityLink;

  SendRequestResponse(this.capabilityLink);

  factory SendRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$SendRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendRequestResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:iop_sdk/scalar_box.dart';
import 'package:iop_sdk/ssi.dart';

part 'io.g.dart';

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

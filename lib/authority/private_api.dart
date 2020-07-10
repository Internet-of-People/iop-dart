import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_sdk/authority/api.dart';
import 'package:morpheus_sdk/authority/io.dart';
import 'package:morpheus_sdk/ssi/io.dart';
import 'package:morpheus_sdk/utils/io.dart';
import 'package:optional/optional.dart';

part 'private_api.g.dart';

// TODO: AUTHENTICATION
class AuthorityPrivateApi extends AuthorityApi {
  AuthorityPrivateApi(AuthorityConfig config) : super(config);

  Future<List<RequestEntry>> listRequests() async {
    final resp = await get('/requests');
    if (resp.statusCode == HttpStatus.ok) {
      return ListRequestsResponse.fromJson(json.decode(resp.body)).requests;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<Optional<dynamic>> getPrivateBlob(ContentId contentId) async {
    final resp = await get('/private-blob/${contentId.value}');
    if (resp.statusCode == HttpStatus.ok) {
      return Optional.of(resp.body);
    } else if (resp.statusCode == HttpStatus.notFound) {
      return Optional.empty();
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<void> approveRequest(
    CapabilityLink capabilityLink,
    Signed<WitnessStatement> signedWitnessStatement,
  ) async {
    final resp = await post(
      '/requests/${capabilityLink.value}/approve',
      signedWitnessStatement.toJson(),
    );

    if (resp.statusCode != HttpStatus.ok) {
      return Future.error(HttpResponseError(resp.statusCode, resp.body));
    }
  }

  Future<void> rejectRequest(
    CapabilityLink capabilityLink,
    String rejectionReason,
  ) async {
    final resp = await post(
      '/requests/${capabilityLink.value}/reject',
      {'rejectionReason': rejectionReason},
    );

    if (resp.statusCode != HttpStatus.ok) {
      return Future.error(HttpResponseError(resp.statusCode, resp.body));
    }
  }
}

@JsonSerializable(explicitToJson: true)
class ListRequestsResponse {
  final List<RequestEntry> requests;

  ListRequestsResponse(this.requests);

  factory ListRequestsResponse.fromJson(Map<String, dynamic> json) =>
      _$ListRequestsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListRequestsResponseToJson(this);
}

import 'dart:convert';
import 'dart:io';

import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_sdk/utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:optional/optional.dart';

part 'public_api.g.dart';

class AuthorityPublicApi extends Api {
  AuthorityPublicApi(ApiConfig config) : super(config);

  Future<List<ContentId>> listProcesses() async {
    final resp = await get('/processes');
    if (resp.statusCode == HttpStatus.ok) {
      return ListProcessesResponse.fromJson(json.decode(resp.body)).processes;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<Optional<dynamic>> getPublicBlob(ContentId contentId) async {
    final resp = await get('/blob/${contentId.value}');
    if (resp.statusCode == HttpStatus.ok) {
      return Optional.of(resp.body);
    } else if (resp.statusCode == HttpStatus.notFound) {
      return Optional.empty();
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<CapabilityLink> sendRequest(
    Signed<WitnessRequest> witnessRequest,
  ) async {
    final resp = await post('/requests', witnessRequest.toJson());

    if (resp.statusCode == HttpStatus.accepted) {
      return CapabilityLink.fromJson(resp.body);
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<Optional<RequestStatus>> getRequestStatus(
    CapabilityLink capabilityLink,
  ) async {
    final resp = await get('/requests/${capabilityLink.value}/status');

    if (resp.statusCode == HttpStatus.ok) {
      return Optional.of(RequestStatus.fromJson(json.decode(resp.body)));
    } else if (resp.statusCode == HttpStatus.notFound) {
      return Optional.empty();
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }
}

@JsonSerializable(explicitToJson: true)
class ListProcessesResponse {
  final List<ContentId> processes;

  ListProcessesResponse(this.processes);

  factory ListProcessesResponse.fromJson(Map<String, dynamic> json) =>
      _$ListProcessesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListProcessesResponseToJson(this);
}

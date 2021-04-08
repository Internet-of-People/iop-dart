import 'dart:convert';
import 'dart:io';

import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_sdk/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_api.g.dart';

class AuthorityPublicApi extends Api {
  AuthorityPublicApi(ApiConfig config) : super(config);

  Future<List<ContentId>> listProcesses() async {
    final resp = await get('/process');
    if (resp.statusCode == HttpStatus.ok) {
      return ListProcessesResponse.fromJson(json.decode(resp.body)).processes;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<dynamic> getPublicBlob(ContentId contentId) async {
    final resp = await get('/blob/${contentId.value}');
    if (resp.statusCode == HttpStatus.ok) {
      return resp.body;
    } else if (resp.statusCode == HttpStatus.notFound) {
      return null;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<CapabilityLink> sendRequest(
    Signed<WitnessRequest> witnessRequest,
  ) async {
    final resp = await post('/request', json.encode(witnessRequest.toJson()));

    if (resp.statusCode == HttpStatus.accepted) {
      return SendRequestResponse.fromJson(json.decode(resp.body)).capabilityLink;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<RequestStatus?> getRequestStatus(
    CapabilityLink capabilityLink,
  ) async {
    final resp = await get('/request/${capabilityLink.value}/status');

    if (resp.statusCode == HttpStatus.ok) {
      return RequestStatus.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == HttpStatus.notFound) {
      return null;
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

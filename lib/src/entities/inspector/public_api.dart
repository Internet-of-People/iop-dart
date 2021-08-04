import 'dart:convert';
import 'dart:io';

import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_sdk/utils.dart';
import 'package:json_annotation/json_annotation.dart';

import 'io.dart';

part 'public_api.g.dart';

class InspectorPublicApi extends Api {
  InspectorPublicApi(ApiConfig config) : super(config);

  Future<List<ContentId>> listScenarios() async {
    final resp = await get('/scenario');
    if (resp.statusCode == HttpStatus.ok) {
      return ListScenariosResponse.fromJson(json.decode(resp.body)).scenarios;
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

  Future<ContentId> uploadPresentation(
    Signed<Presentation> presentation,
  ) async {
    final resp =
        await post('/presentation', json.encode(presentation.toJson()));

    if (resp.statusCode == HttpStatus.accepted) {
      return UploadPresentationResponse.fromJson(json.decode(resp.body))
          .contentId;
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }
}

@JsonSerializable(explicitToJson: true)
class ListScenariosResponse {
  final List<ContentId> scenarios;

  ListScenariosResponse(this.scenarios);

  factory ListScenariosResponse.fromJson(Map<String, dynamic> json) =>
      _$ListScenariosResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListScenariosResponseToJson(this);
}

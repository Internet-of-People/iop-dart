import 'dart:convert';
import 'dart:io';

import 'package:iop_sdk/entities/io.dart';
import 'package:iop_sdk/entities/verifier/io.dart';
import 'package:iop_sdk/ssi/io.dart';

class VerifierPublicApi extends Api {
  VerifierPublicApi(ApiConfig config) : super(config);

  Future<AfterProof> getAfterProof() async {
    final resp = await get('/after-proof');

    if (resp.statusCode == HttpStatus.ok) {
      return AfterProof.fromJson(json.decode(resp.body));
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }

  Future<ValidationResult> validate(ValidationRequest request) async {
    final resp = await post('/validate', request.toJson());

    if (resp.statusCode == HttpStatus.ok) {
      return ValidationResult.fromJson(json.decode(resp.body));
    }

    return Future.error(HttpResponseError(resp.statusCode, resp.body));
  }
}

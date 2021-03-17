import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';

class ValidationResult implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  ValidationResult(this._ffi, this._owned);

  String get status {
    return DartApi.native.validationResult.statusGet(_ffi).intoString();
  }

  List<ValidationIssue> get issues {
    return DartApi.native.validationResult.issuesGet(_ffi).extract((resp) {
      return resp.asList((ffiIssue) {
        final issueApi = DartApi.native.validationIssue;
        final code = issueApi.codeGet(ffiIssue);
        final nativeReason = issueApi.reasonGet(ffiIssue);
        final nativeSeverity = issueApi.severityGet(ffiIssue);
        try {
          final reason = nativeReason.toDartString();
          final severity = nativeSeverity.toDartString();
          return ValidationIssue(code, reason, severity);
        } finally {
          calloc.free(nativeSeverity);
          calloc.free(nativeReason);
          issueApi.delete(ffiIssue);
        }
      });
    });
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.validationResult.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class ValidationIssue {
  final int code;
  final String reason;
  final String severity;

  ValidationIssue(this.code, this.reason, this.severity);
}

import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef NDelete_ValidationIssue = Void Function(
  Pointer<Void> issue,
);
typedef DDelete_ValidationIssue = void Function(
  Pointer<Void> issue,
);

typedef NValidationIssue_Code_Get = Uint32 Function(
  Pointer<Void> issue,
);
typedef DValidationIssue_Code_Get = int Function(
  Pointer<Void> issue,
);

typedef NValidationIssue_Reason_Get = Pointer<Utf8> Function(
  Pointer<Void> issue,
);
typedef DValidationIssue_Reason_Get = Pointer<Utf8> Function(
  Pointer<Void> issue,
);

typedef NValidationIssue_Severity_Get = Pointer<Utf8> Function(
  Pointer<Void> issue,
);
typedef DValidationIssue_Severity_Get = Pointer<Utf8> Function(
  Pointer<Void> issue,
);

class NativeValidationIssue {
  final DDelete_ValidationIssue delete;
  final DValidationIssue_Code_Get codeGet;
  final DValidationIssue_Reason_Get reasonGet;
  final DValidationIssue_Severity_Get severityGet;

  NativeValidationIssue(DynamicLibrary lib)
      : delete = lib
            .lookupFunction<NDelete_ValidationIssue, DDelete_ValidationIssue>(
          'delete_ValidationIssue',
        ),
        codeGet = lib.lookupFunction<NValidationIssue_Code_Get,
            DValidationIssue_Code_Get>(
          'ValidationIssue_code_get',
        ),
        reasonGet = lib.lookupFunction<NValidationIssue_Reason_Get,
            DValidationIssue_Reason_Get>(
          'ValidationIssue_reason_get',
        ),
        severityGet = lib.lookupFunction<NValidationIssue_Severity_Get,
            DValidationIssue_Severity_Get>(
          'ValidationIssue_severity_get',
        );
}

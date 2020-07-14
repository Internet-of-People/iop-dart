import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';

typedef NDelete_ValidationResult = Void Function(
  Pointer<Void> result,
);
typedef DDelete_ValidationResult = void Function(
  Pointer<Void> result,
);

typedef NValidationResult_Status_Get = Pointer<Utf8> Function(
  Pointer<Void> result,
);
typedef DValidationResult_Status_Get = Pointer<Utf8> Function(
  Pointer<Void> result,
);

typedef NValidationResult_Issues_Get = Pointer<Result> Function(
  Pointer<Void> result,
);
typedef DValidationResult_Issues_Get = Pointer<Result> Function(
  Pointer<Void> result,
);

class NativeValidationResult {
  final DDelete_ValidationResult delete;
  final DValidationResult_Status_Get statusGet;
  final DValidationResult_Issues_Get issuesGet;

  NativeValidationResult(DynamicLibrary lib)
      : delete = lib
            .lookupFunction<NDelete_ValidationResult, DDelete_ValidationResult>(
          'delete_ValidationResult',
        ),
        statusGet = lib.lookupFunction<NValidationResult_Status_Get,
            DValidationResult_Status_Get>(
          'ValidationResult_status_get',
        ),
        issuesGet = lib.lookupFunction<NValidationResult_Issues_Get,
            DValidationResult_Issues_Get>(
          'ValidationResult_issues_get',
        );
}

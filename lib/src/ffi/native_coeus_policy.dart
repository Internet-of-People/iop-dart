import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

typedef NDelete_CoeusSubtreePolicies = Void Function(
  Pointer<Void> policies,
);
typedef DDelete_CoeusSubtreePolicies = void Function(
  Pointer<Void> policies,
);

typedef NCoeusSubtreePolicies_New = Pointer<Void> Function();
typedef DCoeusSubtreePolicies_New = Pointer<Void> Function();

typedef NCoeusSubtreePolicies_WithSchema = Pointer<Result> Function(
  Pointer<Void> policies,
  Pointer<Utf8> schema,
);
typedef DCoeusSubtreePolicies_WithSchema = Pointer<Result> Function(
  Pointer<Void> policies,
  Pointer<Utf8> privateKey,
);

typedef NCoeusSubtreePolicies_WithExpiration = Pointer<Result> Function(
  Pointer<Void> policies,
  Int32 maxExpiryBlocks,
);
typedef DCoeusSubtreePolicies_WithExpiration = Pointer<Result> Function(
  Pointer<Void> policies,
  int maxExpiryBlocks,
);

class NativeCoeusSubtreePolicies {
  final DDelete_CoeusSubtreePolicies delete;
  final DCoeusSubtreePolicies_New create;
  final DCoeusSubtreePolicies_WithSchema withSchema;
  final DCoeusSubtreePolicies_WithExpiration withExpiration;

  NativeCoeusSubtreePolicies(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_CoeusSubtreePolicies,
            DDelete_CoeusSubtreePolicies>(
          'delete_SubtreePolicies',
        ),
        // "new" and "default" are reserved words and cannot be used as a class member name
        create = lib.lookupFunction<NCoeusSubtreePolicies_New,
            DCoeusSubtreePolicies_New>(
          'SubtreePolicies_new',
        ),
        withSchema = lib.lookupFunction<NCoeusSubtreePolicies_WithSchema,
            DCoeusSubtreePolicies_WithSchema>(
          'SubtreePolicies_with_schema',
        ),
        withExpiration = lib.lookupFunction<
            NCoeusSubtreePolicies_WithExpiration,
            DCoeusSubtreePolicies_WithExpiration>(
          'SubtreePolicies_with_expiration',
        );
}

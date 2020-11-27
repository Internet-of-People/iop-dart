import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

typedef NDelete_MorpheusOperation = Void Function(Pointer<Void> operation);
typedef DDelete_MorpheusOperation = void Function(Pointer<Void> operation);

class NativeMorpheusOperation {
  final DDelete_MorpheusOperation delete;

  NativeMorpheusOperation(DynamicLibrary lib) :
    delete = lib.lookupFunction<NDelete_MorpheusOperation, DDelete_MorpheusOperation>(
      'delete_MorpheusOperation',
    );
}

typedef NDelete_MorpheusOperationBuilder = Void Function(Pointer<Void> builder);
typedef DDelete_MorpheusOperationBuilder = void Function(Pointer<Void> builder);

typedef NMorpheusOperationBuilder_New = Pointer<Result> Function(
  Pointer<Void> did,
  Pointer<Utf8> lastTxId,
);
typedef DMorpheusOperationBuilder_New = Pointer<Result> Function(
  Pointer<Void> did,
  Pointer<Utf8> lastTxId,
);

typedef NMorpheusOperationBuilder_AddKey = Pointer<Result> Function(
  Pointer<Void> builder,
  Pointer<Utf8> authentication,
  Uint32 blockHeight,
);
typedef DMorpheusOperationBuilder_AddKey = Pointer<Result> Function(
  Pointer<Void> builder,
  Pointer<Utf8> authentication,
  int blockHeight,
);

typedef NMorpheusOperationBuilder_RevokeKey = Pointer<Result> Function(
  Pointer<Void> builder,
  Pointer<Utf8> authentication,
);
typedef DMorpheusOperationBuilder_RevokeKey = Pointer<Result> Function(
  Pointer<Void> builder,
  Pointer<Utf8> authentication,
);

typedef NMorpheusOperationBuilder_AddRight = Pointer<Result> Function(
  Pointer<Void> builder,
  Pointer<Utf8> authentication,
  Pointer<Utf8> right,
);
typedef DMorpheusOperationBuilder_AddRight = Pointer<Result> Function(
  Pointer<Void> builder,
  Pointer<Utf8> authentication,
  Pointer<Utf8> right,
);

typedef NMorpheusOperationBuilder_RevokeRight = Pointer<Result> Function(
  Pointer<Void> builder,
  Pointer<Utf8> authentication,
  Pointer<Utf8> right,
);
typedef DMorpheusOperationBuilder_RevokeRight = Pointer<Result> Function(
  Pointer<Void> builder,
  Pointer<Utf8> authentication,
  Pointer<Utf8> right,
);

typedef NMorpheusOperationBuilder_TombstoneDid = Pointer<Void> Function(
  Pointer<Void> builder,
);
typedef DMorpheusOperationBuilder_TombstoneDid = Pointer<Void> Function(
  Pointer<Void> builder,
);

class NativeMorpheusOperationBuilder {
  final DDelete_MorpheusOperationBuilder delete;
  final DMorpheusOperationBuilder_New create;
  final DMorpheusOperationBuilder_AddKey addKey;
  final DMorpheusOperationBuilder_RevokeKey revokeKey;
  final DMorpheusOperationBuilder_AddRight addRight;
  final DMorpheusOperationBuilder_RevokeRight revokeRight;
  final DMorpheusOperationBuilder_TombstoneDid tombstoneDid;

  NativeMorpheusOperationBuilder(DynamicLibrary lib) :
    delete = lib.lookupFunction<NDelete_MorpheusOperationBuilder, DDelete_MorpheusOperationBuilder>(
      'delete_MorpheusOperationBuilder',
    ),
    create = lib.lookupFunction<NMorpheusOperationBuilder_New, DMorpheusOperationBuilder_New>(
      'MorpheusOperationBuilder_new',
    ),
    addKey = lib.lookupFunction<NMorpheusOperationBuilder_AddKey, DMorpheusOperationBuilder_AddKey>(
      'MorpheusOperationBuilder_add_key',
    ),
    revokeKey = lib.lookupFunction<NMorpheusOperationBuilder_RevokeKey, DMorpheusOperationBuilder_RevokeKey>(
      'MorpheusOperationBuilder_revoke_key',
    ),
    addRight = lib.lookupFunction<NMorpheusOperationBuilder_AddRight, DMorpheusOperationBuilder_AddRight>(
      'MorpheusOperationBuilder_add_right',
    ),
    revokeRight = lib.lookupFunction<NMorpheusOperationBuilder_RevokeRight, DMorpheusOperationBuilder_RevokeRight>(
      'MorpheusOperationBuilder_revoke_right',
    ),
    tombstoneDid = lib.lookupFunction<NMorpheusOperationBuilder_TombstoneDid, DMorpheusOperationBuilder_TombstoneDid>(
      'MorpheusOperationBuilder_tombstone_did',
    );
}

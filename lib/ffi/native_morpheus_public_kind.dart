import 'dart:ffi';
import 'package:iop_sdk/ffi/ffi.dart';

typedef NMorpheusPublicKind_Len_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublicKind,
);
typedef DMorpheusPublicKind_Len_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublicKind,
);

typedef NMorpheusPublicKind_IsEmpty_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublicKind,
);
typedef DMorpheusPublicKind_IsEmpty_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublicKind,
);

typedef NMorpheusPublicKind_Key = Pointer<Result> Function(
  Pointer<Void> morpheusPublicKind,
  Int32 idx,
);
typedef DMorpheusPublicKind_Key = Pointer<Result> Function(
  Pointer<Void> morpheusPublicKind,
  int idx,
);

typedef NMorpheusPublicKind_Did = Pointer<Result> Function(
  Pointer<Void> morpheusPublicKind,
  Int32 idx,
);
typedef DMorpheusPublicKind_Did = Pointer<Result> Function(
  Pointer<Void> morpheusPublicKind,
  int idx,
);

typedef NDelete_MorpheusPublicKind = Void Function(
  Pointer<Void> morpheusPublicKind,
);
typedef DDelete_MorpheusPublicKind = void Function(
  Pointer<Void> morpheusPublicKind,
);

class NativeMorpheusPublicKind {
  final DMorpheusPublicKind_Len_Get lenGet;
  final DMorpheusPublicKind_IsEmpty_Get isEmptyGet;
  final DMorpheusPublicKind_Key key;
  final DMorpheusPublicKind_Did did;
  final DDelete_MorpheusPublicKind delete;

  NativeMorpheusPublicKind(DynamicLibrary lib)
      : lenGet = lib.lookupFunction<NMorpheusPublicKind_Len_Get,
            DMorpheusPublicKind_Len_Get>(
          'MorpheusPublicKind_len_get',
        ),
        isEmptyGet = lib.lookupFunction<NMorpheusPublicKind_IsEmpty_Get,
            DMorpheusPublicKind_IsEmpty_Get>(
          'MorpheusPublicKind_is_empty_get',
        ),
        key = lib
            .lookupFunction<NMorpheusPublicKind_Key, DMorpheusPublicKind_Key>(
          'MorpheusPublicKind_key',
        ),
        did = lib
            .lookupFunction<NMorpheusPublicKind_Did, DMorpheusPublicKind_Did>(
          'MorpheusPublicKind_did',
        ),
        delete = lib.lookupFunction<NDelete_MorpheusPublicKind,
            DDelete_MorpheusPublicKind>(
          'delete_MorpheusPublicKind',
        );
}

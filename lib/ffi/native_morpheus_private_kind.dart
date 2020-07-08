import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';

typedef NDelete_MorpheusPrivateKind = Void Function(
  Pointer<Void> morpheusPrivateKind,
);
typedef DDelete_MorpheusPrivateKind = void Function(
  Pointer<Void> morpheusPrivateKind,
);

typedef NMorpheusPrivateKind_Kind_Get = Pointer<Utf8> Function(
  Pointer<Void> morpheusPrivateKind,
);
typedef DMorpheusPrivateKind_Kind_Get = Pointer<Utf8> Function(
  Pointer<Void> morpheusPrivateKind,
);

typedef NMorpheusPrivateKind_Len_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPrivateKind,
);
typedef DMorpheusPrivateKind_Len_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPrivateKind,
);

typedef NMorpheusPrivateKind_IsEmpty_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPrivateKind,
);
typedef DMorpheusPrivateKind_IsEmpty_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPrivateKind,
);

typedef NMorpheusPrivateKind_Neuter = Pointer<Void> Function(
  Pointer<Void> morpheusPrivateKind,
);
typedef DMorpheusPrivateKind_Neuter = Pointer<Void> Function(
  Pointer<Void> morpheusPrivateKind,
);

typedef NMorpheusPrivateKind_Key = Pointer<Result> Function(
  Pointer<Void> morpheusPrivateKind,
  Int32 idx,
);
typedef DMorpheusPrivateKind_Key = Pointer<Result> Function(
  Pointer<Void> morpheusPrivateKind,
  int idx,
);

typedef NMorpheusPrivateKind_Did = Pointer<Result> Function(
  Pointer<Void> morpheusPrivateKind,
  Int32 idx,
);
typedef DMorpheusPrivateKind_Did = Pointer<Result> Function(
  Pointer<Void> morpheusPrivateKind,
  int idx,
);

class NativeMorpheusPrivateKind {
  final DDelete_MorpheusPrivateKind delete;
  final DMorpheusPrivateKind_Kind_Get kindGet;
  final DMorpheusPrivateKind_Len_Get lenGet;
  final DMorpheusPrivateKind_IsEmpty_Get isEmptyGet;
  final DMorpheusPrivateKind_Neuter neuter;
  final DMorpheusPrivateKind_Key key;
  final DMorpheusPrivateKind_Did did;

  NativeMorpheusPrivateKind(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_MorpheusPrivateKind,
            DDelete_MorpheusPrivateKind>(
          'delete_MorpheusPrivateKind',
        ),
        kindGet = lib.lookupFunction<NMorpheusPrivateKind_Kind_Get,
            DMorpheusPrivateKind_Kind_Get>(
          'MorpheusPrivateKind_kind_get',
        ),
        lenGet = lib.lookupFunction<NMorpheusPrivateKind_Len_Get,
            DMorpheusPrivateKind_Len_Get>(
          'MorpheusPrivateKind_len_get',
        ),
        isEmptyGet = lib.lookupFunction<NMorpheusPrivateKind_IsEmpty_Get,
            DMorpheusPrivateKind_IsEmpty_Get>(
          'MorpheusPrivateKind_is_empty_get',
        ),
        neuter = lib.lookupFunction<NMorpheusPrivateKind_Neuter,
            DMorpheusPrivateKind_Neuter>(
          'MorpheusPrivateKind_neuter',
        ),
        key = lib
            .lookupFunction<NMorpheusPrivateKind_Key, DMorpheusPrivateKind_Key>(
          'MorpheusPrivateKind_key',
        ),
        did = lib
            .lookupFunction<NMorpheusPrivateKind_Did, DMorpheusPrivateKind_Did>(
          'MorpheusPrivateKind_did',
        );
}

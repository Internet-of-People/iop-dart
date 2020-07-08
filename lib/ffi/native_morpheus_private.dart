import 'dart:ffi';
import 'package:morpheus_sdk/ffi/ffi.dart';

typedef NDelete_MorpheusPrivate = Void Function(
  Pointer<Void> morpheusPrivate,
);
typedef DDelete_MorpheusPrivate = void Function(
  Pointer<Void> morpheusPrivate,
);

typedef NMorpheusPrivate_Personas_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
);
typedef DMorpheusPrivate_Personas_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
);

typedef NMorpheusPrivate_Public_Get = Pointer<Void> Function(
  Pointer<Void> morpheusPrivate,
);
typedef DMorpheusPrivate_Public_Get = Pointer<Void> Function(
  Pointer<Void> morpheusPrivate,
);

typedef NMorpheusPrivate_KeyByPk = Pointer<Result> Function(
  Pointer<Void> private,
  Pointer<Void> pk,
);
typedef DMorpheusPrivate_KeyByPk = Pointer<Result> Function(
  Pointer<Void> morpheusPrivate,
  Pointer<Void> pk,
);

class NativeMorpheusPrivate {
  final DDelete_MorpheusPrivate delete;
  final DMorpheusPrivate_Personas_Get personasGet;
  final DMorpheusPrivate_Public_Get publicGet;
  final DMorpheusPrivate_KeyByPk keyByPk;

  NativeMorpheusPrivate(DynamicLibrary lib)
      : delete = lib
            .lookupFunction<NDelete_MorpheusPrivate, DDelete_MorpheusPrivate>(
          'delete_MorpheusPrivate',
        ),
        personasGet = lib.lookupFunction<NMorpheusPrivate_Personas_Get,
            DMorpheusPrivate_Personas_Get>(
          'MorpheusPrivate_personas_get',
        ),
        publicGet = lib.lookupFunction<NMorpheusPrivate_Public_Get,
            DMorpheusPrivate_Public_Get>(
          'MorpheusPrivate_public_get',
        ),
        keyByPk = lib
            .lookupFunction<NMorpheusPrivate_KeyByPk, DMorpheusPrivate_KeyByPk>(
          'MorpheusPrivate_key_by_pk',
        );
}

import 'dart:ffi';
import 'package:iop_sdk/src/ffi/ffi.dart';

typedef NDelete_MorpheusPublic = Void Function(
  Pointer<Void> morpheusPublic,
);
typedef DDelete_MorpheusPublic = void Function(
  Pointer<Void> morpheusPublic,
);

typedef NMorpheusPublic_Personas_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
);
typedef DMorpheusPublic_Personas_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
);

typedef NMorpheusPublic_KeyById = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
  Pointer<Void> keyId,
);
typedef DMorpheusPublic_KeyById = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
  Pointer<Void> keyId,
);

class NativeMorpheusPublic {
  final DDelete_MorpheusPublic delete;
  final DMorpheusPublic_Personas_Get personasGet;
  final DMorpheusPublic_KeyById keyById;

  NativeMorpheusPublic(DynamicLibrary lib)
      : delete =
            lib.lookupFunction<NDelete_MorpheusPublic, DDelete_MorpheusPublic>(
          'delete_MorpheusPublic',
        ),
        personasGet = lib.lookupFunction<NMorpheusPublic_Personas_Get,
            DMorpheusPublic_Personas_Get>(
          'MorpheusPublic_personas_get',
        ),
        keyById = lib
            .lookupFunction<NMorpheusPublic_KeyById, DMorpheusPublic_KeyById>(
          'MorpheusPublic_key_by_id',
        );
}

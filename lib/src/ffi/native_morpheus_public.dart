import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

typedef NDelete_MorpheusPublic = Void Function(
  Pointer<Void> morpheusPublic,
);
typedef DDelete_MorpheusPublic = void Function(
  Pointer<Void> morpheusPublic,
);

typedef NMorpheusPublic_Kind = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
  Pointer<Utf8> didKind,
);
typedef DMorpheusPublic_Kind = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
  Pointer<Utf8> didKind,
);

typedef NMorpheusPublic_Personas_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
);
typedef DMorpheusPublic_Personas_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
);

typedef NMorpheusPublic_Devices_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
);
typedef DMorpheusPublic_Devices_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
);

typedef NMorpheusPublic_Groups_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
);
typedef DMorpheusPublic_Groups_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
);

typedef NMorpheusPublic_Resources_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
);
typedef DMorpheusPublic_Resources_Get = Pointer<Result> Function(
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
  final DMorpheusPublic_Kind kind;
  final DMorpheusPublic_Personas_Get personasGet;
  final DMorpheusPublic_Devices_Get devicesGet;
  final DMorpheusPublic_Groups_Get groupsGet;
  final DMorpheusPublic_Resources_Get resourcesGet;
  final DMorpheusPublic_KeyById keyById;

  NativeMorpheusPublic(DynamicLibrary lib)
      : delete =
            lib.lookupFunction<NDelete_MorpheusPublic, DDelete_MorpheusPublic>(
          'delete_MorpheusPublic',
        ),
        kind = lib.lookupFunction<NMorpheusPublic_Kind, DMorpheusPublic_Kind>(
          'MorpheusPublic_kind',
        ),
        personasGet = lib.lookupFunction<NMorpheusPublic_Personas_Get,
            DMorpheusPublic_Personas_Get>(
          'MorpheusPublic_personas_get',
        ),
        devicesGet = lib.lookupFunction<NMorpheusPublic_Devices_Get,
            DMorpheusPublic_Devices_Get>(
          'MorpheusPublic_devices_get',
        ),
        groupsGet = lib.lookupFunction<NMorpheusPublic_Groups_Get,
            DMorpheusPublic_Groups_Get>(
          'MorpheusPublic_groups_get',
        ),
        resourcesGet = lib.lookupFunction<NMorpheusPublic_Resources_Get,
            DMorpheusPublic_Resources_Get>(
          'MorpheusPublic_resources_get',
        ),
        keyById = lib
            .lookupFunction<NMorpheusPublic_KeyById, DMorpheusPublic_KeyById>(
          'MorpheusPublic_key_by_id',
        );
}

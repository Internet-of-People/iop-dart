import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';

typedef NDelete_HydraPrivate = Void Function(
  Pointer<Void> private,
);
typedef DDelete_HydraPrivate = void Function(
  Pointer<Void> private,
);

typedef NHydraPrivate_Neuter = Pointer<Result> Function(
  Pointer<Void> private,
);
typedef DHydraPrivate_Neuter = Pointer<Result> Function(
  Pointer<Void> private,
);

typedef NHydraPrivate_SignHydraTx = Pointer<Result> Function(
  Pointer<Void> private,
  Pointer<Utf8> address,
  Pointer<Utf8> txJson,
);
typedef DHydraPrivate_SignHydraTx = Pointer<Result> Function(
  Pointer<Void> private,
  Pointer<Utf8> address,
  Pointer<Utf8> txJson,
);

class NativeHydraPrivate {
  final DDelete_HydraPrivate delete;
  final DHydraPrivate_SignHydraTx signHydraTx;
  final DHydraPrivate_Neuter publicGet;

  NativeHydraPrivate(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_HydraPrivate, DDelete_HydraPrivate>(
          'delete_HydraPrivate',
        ),
        signHydraTx = lib.lookupFunction<NHydraPrivate_SignHydraTx,
            DHydraPrivate_SignHydraTx>(
          'HydraPrivate_sign_hydra_tx',
        ),
        publicGet =
            lib.lookupFunction<NHydraPrivate_Neuter, DHydraPrivate_Neuter>(
          'HydraPrivate_public_get',
        );

  // TODO HydraPrivate_xpub_get
  // TODO HydraPrivate_receive_keys_get
  // TODO HydraPrivate_change_keys_get
  // TODO HydraPrivate_key
  // TODO HydraPrivate_key_by_pk
}

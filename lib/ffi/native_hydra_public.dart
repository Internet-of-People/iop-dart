import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';

typedef NDelete_HydraPublic = Void Function(
  Pointer<Void> public,
);
typedef DDelete_HydraPublic = void Function(
  Pointer<Void> public,
);

typedef NHydraPublic_Key = Pointer<Result> Function(
  Pointer<Void> hydra,
  Int32 idx,
);
typedef DHydraPublic_Key = Pointer<Result> Function(
  Pointer<Void> hydra,
  int idx,
);

typedef NHydraPublic_KeyByAddress = Pointer<Result> Function(
  Pointer<Void> public,
  Pointer<Utf8> address,
);
typedef DHydraPublic_KeyByAddress = Pointer<Result> Function(
  Pointer<Void> public,
  Pointer<Utf8> address,
);

class NativeHydraPublic {
  final DDelete_HydraPublic delete;
  final DHydraPublic_Key key;
  final DHydraPublic_KeyByAddress keyByAddress;

  NativeHydraPublic(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_HydraPublic, DDelete_HydraPublic>(
          'delete_HydraPublic',
        ),
        key = lib.lookupFunction<NHydraPublic_Key, DHydraPublic_Key>(
          'HydraPublic_key',
        ),
        keyByAddress = lib.lookupFunction<NHydraPublic_KeyByAddress,
            DHydraPublic_KeyByAddress>(
          'HydraPublic_key_by_address',
        );
}

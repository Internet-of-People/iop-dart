import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';

typedef NHydraPlugin_Rewind = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPwd,
  Pointer<Utf8> network,
  Int32 idx,
);
typedef DHydraPlugin_Rewind = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPwd,
  Pointer<Utf8> network,
  int idx,
);

typedef NHydraPlugin_Get = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> network,
  Int32 idx,
);
typedef DHydraPlugin_Get = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> network,
  int idx,
);

typedef NDelete_HydraPlugin = Void Function(
  Pointer<Void> hydra,
);
typedef DDelete_HydraPlugin = void Function(
  Pointer<Void> hydra,
);

typedef NHydraPlugin_Private = Pointer<Result> Function(
  Pointer<Void> hydra,
  Pointer<Utf8> unlockPassword,
);
typedef DHydraPlugin_Private = Pointer<Result> Function(
  Pointer<Void> hydra,
  Pointer<Utf8> unlockPassword,
);

typedef NHydraPlugin_Public_Get = Pointer<Result> Function(
  Pointer<Void> hydra,
);
typedef DHydraPlugin_Public_Get = Pointer<Result> Function(
  Pointer<Void> hydra,
);

class NativeHydraPlugin {
  final DHydraPlugin_Rewind rewind;
  final DHydraPlugin_Get get;
  final DDelete_HydraPlugin delete;
  final DHydraPlugin_Private private;
  final DHydraPlugin_Public_Get publicGet;

  NativeHydraPlugin(DynamicLibrary lib)
      : rewind = lib.lookupFunction<NHydraPlugin_Rewind, DHydraPlugin_Rewind>(
          'HydraPlugin_rewind',
        ),
        get = lib.lookupFunction<NHydraPlugin_Get, DHydraPlugin_Get>(
          'HydraPlugin_get',
        ),
        delete = lib.lookupFunction<NDelete_HydraPlugin, DDelete_HydraPlugin>(
          'delete_HydraPlugin',
        ),
        private =
            lib.lookupFunction<NHydraPlugin_Private, DHydraPlugin_Private>(
          'HydraPlugin_private',
        ),
        publicGet = lib
            .lookupFunction<NHydraPlugin_Public_Get, DHydraPlugin_Public_Get>(
          'HydraPlugin_public',
        );
}

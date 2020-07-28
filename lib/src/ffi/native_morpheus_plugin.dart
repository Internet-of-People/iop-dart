import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

typedef NMorpheusPlugin_Rewind = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPwd,
);
typedef DMorpheusPlugin_Rewind = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPwd,
);

typedef NMorpheusPlugin_Get = Pointer<Result> Function(
  Pointer<Void> vault,
);
typedef DMorpheusPlugin_Get = Pointer<Result> Function(
  Pointer<Void> vault,
);

typedef NMorpheusPlugin_Public_Get = Pointer<Result> Function(
  Pointer<Void> vault,
);
typedef DMorpheusPlugin_Public_Get = Pointer<Result> Function(
  Pointer<Void> vault,
);

typedef NMorpheusPlugin_Private = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPassword,
);
typedef DMorpheusPlugin_Private = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPassword,
);

typedef NDelete_MorpheusPlugin = Void Function(
  Pointer<Void> morpheus,
);
typedef DDelete_MorpheusPlugin = void Function(
  Pointer<Void> morpheus,
);

class NativeMorpheusPlugin {
  final DMorpheusPlugin_Rewind rewind;
  final DMorpheusPlugin_Get get;
  final DMorpheusPlugin_Public_Get public_get;
  final DMorpheusPlugin_Private private;
  final DDelete_MorpheusPlugin delete;

  NativeMorpheusPlugin(DynamicLibrary lib)
      : rewind =
            lib.lookupFunction<NMorpheusPlugin_Rewind, DMorpheusPlugin_Rewind>(
          'MorpheusPlugin_rewind',
        ),
        get = lib.lookupFunction<NMorpheusPlugin_Get, DMorpheusPlugin_Get>(
          'MorpheusPlugin_get',
        ),
        public_get = lib.lookupFunction<NMorpheusPlugin_Public_Get,
            DMorpheusPlugin_Public_Get>(
          'MorpheusPlugin_public_get',
        ),
        private = lib
            .lookupFunction<NMorpheusPlugin_Private, DMorpheusPlugin_Private>(
          'MorpheusPlugin_private',
        ),
        delete =
            lib.lookupFunction<NDelete_MorpheusPlugin, DDelete_MorpheusPlugin>(
          'delete_MorpheusPlugin',
        );
}

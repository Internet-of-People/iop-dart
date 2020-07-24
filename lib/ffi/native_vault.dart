import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/ffi/ffi.dart';

typedef NVault_Create = Pointer<Result> Function(
  Pointer<Utf8> lang,
  Pointer<Utf8> seed,
  Pointer<Utf8> word25,
  Pointer<Utf8> unlockPassword,
);
typedef DVault_Create = Pointer<Result> Function(
  Pointer<Utf8> lang,
  Pointer<Utf8> seed,
  Pointer<Utf8> word25,
  Pointer<Utf8> unlockPassword,
);

typedef NDelete_Vault = Void Function(
  Pointer<Void> vault,
);
typedef DDelete_Vault = void Function(
  Pointer<Void> vault,
);

typedef NVault_Dirty_Get = Pointer<Result> Function(
  Pointer<Void> vault,
);
typedef DVault_Dirty_Get = Pointer<Result> Function(
  Pointer<Void> vault,
);

typedef NVault_Save = Pointer<Result> Function(
  Pointer<Void> vault,
);
typedef DVault_Save = Pointer<Result> Function(
  Pointer<Void> vault,
);

typedef NVault_Load = Pointer<Result> Function(
  Pointer<Utf8> json,
);
typedef DVault_Load = Pointer<Result> Function(
  Pointer<Utf8> json,
);

class NativeVault {
  final DVault_Create create;
  final DDelete_Vault delete;
  final DVault_Save save;
  final DVault_Load load;
  final DVault_Dirty_Get dirty_get;

  NativeVault(DynamicLibrary lib)
      : create = lib.lookupFunction<NVault_Create, DVault_Create>(
          'Vault_create',
        ),
        delete = lib.lookupFunction<NDelete_Vault, DDelete_Vault>(
          'delete_Vault',
        ),
        save = lib.lookupFunction<NVault_Save, DVault_Save>(
          'Vault_save',
        ),
        load = lib.lookupFunction<NVault_Load, DVault_Load>(
          'Vault_load',
        ),
        dirty_get = lib.lookupFunction<NVault_Dirty_Get, DVault_Dirty_Get>(
          'Vault_dirty_get',
        );
}

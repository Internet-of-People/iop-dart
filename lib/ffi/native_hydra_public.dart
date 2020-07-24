import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/ffi/ffi.dart';

typedef NDelete_HydraPublic = Void Function(
  Pointer<Void> public,
);
typedef DDelete_HydraPublic = void Function(
  Pointer<Void> public,
);

typedef NHydraPublic_Xpub_Get = Pointer<Utf8> Function(
  Pointer<Void> private,
);
typedef DHydraPublic_Xpub_Get = Pointer<Utf8> Function(
  Pointer<Void> private,
);

typedef NHydraPublic_ReceiveKeys_Get = Uint32 Function(
  Pointer<Void> private,
);
typedef DHydraPublic_ReceiveKeys_Get = int Function(
  Pointer<Void> private,
);

typedef NHydraPublic_ChangeKeys_Get = Uint32 Function(
  Pointer<Void> private,
);
typedef DHydraPublic_ChangeKeys_Get = int Function(
  Pointer<Void> private,
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
  final DHydraPublic_Xpub_Get xpubGet;
  final DHydraPublic_ReceiveKeys_Get receiveKeysGet;
  final DHydraPublic_ChangeKeys_Get changeKeysGet;
  final DHydraPublic_Key key;
  final DHydraPublic_KeyByAddress keyByAddress;

  NativeHydraPublic(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_HydraPublic, DDelete_HydraPublic>(
          'delete_HydraPublic',
        ),
        xpubGet =
            lib.lookupFunction<NHydraPublic_Xpub_Get, DHydraPublic_Xpub_Get>(
          'HydraPublic_xpub_get',
        ),
        receiveKeysGet = lib.lookupFunction<NHydraPublic_ReceiveKeys_Get,
            DHydraPublic_ReceiveKeys_Get>(
          'HydraPublic_receive_keys_get',
        ),
        changeKeysGet = lib.lookupFunction<NHydraPublic_ChangeKeys_Get,
            DHydraPublic_ChangeKeys_Get>(
          'HydraPublic_change_keys_get',
        ),
        key = lib.lookupFunction<NHydraPublic_Key, DHydraPublic_Key>(
          'HydraPublic_key',
        ),
        keyByAddress = lib.lookupFunction<NHydraPublic_KeyByAddress,
            DHydraPublic_KeyByAddress>(
          'HydraPublic_key_by_address',
        );
}

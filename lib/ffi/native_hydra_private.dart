import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/ffi/ffi.dart';

typedef NDelete_HydraPrivate = Void Function(
  Pointer<Void> private,
);
typedef DDelete_HydraPrivate = void Function(
  Pointer<Void> private,
);

typedef NHydraPrivate_Public_Get = Pointer<Result> Function(
  Pointer<Void> private,
);
typedef DHydraPrivate_Public_Get = Pointer<Result> Function(
  Pointer<Void> private,
);

typedef NHydraPrivate_Xpub_Get = Pointer<Utf8> Function(
  Pointer<Void> private,
);
typedef DHydraPrivate_Xpub_Get = Pointer<Utf8> Function(
  Pointer<Void> private,
);

typedef NHydraPrivate_ReceiveKeys_Get = Uint32 Function(
  Pointer<Void> private,
);
typedef DHydraPrivate_ReceiveKeys_Get = int Function(
  Pointer<Void> private,
);

typedef NHydraPrivate_ChangeKeys_Get = Uint32 Function(
  Pointer<Void> private,
);
typedef DHydraPrivate_ChangeKeys_Get = int Function(
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

typedef NHydraPrivate_Key = Pointer<Result> Function(
  Pointer<Void> private,
  Int32 idx,
);
typedef DHydraPrivate_Key = Pointer<Result> Function(
  Pointer<Void> private,
  int idx,
);

typedef NHydraPrivate_KeyByPk = Pointer<Result> Function(
  Pointer<Void> private,
  Pointer<Void> secpPk,
);
typedef DHydraPrivate_KeyByPk = Pointer<Result> Function(
  Pointer<Void> private,
  Pointer<Void> secpPk,
);

class NativeHydraPrivate {
  final DDelete_HydraPrivate delete;
  final DHydraPrivate_Public_Get publicGet;
  final DHydraPrivate_Xpub_Get xpubGet;
  final DHydraPrivate_ReceiveKeys_Get receiveKeysGet;
  final DHydraPrivate_ChangeKeys_Get changeKeysGet;
  final DHydraPrivate_SignHydraTx signHydraTx;
  final DHydraPrivate_Key key;
  final DHydraPrivate_KeyByPk keyByPk;

  NativeHydraPrivate(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_HydraPrivate, DDelete_HydraPrivate>(
          'delete_HydraPrivate',
        ),
        publicGet = lib
            .lookupFunction<NHydraPrivate_Public_Get, DHydraPrivate_Public_Get>(
          'HydraPrivate_public_get',
        ),
        xpubGet =
            lib.lookupFunction<NHydraPrivate_Xpub_Get, DHydraPrivate_Xpub_Get>(
          'HydraPrivate_xpub_get',
        ),
        receiveKeysGet = lib.lookupFunction<NHydraPrivate_ReceiveKeys_Get,
            DHydraPrivate_ReceiveKeys_Get>(
          'HydraPrivate_receive_keys_get',
        ),
        changeKeysGet = lib.lookupFunction<NHydraPrivate_ChangeKeys_Get,
            DHydraPrivate_ChangeKeys_Get>(
          'HydraPrivate_change_keys_get',
        ),
        signHydraTx = lib.lookupFunction<NHydraPrivate_SignHydraTx,
            DHydraPrivate_SignHydraTx>(
          'HydraPrivate_sign_hydra_tx',
        ),
        key = lib.lookupFunction<NHydraPrivate_Key, DHydraPrivate_Key>(
          'HydraPrivate_key',
        ),
        keyByPk =
            lib.lookupFunction<NHydraPrivate_KeyByPk, DHydraPrivate_KeyByPk>(
          'HydraPrivate_key_by_pk',
        );
}

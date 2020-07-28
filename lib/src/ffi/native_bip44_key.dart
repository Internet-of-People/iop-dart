import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef NDelete_Bip44Key = Void Function(
  Pointer<Void> bip44Sk,
);
typedef DDelete_Bip44Key = void Function(
  Pointer<Void> bip44Sk,
);

typedef NBip44Key_Node = Pointer<Void> Function(
  Pointer<Void> bip44Sk,
);
typedef DBip44Key_Node = Pointer<Void> Function(
  Pointer<Void> bip44Sk,
);

typedef NBip44Key_PrivateKey = Pointer<Void> Function(
  Pointer<Void> bip44Sk,
);
typedef DBip44Key_PrivateKey = Pointer<Void> Function(
  Pointer<Void> bip44Sk,
);

typedef NBip44Key_Slip44_Get = Int32 Function(
  Pointer<Void> bip44Sk,
);
typedef DBip44Key_Slip44_Get = int Function(
  Pointer<Void> bip44Sk,
);

typedef NBip44Key_Account_Get = Int32 Function(
  Pointer<Void> bip44Sk,
);
typedef DBip44Key_Account_Get = int Function(
  Pointer<Void> bip44Sk,
);

typedef NBip44Key_Change_Get = Uint8 Function(
  Pointer<Void> bip44Sk,
);
typedef DBip44Key_Change_Get = int Function(
  Pointer<Void> bip44Sk,
);

typedef NBip44Key_Key_Get = Int32 Function(
  Pointer<Void> bip44Sk,
);
typedef DBip44Key_Key_Get = int Function(
  Pointer<Void> bip44Sk,
);

typedef NBip44Key_Path_Get = Pointer<Utf8> Function(
  Pointer<Void> bip44Sk,
);
typedef DBip44Key_Path_Get = Pointer<Utf8> Function(
  Pointer<Void> bip44Sk,
);

typedef NBip44Key_Neuter = Pointer<Void> Function(
  Pointer<Void> bip44Sk,
);
typedef DBip44Key_Neuter = Pointer<Void> Function(
  Pointer<Void> bip44Sk,
);

typedef NBip44Key_Wif_Get = Pointer<Utf8> Function(
  Pointer<Void> bip44Sk,
);
typedef DBip44Key_Wif_Get = Pointer<Utf8> Function(
  Pointer<Void> bip44Sk,
);

class NativeBip44Key {
  final DDelete_Bip44Key delete;
  final DBip44Key_Node node;
  final DBip44Key_PrivateKey privateKey;
  final DBip44Key_Slip44_Get slip44Get;
  final DBip44Key_Account_Get accountGet;
  final DBip44Key_Change_Get changeGet;
  final DBip44Key_Key_Get keyGet;
  final DBip44Key_Path_Get pathGet;
  final DBip44Key_Neuter neuter;
  final DBip44Key_Wif_Get wifGet;

  NativeBip44Key(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_Bip44Key, DDelete_Bip44Key>(
          'delete_Bip44Key',
        ),
        node = lib.lookupFunction<NBip44Key_Node, DBip44Key_Node>(
          'Bip44Key_node',
        ),
        privateKey =
            lib.lookupFunction<NBip44Key_PrivateKey, DBip44Key_PrivateKey>(
          'Bip44Key_private_key',
        ),
        slip44Get =
            lib.lookupFunction<NBip44Key_Slip44_Get, DBip44Key_Slip44_Get>(
          'Bip44Key_slip44_get',
        ),
        accountGet =
            lib.lookupFunction<NBip44Key_Account_Get, DBip44Key_Account_Get>(
          'Bip44Key_account_get',
        ),
        changeGet =
            lib.lookupFunction<NBip44Key_Change_Get, DBip44Key_Change_Get>(
          'Bip44Key_change_get',
        ),
        keyGet = lib.lookupFunction<NBip44Key_Key_Get, DBip44Key_Key_Get>(
          'Bip44Key_key_get',
        ),
        pathGet = lib.lookupFunction<NBip44Key_Path_Get, DBip44Key_Path_Get>(
          'Bip44Key_path_get',
        ),
        neuter = lib.lookupFunction<NBip44Key_Neuter, DBip44Key_Neuter>(
          'Bip44Key_neuter',
        ),
        wifGet = lib.lookupFunction<NBip44Key_Wif_Get, DBip44Key_Wif_Get>(
          'Bip44Key_wif_get',
        );
}

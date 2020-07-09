import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef NDelete_Bip44PublicKey = Void Function(
  Pointer<Void> bip44Pk,
);
typedef DDelete_Bip44PublicKey = void Function(
  Pointer<Void> bip44Pk,
);

typedef NBip44PublicKey_Node = Pointer<Void> Function(
  Pointer<Void> bip44Pk,
);
typedef DBip44PublicKey_Node = Pointer<Void> Function(
  Pointer<Void> bip44Pk,
);

typedef NBip44PublicKey_PublicKey = Pointer<Void> Function(
  Pointer<Void> bip44Pk,
);
typedef DBip44PublicKey_PublicKey = Pointer<Void> Function(
  Pointer<Void> bip44Pk,
);

typedef NBip44PublicKey_KeyId = Pointer<Void> Function(
  Pointer<Void> bip44Pk,
);
typedef DBip44PublicKey_KeyId = Pointer<Void> Function(
  Pointer<Void> bip44Pk,
);

typedef NBip44PublicKey_Slip44_Get = Int32 Function(
  Pointer<Void> bip44Pk,
);
typedef DBip44PublicKey_Slip44_Get = int Function(
  Pointer<Void> bip44Pk,
);

typedef NBip44PublicKey_Account_Get = Int32 Function(
  Pointer<Void> bip44Pk,
);
typedef DBip44PublicKey_Account_Get = int Function(
  Pointer<Void> bip44Pk,
);

typedef NBip44PublicKey_Change_Get = Uint8 Function(
  Pointer<Void> bip44Pk,
);
typedef DBip44PublicKey_Change_Get = int Function(
  Pointer<Void> bip44Pk,
);

typedef NBip44PublicKey_Key_Get = Int32 Function(
  Pointer<Void> bip44Pk,
);
typedef DBip44PublicKey_Key_Get = int Function(
  Pointer<Void> bip44Pk,
);

typedef NBip44PublicKey_Path_Get = Pointer<Utf8> Function(
  Pointer<Void> bip44Pk,
);
typedef DBip44PublicKey_Path_Get = Pointer<Utf8> Function(
  Pointer<Void> bip44Pk,
);

typedef NBip44PublicKey_Address_Get = Pointer<Utf8> Function(
  Pointer<Void> bip44Pk,
);
typedef DBip44PublicKey_Address_Get = Pointer<Utf8> Function(
  Pointer<Void> bip44Pk,
);

class NativeBip44PublicKey {
  final DDelete_Bip44PublicKey delete;
  final DBip44PublicKey_Node node;
  final DBip44PublicKey_PublicKey publicKey;
  final DBip44PublicKey_KeyId keyId;
  final DBip44PublicKey_Slip44_Get slip44Get;
  final DBip44PublicKey_Account_Get accountGet;
  final DBip44PublicKey_Change_Get changeGet;
  final DBip44PublicKey_Key_Get keyGet;
  final DBip44PublicKey_Path_Get pathGet;
  final DBip44PublicKey_Address_Get addressGet;

  NativeBip44PublicKey(DynamicLibrary lib)
      : delete =
            lib.lookupFunction<NDelete_Bip44PublicKey, DDelete_Bip44PublicKey>(
          'delete_Bip44PublicKey',
        ),
        node = lib.lookupFunction<NBip44PublicKey_Node, DBip44PublicKey_Node>(
          'Bip44PublicKey_node',
        ),
        publicKey = lib.lookupFunction<NBip44PublicKey_PublicKey,
            DBip44PublicKey_PublicKey>(
          'Bip44PublicKey_public_key',
        ),
        keyId =
            lib.lookupFunction<NBip44PublicKey_KeyId, DBip44PublicKey_KeyId>(
          'Bip44PublicKey_key_id',
        ),
        slip44Get = lib.lookupFunction<NBip44PublicKey_Slip44_Get,
            DBip44PublicKey_Slip44_Get>(
          'Bip44PublicKey_slip44_get',
        ),
        accountGet = lib.lookupFunction<NBip44PublicKey_Account_Get,
            DBip44PublicKey_Account_Get>(
          'Bip44PublicKey_account_get',
        ),
        changeGet = lib.lookupFunction<NBip44PublicKey_Change_Get,
            DBip44PublicKey_Change_Get>(
          'Bip44PublicKey_change_get',
        ),
        keyGet = lib
            .lookupFunction<NBip44PublicKey_Key_Get, DBip44PublicKey_Key_Get>(
          'Bip44PublicKey_key_get',
        ),
        pathGet = lib
            .lookupFunction<NBip44PublicKey_Path_Get, DBip44PublicKey_Path_Get>(
          'Bip44PublicKey_path_get',
        ),
        addressGet = lib.lookupFunction<NBip44PublicKey_Address_Get,
            DBip44PublicKey_Address_Get>(
          'Bip44PublicKey_address_get',
        );
}

import 'dart:ffi';
import 'package:morpheus_sdk/ffi/ffi.dart';

typedef NDelete_Bip44PublicKey = Void Function(
  Pointer<Void> bip44Pk,
);
typedef DDelete_Bip44PublicKey = void Function(
  Pointer<Void> bip44Pk,
);

typedef NBip44PublicKey_PublicKey_Get = Pointer<Result> Function(
  Pointer<Void> bip44Pk,
);
typedef DBip44PublicKey_PublicKey_Get = Pointer<Result> Function(
  Pointer<Void> bip44Pk,
);

typedef NBip44PublicKey_Address_Get = Pointer<Result> Function(
  Pointer<Void> bip44Pk,
);
typedef DBip44PublicKey_Address_Get = Pointer<Result> Function(
  Pointer<Void> bip44Pk,
);

class NativeBip44PublicKey {
  final DDelete_Bip44PublicKey delete;
  final DBip44PublicKey_PublicKey_Get publicKeyGet;
  final DBip44PublicKey_Address_Get addressGet;

  NativeBip44PublicKey(DynamicLibrary lib)
      : delete =
            lib.lookupFunction<NDelete_Bip44PublicKey, DDelete_Bip44PublicKey>(
          'delete_Bip44PublicKey',
        ),
        publicKeyGet = lib.lookupFunction<NBip44PublicKey_PublicKey_Get,
            DBip44PublicKey_PublicKey_Get>(
          'Bip44PublicKey_publicKey_get',
        ),
        addressGet = lib.lookupFunction<NBip44PublicKey_Address_Get,
            DBip44PublicKey_Address_Get>(
          'Bip44PublicKey_address_get',
        );
}

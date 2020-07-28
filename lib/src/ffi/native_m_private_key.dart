import 'dart:ffi';
import 'package:iop_sdk/src/ffi/ffi.dart';

typedef NDelete_MPrivateKey = Void Function(
  Pointer<Void> sk,
);
typedef DDelete_MPrivateKey = void Function(
  Pointer<Void> sk,
);

typedef NMPrivateKey_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpSk,
);
typedef DMPrivateKey_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpSk,
);

typedef NMPrivateKey_PublicKey = Pointer<Void> Function(
  Pointer<Void> sk,
);
typedef DMPrivateKey_PublicKey = Pointer<Void> Function(
  Pointer<Void> sk,
);

typedef NMPrivateKey_Sign = Pointer<Void> Function(
  Pointer<Void> sk,
  Pointer<NativeSlice> data,
);
typedef DMPrivateKey_Sign = Pointer<Void> Function(
  Pointer<Void> sk,
  Pointer<NativeSlice> data,
);

class NativeMPrivateKey {
  final DDelete_MPrivateKey delete;
  final DMPrivateKey_FromSecp fromSecp;
  final DMPrivateKey_PublicKey publicKey;
  final DMPrivateKey_Sign sign;

  NativeMPrivateKey(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_MPrivateKey, DDelete_MPrivateKey>(
          'delete_MPrivateKey',
        ),
        fromSecp =
            lib.lookupFunction<NMPrivateKey_FromSecp, DMPrivateKey_FromSecp>(
          'MPrivateKey_from_secp',
        ),
        publicKey =
            lib.lookupFunction<NMPrivateKey_PublicKey, DMPrivateKey_PublicKey>(
          'MPrivateKey_public_key',
        ),
        sign = lib.lookupFunction<NMPrivateKey_Sign, DMPrivateKey_Sign>(
          'MPrivateKey_sign',
        );
}

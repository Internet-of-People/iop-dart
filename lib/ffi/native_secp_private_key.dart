import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/ffi/ffi.dart';

typedef NDelete_SecpPrivateKey = Void Function(
  Pointer<Void> secpSk,
);
typedef DDelete_SecpPrivateKey = void Function(
  Pointer<Void> secpSk,
);

typedef NSecpPrivateKey_FromArkPassphrase = Pointer<Result> Function(
  Pointer<Utf8> passphrase,
);
typedef DSecpPrivateKey_FromArkPassphrase = Pointer<Result> Function(
  Pointer<Utf8> passphrase,
);

typedef NSecpPrivateKey_ToWif = Pointer<Utf8> Function(
  Pointer<Void> secpSk,
  Pointer<Utf8> network,
);
typedef DSecpPrivateKey_ToWif = Pointer<Utf8> Function(
  Pointer<Void> secpSk,
  Pointer<Utf8> network,
);

typedef NSecpPrivateKey_PublicKey = Pointer<Void> Function(
  Pointer<Void> secpSk,
);
typedef DSecpPrivateKey_PublicKey = Pointer<Void> Function(
  Pointer<Void> secpSk,
);

typedef NSecpPrivateKey_SignEcdsa = Pointer<Void> Function(
    Pointer<Void> secpSk, Pointer<NativeSlice> data);
typedef DSecpPrivateKey_SignEcdsa = Pointer<Void> Function(
    Pointer<Void> secpSk, Pointer<NativeSlice> data);

typedef NSecpPrivateKey_SignHydraTx = Pointer<Result> Function(
    Pointer<Void> secpSk, Pointer<Utf8> txJson);
typedef DSecpPrivateKey_SignHydraTx = Pointer<Result> Function(
    Pointer<Void> secpSk, Pointer<Utf8> txJson);

class NativeSecpPrivateKey {
  final DDelete_SecpPrivateKey delete;
  final DSecpPrivateKey_FromArkPassphrase fromArkPassphrase;
  final DSecpPrivateKey_ToWif toWif;
  final DSecpPrivateKey_PublicKey publicKey;
  final DSecpPrivateKey_SignEcdsa signEcdsa;
  final DSecpPrivateKey_SignHydraTx signHydraTx;

  NativeSecpPrivateKey(DynamicLibrary lib)
      : delete =
            lib.lookupFunction<NDelete_SecpPrivateKey, DDelete_SecpPrivateKey>(
          'delete_SecpPrivateKey',
        ),
        fromArkPassphrase = lib.lookupFunction<
            NSecpPrivateKey_FromArkPassphrase,
            DSecpPrivateKey_FromArkPassphrase>(
          'SecpPrivateKey_from_ark_passphrase',
        ),
        toWif =
            lib.lookupFunction<NSecpPrivateKey_ToWif, DSecpPrivateKey_ToWif>(
          'SecpPrivateKey_to_wif',
        ),
        publicKey = lib.lookupFunction<NSecpPrivateKey_PublicKey,
            DSecpPrivateKey_PublicKey>(
          'SecpPrivateKey_public_key',
        ),
        signEcdsa = lib.lookupFunction<NSecpPrivateKey_SignEcdsa,
            DSecpPrivateKey_SignEcdsa>(
          'SecpPrivateKey_sign_ecdsa',
        ),
        signHydraTx = lib.lookupFunction<NSecpPrivateKey_SignHydraTx,
            DSecpPrivateKey_SignHydraTx>(
          'SecpPrivateKey_sign_hydra_tx',
        );
}

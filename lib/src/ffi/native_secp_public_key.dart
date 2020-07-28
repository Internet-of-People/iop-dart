import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

typedef NDelete_SecpPublicKey = Void Function(
  Pointer<Void> secpPk,
);
typedef DDelete_SecpPublicKey = void Function(
  Pointer<Void> secpPk,
);

typedef NSecpPublicKey_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);
typedef DSecpPublicKey_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);

typedef NSecpPublicKey_ToString = Pointer<Result> Function(
  Pointer<Void> secpPk,
);
typedef DSecpPublicKey_ToString = Pointer<Result> Function(
  Pointer<Void> secpPk,
);

typedef NSecpPublicKey_KeyId = Pointer<Void> Function(
  Pointer<Void> secpPk,
);
typedef DSecpPublicKey_KeyId = Pointer<Void> Function(
  Pointer<Void> secpPk,
);

typedef NSecpPublicKey_ArkKeyId = Pointer<Void> Function(
  Pointer<Void> secpPk,
);
typedef DSecpPublicKey_ArkKeyId = Pointer<Void> Function(
  Pointer<Void> secpPk,
);

typedef NSecpPublicKey_ValidateId = Uint8 Function(
  Pointer<Void> secpPk,
  Pointer<Void> secpId,
);
typedef DSecpPublicKey_ValidateId = int Function(
  Pointer<Void> secpPk,
  Pointer<Void> secpId,
);

typedef NSecpPublicKey_ValidateArkId = Uint8 Function(
  Pointer<Void> secpPk,
  Pointer<Void> secpId,
);
typedef DSecpPublicKey_ValidateArkId = int Function(
  Pointer<Void> secpPk,
  Pointer<Void> secpId,
);

typedef NSecpPublicKey_ValidateEcdsa = Uint8 Function(
  Pointer<Void> secpPk,
  Pointer<NativeSlice> data,
  Pointer<Void> secpSig,
);
typedef DSecpPublicKey_ValidateEcdsa = int Function(
  Pointer<Void> secpPk,
  Pointer<NativeSlice> data,
  Pointer<Void> secpSig,
);

class NativeSecpPublicKey {
  final DDelete_SecpPublicKey delete;
  final DSecpPublicKey_FromString fromString;
  final DSecpPublicKey_ToString to_String; // cannot name it toString
  final DSecpPublicKey_KeyId keyId;
  final DSecpPublicKey_ArkKeyId arkKeyId;
  final DSecpPublicKey_ValidateId validateId;
  final DSecpPublicKey_ValidateArkId validateArkId;
  final DSecpPublicKey_ValidateEcdsa validateEcdsa;

  NativeSecpPublicKey(DynamicLibrary lib)
      : delete =
            lib.lookupFunction<NDelete_SecpPublicKey, DDelete_SecpPublicKey>(
          'delete_SecpPublicKey',
        ),
        fromString = lib.lookupFunction<NSecpPublicKey_FromString,
            DSecpPublicKey_FromString>(
          'SecpPublicKey_fromString',
        ),
        to_String = lib
            .lookupFunction<NSecpPublicKey_ToString, DSecpPublicKey_ToString>(
          'SecpPublicKey_to_string',
        ),
        keyId = lib.lookupFunction<NSecpPublicKey_KeyId, DSecpPublicKey_KeyId>(
          'SecpPublicKey_key_id',
        ),
        arkKeyId = lib
            .lookupFunction<NSecpPublicKey_ArkKeyId, DSecpPublicKey_ArkKeyId>(
          'SecpPublicKey_ark_key_id',
        ),
        validateId = lib.lookupFunction<NSecpPublicKey_ValidateId,
            DSecpPublicKey_ValidateId>(
          'SecpPublicKey_validate_id',
        ),
        validateArkId = lib.lookupFunction<NSecpPublicKey_ValidateArkId,
            DSecpPublicKey_ValidateArkId>(
          'SecpPublicKey_validate_ark_id',
        ),
        validateEcdsa = lib.lookupFunction<NSecpPublicKey_ValidateEcdsa,
            DSecpPublicKey_ValidateEcdsa>(
          'SecpPublicKey_validate_ecdsa',
        );
}

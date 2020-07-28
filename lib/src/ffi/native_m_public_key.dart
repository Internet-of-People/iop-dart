import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

typedef NDelete_MPublicKey = Void Function(
  Pointer<Void> pk,
);
typedef DDelete_MPublicKey = void Function(
  Pointer<Void> pk,
);

typedef NMPublicKey_Prefix = Pointer<Utf8> Function();
typedef DMPublicKey_Prefix = Pointer<Utf8> Function();

typedef NMPublicKey_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpPk,
);
typedef DMPublicKey_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpPk,
);

typedef NMPublicKey_FromBytes = Pointer<Result> Function(
  Pointer<NativeSlice> data,
);
typedef DMPublicKey_FromBytes = Pointer<Result> Function(
  Pointer<NativeSlice> data,
);

typedef NMPublicKey_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);
typedef DMPublicKey_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);

typedef NMPublicKey_ToBytes = Pointer<NativeSlice> Function(
  Pointer<Void> pk,
);
typedef DMPublicKey_ToBytes = Pointer<NativeSlice> Function(
  Pointer<Void> pk,
);

typedef NMPublicKey_ToString = Pointer<Utf8> Function(
  Pointer<Void> pk,
);
typedef DMPublicKey_ToString = Pointer<Utf8> Function(
  Pointer<Void> pk,
);

typedef NMPublicKey_KeyId = Pointer<Void> Function(
  Pointer<Void> pk,
);
typedef DMPublicKey_KeyId = Pointer<Void> Function(
  Pointer<Void> pk,
);

typedef NMPublicKey_ValidateId = Uint8 Function(
  Pointer<Void> pk,
  Pointer<Void> id,
);
typedef DMPublicKey_ValidateId = int Function(
  Pointer<Void> pk,
  Pointer<Void> id,
);

typedef NMPublicKey_Verify = Uint8 Function(
  Pointer<Void> pk,
  Pointer<NativeSlice> data,
  Pointer<Void> sig,
);
typedef DMPublicKey_Verify = int Function(
  Pointer<Void> pk,
  Pointer<NativeSlice> data,
  Pointer<Void> sig,
);

class NativeMPublicKey {
  final DDelete_MPublicKey delete;
  final DMPublicKey_Prefix prefix;
  final DMPublicKey_FromSecp fromSecp;
  final DMPublicKey_FromBytes fromBytes;
  final DMPublicKey_FromString fromString;
  final DMPublicKey_ToBytes toBytes;
  final DMPublicKey_ToString to_String; // cannot name it toString
  final DMPublicKey_KeyId keyId;
  final DMPublicKey_ValidateId validateId;
  final DMPublicKey_Verify verify;

  NativeMPublicKey(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_MPublicKey, DDelete_MPublicKey>(
          'delete_MPublicKey',
        ),
        prefix = lib.lookupFunction<NMPublicKey_Prefix, DMPublicKey_Prefix>(
          'MPublicKey_prefix',
        ),
        fromSecp =
            lib.lookupFunction<NMPublicKey_FromSecp, DMPublicKey_FromSecp>(
          'MPublicKey_from_secp',
        ),
        fromBytes =
            lib.lookupFunction<NMPublicKey_FromBytes, DMPublicKey_FromBytes>(
          'MPublicKey_from_bytes',
        ),
        fromString =
            lib.lookupFunction<NMPublicKey_FromString, DMPublicKey_FromString>(
          'MPublicKey_from_string',
        ),
        toBytes = lib.lookupFunction<NMPublicKey_ToBytes, DMPublicKey_ToBytes>(
          'MPublicKey_to_bytes',
        ),
        to_String =
            lib.lookupFunction<NMPublicKey_ToString, DMPublicKey_ToString>(
          'MPublicKey_to_string',
        ),
        keyId = lib.lookupFunction<NMPublicKey_KeyId, DMPublicKey_KeyId>(
          'MPublicKey_key_id',
        ),
        validateId =
            lib.lookupFunction<NMPublicKey_ValidateId, DMPublicKey_ValidateId>(
          'MPublicKey_validate_id',
        ),
        verify = lib.lookupFunction<NMPublicKey_Verify, DMPublicKey_Verify>(
          'MPublicKey_verify',
        );
}

import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/ffi/ffi.dart';

typedef NDelete_MKeyId = Void Function(
  Pointer<Void> pk,
);
typedef DDelete_MKeyId = void Function(
  Pointer<Void> pk,
);

typedef NMKeyId_Prefix = Pointer<Utf8> Function();
typedef DMKeyId_Prefix = Pointer<Utf8> Function();

typedef NMKeyId_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpId,
);
typedef DMKeyId_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpId,
);

typedef NMKeyId_FromBytes = Pointer<Result> Function(
  Pointer<NativeSlice> data,
);
typedef DMKeyId_FromBytes = Pointer<Result> Function(
  Pointer<NativeSlice> data,
);

typedef NMKeyId_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);
typedef DMKeyId_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);

typedef NMKeyId_ToBytes = Pointer<NativeSlice> Function(
  Pointer<Void> id,
);
typedef DMKeyId_ToBytes = Pointer<NativeSlice> Function(
  Pointer<Void> id,
);

typedef NMKeyId_ToString = Pointer<Utf8> Function(
  Pointer<Void> id,
);
typedef DMKeyId_ToString = Pointer<Utf8> Function(
  Pointer<Void> id,
);

class NativeMKeyId {
  final DDelete_MKeyId delete;
  final DMKeyId_Prefix prefix;
  final DMKeyId_FromSecp fromSecp;
  final DMKeyId_FromBytes fromBytes;
  final DMKeyId_FromString fromString;
  final DMKeyId_ToBytes toBytes;
  final DMKeyId_ToString to_String; // cannot name it toString

  NativeMKeyId(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_MKeyId, DDelete_MKeyId>(
          'delete_MKeyId',
        ),
        prefix = lib.lookupFunction<NMKeyId_Prefix, DMKeyId_Prefix>(
          'MKeyId_prefix',
        ),
        fromSecp = lib.lookupFunction<NMKeyId_FromSecp, DMKeyId_FromSecp>(
          'MKeyId_from_secp',
        ),
        fromBytes = lib.lookupFunction<NMKeyId_FromBytes, DMKeyId_FromBytes>(
          'MKeyId_from_bytes',
        ),
        fromString = lib.lookupFunction<NMKeyId_FromString, DMKeyId_FromString>(
          'MKeyId_from_string',
        ),
        toBytes = lib.lookupFunction<NMKeyId_ToBytes, DMKeyId_ToBytes>(
          'MKeyId_to_bytes',
        ),
        to_String = lib.lookupFunction<NMKeyId_ToString, DMKeyId_ToString>(
          'MKeyId_to_string',
        );
}

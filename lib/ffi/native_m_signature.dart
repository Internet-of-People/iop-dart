import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/ffi/ffi.dart';

typedef NDelete_MSignature = Void Function(
  Pointer<Void> sig,
);
typedef DDelete_MSignature = void Function(
  Pointer<Void> sig,
);

typedef NMSignature_Prefix = Pointer<Utf8> Function();
typedef DMSignature_Prefix = Pointer<Utf8> Function();

typedef NMSignature_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpSig,
);
typedef DMSignature_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpSig,
);

typedef NMSignature_FromBytes = Pointer<Result> Function(
  Pointer<NativeSlice> data,
);
typedef DMSignature_FromBytes = Pointer<Result> Function(
  Pointer<NativeSlice> data,
);

typedef NMSignature_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);
typedef DMSignature_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);

typedef NMSignature_ToBytes = Pointer<NativeSlice> Function(
  Pointer<Void> sig,
);
typedef DMSignature_ToBytes = Pointer<NativeSlice> Function(
  Pointer<Void> sig,
);

typedef NMSignature_ToString = Pointer<Utf8> Function(
  Pointer<Void> sig,
);
typedef DMSignature_ToString = Pointer<Utf8> Function(
  Pointer<Void> sig,
);

class NativeMSignature {
  final DDelete_MSignature delete;
  final DMSignature_Prefix prefix;
  final DMSignature_FromSecp fromSecp;
  final DMSignature_FromBytes fromBytes;
  final DMSignature_FromString fromString;
  final DMSignature_ToBytes toBytes;
  final DMSignature_ToString to_String; // cannot name it toString

  NativeMSignature(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_MSignature, DDelete_MSignature>(
          'delete_MSignature',
        ),
        prefix = lib.lookupFunction<NMSignature_Prefix, DMSignature_Prefix>(
          'MSignature_prefix',
        ),
        fromSecp =
            lib.lookupFunction<NMSignature_FromSecp, DMSignature_FromSecp>(
          'MSignature_from_secp',
        ),
        fromBytes =
            lib.lookupFunction<NMSignature_FromBytes, DMSignature_FromBytes>(
          'MSignature_from_bytes',
        ),
        fromString =
            lib.lookupFunction<NMSignature_FromString, DMSignature_FromString>(
          'MSignature_from_string',
        ),
        toBytes = lib.lookupFunction<NMSignature_ToBytes, DMSignature_ToBytes>(
          'MSignature_to_bytes',
        ),
        to_String =
            lib.lookupFunction<NMSignature_ToString, DMSignature_ToString>(
          'MSignature_to_string',
        );
}

import 'dart:ffi';
import 'package:iop_sdk/ffi/ffi.dart';

typedef NDelete_SecpSignature = Void Function(
  Pointer<Void> secpSig,
);
typedef DDelete_SecpSignature = void Function(
  Pointer<Void> secpSig,
);

typedef NSecpSignature_FromDer = Pointer<Result> Function(
  Pointer<NativeSlice> data,
);
typedef DSecpSignature_FromDer = Pointer<Result> Function(
  Pointer<NativeSlice> data,
);

typedef NSecpSignature_ToDer = Pointer<NativeSlice> Function(
  Pointer<Void> secpSig,
);
typedef DSecpSignature_ToDer = Pointer<NativeSlice> Function(
  Pointer<Void> secpSig,
);

class NativeSecpSignature {
  final DDelete_SecpSignature delete;
  final DSecpSignature_FromDer fromDer;
  final DSecpSignature_ToDer toDer;

  NativeSecpSignature(DynamicLibrary lib)
      : delete =
            lib.lookupFunction<NDelete_SecpSignature, DDelete_SecpSignature>(
          'delete_SecpSignature',
        ),
        fromDer =
            lib.lookupFunction<NSecpSignature_FromDer, DSecpSignature_FromDer>(
          'SecpSignature_from_der',
        ),
        toDer = lib.lookupFunction<NSecpSignature_ToDer, DSecpSignature_ToDer>(
          'SecpSignature_to_der',
        );
}

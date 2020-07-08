import 'dart:ffi';

typedef NDelete_SecpSignature = Void Function(
  Pointer<Void> secpSig,
);
typedef DDelete_SecpSignature = void Function(
  Pointer<Void> secpSig,
);

class NativeSecpSignature {
  final DDelete_SecpSignature delete;

  NativeSecpSignature(DynamicLibrary lib)
      : delete =
            lib.lookupFunction<NDelete_SecpSignature, DDelete_SecpSignature>(
          'delete_SecpSignature',
        );
}

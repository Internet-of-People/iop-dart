import 'dart:ffi';

typedef NDelete_SecpPrivateKey = Void Function(
  Pointer<Void> secpSk,
);
typedef DDelete_SecpPrivateKey = void Function(
  Pointer<Void> secpSk,
);

class NativeSecpPrivateKey {
  final DDelete_SecpPrivateKey delete;

  NativeSecpPrivateKey(DynamicLibrary lib)
      : delete =
            lib.lookupFunction<NDelete_SecpPrivateKey, DDelete_SecpPrivateKey>(
          'delete_SecpPrivateKey',
        );
}

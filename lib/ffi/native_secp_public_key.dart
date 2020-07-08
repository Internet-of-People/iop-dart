import 'dart:ffi';
import 'package:morpheus_sdk/ffi/ffi.dart';

typedef NDelete_SecpPublicKey = Void Function(
  Pointer<Void> secpPk,
);
typedef DDelete_SecpPublicKey = void Function(
  Pointer<Void> secpPk,
);

typedef NSecpPublicKey_ToString = Pointer<Result> Function(
  Pointer<Void> secpPk,
);
typedef DSecpPublicKey_ToString = Pointer<Result> Function(
  Pointer<Void> secpPk,
);

class NativeSecpPublicKey {
  final DDelete_SecpPublicKey delete;
  final DSecpPublicKey_ToString to_String; // cannot name it toString

  NativeSecpPublicKey(DynamicLibrary lib)
      : delete =
            lib.lookupFunction<NDelete_SecpPublicKey, DDelete_SecpPublicKey>(
          'delete_SecpPublicKey',
        ),
        to_String = lib
            .lookupFunction<NSecpPublicKey_ToString, DSecpPublicKey_ToString>(
          'SecpPublicKey_to_string',
        );
}

import 'dart:ffi';

typedef NDelete_SecpKeyId = Void Function(
  Pointer<Void> secpId,
);
typedef DDelete_SecpKeyId = void Function(
  Pointer<Void> secpId,
);

class NativeSecpKeyId {
  final DDelete_SecpKeyId delete;

  NativeSecpKeyId(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_SecpKeyId, DDelete_SecpKeyId>(
          'delete_SecpKeyId',
        );
}

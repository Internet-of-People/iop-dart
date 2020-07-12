import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';

typedef NDelete_Did = Void Function(
  Pointer<Void> did,
);
typedef DDelete_Did = void Function(
  Pointer<Void> did,
);

typedef NDid_Prefix = Pointer<Utf8> Function();
typedef DDid_Prefix = Pointer<Utf8> Function();

typedef NDid_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);
typedef DDid_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);

typedef NDid_FromKeyId = Pointer<Void> Function(
  Pointer<Void> id,
);
typedef DDid_FromKeyId = Pointer<Void> Function(
  Pointer<Void> id,
);

typedef NDid_ToString = Pointer<Utf8> Function(
  Pointer<Void> did,
);
typedef DDid_ToString = Pointer<Utf8> Function(
  Pointer<Void> did,
);

typedef NDid_DefaultKeyId = Pointer<Void> Function(
  Pointer<Void> did,
);
typedef DDid_DefaultKeyId = Pointer<Void> Function(
  Pointer<Void> did,
);

class NativeDid {
  final DDelete_Did delete;
  final DDid_Prefix prefix;
  final DDid_FromString fromString;
  final DDid_FromKeyId fromKeyId;
  final DDid_ToString to_String; // cannot name it toString
  final DDid_DefaultKeyId defaultKeyId;

  NativeDid(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_Did, DDelete_Did>(
          'delete_Did',
        ),
        prefix = lib.lookupFunction<NDid_Prefix, DDid_Prefix>(
          'Did_prefix',
        ),
        fromString = lib.lookupFunction<NDid_FromString, DDid_FromString>(
          'Did_from_string',
        ),
        fromKeyId = lib.lookupFunction<NDid_FromKeyId, DDid_FromKeyId>(
          'Did_from_key_id',
        ),
        to_String = lib.lookupFunction<NDid_ToString, DDid_ToString>(
          'Did_to_string',
        ),
        defaultKeyId = lib.lookupFunction<NDid_DefaultKeyId, DDid_DefaultKeyId>(
          'Did_default_key_id',
        );
}

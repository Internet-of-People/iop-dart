import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef NDelete_MorpheusPublicKey = Void Function(
  Pointer<Void> morpheusPublicKey,
);
typedef DDelete_MorpheusPublicKey = void Function(
  Pointer<Void> morpheusPublicKey,
);

typedef NMorpheusPublicKey_PathGet = Pointer<Utf8> Function(
  Pointer<Void> morpheusPublicKey,
);
typedef DMorpheusPublicKey_PathGet = Pointer<Utf8> Function(
  Pointer<Void> morpheusPublicKey,
);

typedef NMorpheusPublicKey_KindGet = Pointer<Utf8> Function(
  Pointer<Void> morpheusPublicKey,
);
typedef DMorpheusPublicKey_KindGet = Pointer<Utf8> Function(
  Pointer<Void> morpheusPublicKey,
);

typedef NMorpheusPublicKey_IdxGet = Int32 Function(
  Pointer<Void> morpheusPublicKey,
);
typedef DMorpheusPublicKey_IdxGet = int Function(
  Pointer<Void> morpheusPublicKey,
);

typedef NMorpheusPublicKey_PublicKey = Pointer<Void> Function(
  Pointer<Void> morpheusPublicKey,
);
typedef DMorpheusPublicKey_PublicKey = Pointer<Void> Function(
  Pointer<Void> morpheusPublicKey,
);

class NativeMorpheusPublicKey {
  final DDelete_MorpheusPublicKey delete;
  final DMorpheusPublicKey_PathGet pathGet;
  final DMorpheusPublicKey_KindGet kindGet;
  final DMorpheusPublicKey_IdxGet idxGet;
  final DMorpheusPublicKey_PublicKey publicKey;

  NativeMorpheusPublicKey(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_MorpheusPublicKey,
            DDelete_MorpheusPublicKey>(
          'delete_MorpheusPublicKey',
        ),
        pathGet = lib.lookupFunction<NMorpheusPublicKey_PathGet,
            DMorpheusPublicKey_PathGet>(
          'MorpheusPublicKey_bip32_path',
        ),
        kindGet = lib.lookupFunction<NMorpheusPublicKey_KindGet,
            DMorpheusPublicKey_KindGet>(
          'MorpheusPublicKey_kind',
        ),
        idxGet = lib.lookupFunction<NMorpheusPublicKey_IdxGet,
            DMorpheusPublicKey_IdxGet>(
          'MorpheusPublicKey_idx',
        ),
        publicKey = lib.lookupFunction<NMorpheusPublicKey_PublicKey,
            DMorpheusPublicKey_PublicKey>(
          'MorpheusPublicKey_public_key',
        );
}

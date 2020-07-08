import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef NDelete_MorpheusPrivateKey = Void Function(
  Pointer<Void> morpheusPrivateKey,
);
typedef DDelete_MorpheusPrivateKey = void Function(
  Pointer<Void> morpheusPrivateKey,
);

typedef NMorpheusPrivateKey_PathGet = Pointer<Utf8> Function(
  Pointer<Void> morpheusPrivateKey,
);
typedef DMorpheusPrivateKey_PathGet = Pointer<Utf8> Function(
  Pointer<Void> morpheusPrivateKey,
);

typedef NMorpheusPrivateKey_KindGet = Pointer<Utf8> Function(
  Pointer<Void> morpheusPrivateKey,
);
typedef DMorpheusPrivateKey_KindGet = Pointer<Utf8> Function(
  Pointer<Void> morpheusPrivateKey,
);

typedef NMorpheusPrivateKey_IdxGet = Int32 Function(
  Pointer<Void> morpheusPrivateKey,
);
typedef DMorpheusPrivateKey_IdxGet = int Function(
  Pointer<Void> morpheusPrivateKey,
);

typedef NMorpheusPrivateKey_Neuter = Pointer<Void> Function(
  Pointer<Void> morpheusPrivateKey,
);
typedef DMorpheusPrivateKey_Neuter = Pointer<Void> Function(
  Pointer<Void> morpheusPrivateKey,
);

typedef NMorpheusPrivateKey_PrivateKey = Pointer<Void> Function(
  Pointer<Void> morpheusPrivateKey,
);
typedef DMorpheusPrivateKey_PrivateKey = Pointer<Void> Function(
  Pointer<Void> morpheusPrivateKey,
);

class NativeMorpheusPrivateKey {
  final DDelete_MorpheusPrivateKey delete;
  final DMorpheusPrivateKey_PathGet pathGet;
  final DMorpheusPrivateKey_KindGet kindGet;
  final DMorpheusPrivateKey_IdxGet idxGet;
  final DMorpheusPrivateKey_Neuter neuter;
  final DMorpheusPrivateKey_PrivateKey privateKey;

  NativeMorpheusPrivateKey(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_MorpheusPrivateKey,
            DDelete_MorpheusPrivateKey>(
          'delete_MorpheusPrivateKey',
        ),
        pathGet = lib.lookupFunction<NMorpheusPrivateKey_PathGet,
            DMorpheusPrivateKey_PathGet>(
          'MorpheusPrivateKey_bip32_path',
        ),
        kindGet = lib.lookupFunction<NMorpheusPrivateKey_KindGet,
            DMorpheusPrivateKey_KindGet>(
          'MorpheusPrivateKey_kind',
        ),
        idxGet = lib.lookupFunction<NMorpheusPrivateKey_IdxGet,
            DMorpheusPrivateKey_IdxGet>(
          'MorpheusPrivateKey_idx',
        ),
        neuter = lib.lookupFunction<NMorpheusPrivateKey_Neuter,
            DMorpheusPrivateKey_Neuter>(
          'MorpheusPrivateKey_neuter',
        ),
        privateKey = lib.lookupFunction<NMorpheusPrivateKey_PrivateKey,
            DMorpheusPrivateKey_PrivateKey>(
          'MorpheusPrivateKey_private_key',
        );
}

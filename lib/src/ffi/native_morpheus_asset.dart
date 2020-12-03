import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';


typedef NDelete_MorpheusAssetBuilder = Void Function(Pointer<Void> builder);
typedef DDelete_MorpheusAssetBuilder = void Function(Pointer<Void> builder);

typedef NMorpheusAssetBuilder_New = Pointer<Void> Function();
typedef DMorpheusAssetBuilder_New = Pointer<Void> Function();

typedef NMorpheusAssetBuilder_AddSigned = Void Function(
  Pointer<Void> builder,
  Pointer<Void> signedOperation,
);
typedef DMorpheusAssetBuilder_AddSigned = void Function(
  Pointer<Void> builder,
  Pointer<Void> signedOperation,
);

typedef NMorpheusAssetBuilder_AddRegisterBeforeProof = Pointer<Result> Function(
  Pointer<Void> builder,
  Pointer<Utf8> contentId,
);
typedef DMorpheusAssetBuilder_AddRegisterBeforeProof = Pointer<Result> Function(
  Pointer<Void> builder,
  Pointer<Utf8> contentId,
);

typedef NMorpheusAssetBuilder_Build = Pointer<Void> Function(
  Pointer<Void> builder,
);
typedef DMorpheusAssetBuilder_Build = Pointer<Void> Function(
  Pointer<Void> builder,
);

class NativeMorpheusAssetBuilder {
  final DDelete_MorpheusAssetBuilder delete;
  final DMorpheusAssetBuilder_New create;
  final DMorpheusAssetBuilder_AddSigned addSigned;
  final DMorpheusAssetBuilder_AddRegisterBeforeProof addRegisterBeforeProof;
  final DMorpheusAssetBuilder_Build build;

  NativeMorpheusAssetBuilder(DynamicLibrary lib) :
    delete = lib.lookupFunction<NDelete_MorpheusAssetBuilder, DDelete_MorpheusAssetBuilder>(
      'delete_MorpheusAssetBuilder',
    ),
    // "new" and "default" are reserved words and cannot be used as a class member name
    create = lib.lookupFunction<NMorpheusAssetBuilder_New, DMorpheusAssetBuilder_New>(
      'MorpheusAssetBuilder_new',
    ),
    addSigned = lib.lookupFunction<NMorpheusAssetBuilder_AddSigned, DMorpheusAssetBuilder_AddSigned>(
      'MorpheusAssetBuilder_add_signed',
    ),
    addRegisterBeforeProof = lib.lookupFunction<NMorpheusAssetBuilder_AddRegisterBeforeProof, DMorpheusAssetBuilder_AddRegisterBeforeProof>(
      'MorpheusAssetBuilder_add_register_before_proof',
    ),
    build = lib.lookupFunction<NMorpheusAssetBuilder_Build, DMorpheusAssetBuilder_Build>(
      'MorpheusAssetBuilder_build',
    );
}

typedef NDelete_MorpheusAsset = Void Function(Pointer<Void> asset);
typedef DDelete_MorpheusAsset = void Function(Pointer<Void> asset);

typedef NMorpheusAsset_ToString = Pointer<Result> Function(Pointer<Void> asset);
typedef DMorpheusAsset_ToString = Pointer<Result> Function(Pointer<Void> asset);


class NativeMorpheusAsset {
  final DDelete_MorpheusAsset delete;
  final DMorpheusAsset_ToString to_String;

  NativeMorpheusAsset(DynamicLibrary lib) :
    delete = lib.lookupFunction<NDelete_MorpheusAsset, DDelete_MorpheusAsset>(
      'delete_MorpheusAsset',
    ),
    to_String = lib.lookupFunction<NMorpheusAsset_ToString, DMorpheusAsset_ToString>(
      'MorpheusAsset_to_string',
    );
}
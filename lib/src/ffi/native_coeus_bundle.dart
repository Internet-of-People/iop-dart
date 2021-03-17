import 'dart:ffi';
import 'package:iop_sdk/src/ffi/ffi.dart';

typedef NDelete_NoncedBundleBuilder = Void Function(Pointer<Void> builder);
typedef DDelete_NoncedBundleBuilder = void Function(Pointer<Void> builder);

typedef NNoncedBundleBuilder_New = Pointer<Void> Function();
typedef DNoncedBundleBuilder_New = Pointer<Void> Function();

typedef NNoncedBundleBuilder_Add = Void Function(
  Pointer<Void> builder,
  Pointer<Void> userOperation,
);
typedef DNoncedBundleBuilder_Add = void Function(
  Pointer<Void> builder,
  Pointer<Void> userOperation,
);

typedef NNoncedBundleBuilder_Build = Pointer<Void> Function(
  Pointer<Void> builder,
  Int64 nonce,
);
typedef DNoncedBundleBuilder_Build = Pointer<Void> Function(
  Pointer<Void> builder,
  int nonce,
);

class NativeCoeusNoncedBundleBuilder {
  final DDelete_NoncedBundleBuilder delete;
  final DNoncedBundleBuilder_New create;
  final DNoncedBundleBuilder_Add add;
  final DNoncedBundleBuilder_Build build;

  NativeCoeusNoncedBundleBuilder(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_NoncedBundleBuilder,
            DDelete_NoncedBundleBuilder>(
          'delete_NoncedBundleBuilder',
        ),
        // "new" and "default" are reserved words and cannot be used as a class member name
        create = lib
            .lookupFunction<NNoncedBundleBuilder_New, DNoncedBundleBuilder_New>(
          'NoncedBundleBuilder_new',
        ),
        add = lib
            .lookupFunction<NNoncedBundleBuilder_Add, DNoncedBundleBuilder_Add>(
          'NoncedBundleBuilder_add',
        ),
        build = lib.lookupFunction<NNoncedBundleBuilder_Build,
            DNoncedBundleBuilder_Build>(
          'NoncedBundleBuilder_build',
        );
}

typedef NDelete_NoncedBundle = Void Function(Pointer<Void> bundle);
typedef DDelete_NoncedBundle = void Function(Pointer<Void> bundle);

typedef NNoncedBundle_Sign = Pointer<Result> Function(
  Pointer<Void> bundle,
  Pointer<Void> privateKey,
);
typedef DNoncedBundle_Sign = Pointer<Result> Function(
  Pointer<Void> bundle,
  Pointer<Void> privateKey,
);

class NativeCoeusNoncedBundle {
  final DDelete_NoncedBundle delete;
  final DNoncedBundle_Sign sign;

  NativeCoeusNoncedBundle(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_NoncedBundle, DDelete_NoncedBundle>(
          'delete_NoncedBundle',
        ),
        sign = lib.lookupFunction<NNoncedBundle_Sign, DNoncedBundle_Sign>(
          'NoncedBundle_sign',
        );
}

typedef NDelete_SignedBundle = Void Function(Pointer<Void> bundle);
typedef DDelete_SignedBundle = void Function(Pointer<Void> bundle);

class NativeCoeusSignedBundle {
  final DDelete_SignedBundle delete;

  NativeCoeusSignedBundle(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_SignedBundle, DDelete_SignedBundle>(
          'delete_SignedBundle',
        );
}

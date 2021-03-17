import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

typedef NMorpheusTxBuilder_Build = Pointer<Result> Function(
  Pointer<Utf8> network,
  Pointer<Void> morpheusAsset,
  Pointer<Void> senderPublicKey,
  Int64 nonce,
);
typedef DMorpheusTxBuilder_Build = Pointer<Result> Function(
  Pointer<Utf8> network,
  Pointer<Void> morpheusAsset,
  Pointer<Void> senderPublicKey,
  int nonce,
);

class NativeMorpheusTxBuilder {
  final DMorpheusTxBuilder_Build build;

  NativeMorpheusTxBuilder(DynamicLibrary lib)
      : build = lib
            .lookupFunction<NMorpheusTxBuilder_Build, DMorpheusTxBuilder_Build>(
          'MorpheusTxBuilder_build',
        );
}

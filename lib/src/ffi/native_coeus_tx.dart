import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';


typedef NDelete_CoeusTxBuilder = Void Function(Pointer<Void> builder);
typedef DDelete_CoeusTxBuilder = void Function(Pointer<Void> builder);

typedef NCoeusTxBuilder_New = Pointer<Result> Function(Pointer<Utf8> network);
typedef DCoeusTxBuilder_New = Pointer<Result> Function(Pointer<Utf8> network);

typedef NCoeusTxBuilder_Build = Pointer<Result> Function(
  Pointer<Void> builder,
  Pointer<Void> signedBundle,
  Pointer<Void> senderPublicKey,
  Int64 nonce,
);
typedef DCoeusTxBuilder_Build = Pointer<Result> Function(
  Pointer<Void> builder,
  Pointer<Void> signedBundle,
  Pointer<Void> senderPublicKey,
  int nonce,
);


class NativeCoeusTxBuilder {
  final DDelete_CoeusTxBuilder delete;
  final DCoeusTxBuilder_New create;
  final DCoeusTxBuilder_Build build;

  NativeCoeusTxBuilder(DynamicLibrary lib) :
    delete = lib.lookupFunction<NDelete_CoeusTxBuilder, DDelete_CoeusTxBuilder>(
      'delete_CoeusTxBuilder',
    ),
    // "new" and "default" are reserved words and cannot be used as a class member name
    create = lib.lookupFunction<NCoeusTxBuilder_New, DCoeusTxBuilder_New>(
      'CoeusTxBuilder_new',
    ),
    build = lib.lookupFunction<NCoeusTxBuilder_Build, DCoeusTxBuilder_Build>(
      'CoeusTxBuilder_build',
    );
}

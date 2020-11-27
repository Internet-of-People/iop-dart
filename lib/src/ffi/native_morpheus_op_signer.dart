import 'dart:ffi';
import 'package:iop_sdk/src/ffi/ffi.dart';

typedef NDelete_MorpheusSignedOperation = Void Function(Pointer<Void> signed);
typedef DDelete_MorpheusSignedOperation = void Function(Pointer<Void> signed);

typedef NMorpheusSignedOperation_ToString = Pointer<Result> Function(Pointer<Void> signed);
typedef DMorpheusSignedOperation_ToString = Pointer<Result> Function(Pointer<Void> signed);


class NativeMorpheusSignedOperation {
  final DDelete_MorpheusSignedOperation delete;
  final DMorpheusSignedOperation_ToString to_String;

  NativeMorpheusSignedOperation(DynamicLibrary lib) :
    delete = lib.lookupFunction<NDelete_MorpheusSignedOperation, DDelete_MorpheusSignedOperation>(
      'delete_MorpheusSignedOperation',
    ),
    to_String = lib.lookupFunction<NMorpheusSignedOperation_ToString, DMorpheusSignedOperation_ToString>(
      'MorpheusSignedOperation_to_string',
    );
}


typedef NDelete_MorpheusOperationSigner = Void Function(Pointer<Void> signer);
typedef DDelete_MorpheusOperationSigner = void Function(Pointer<Void> signer);

typedef NMorpheusOperationSigner_New = Pointer<Void> Function();
typedef DMorpheusOperationSigner_New = Pointer<Void> Function();

typedef NMorpheusOperationSigner_Add = Void Function(
  Pointer<Void> signer,
  Pointer<Void> operation,
);
typedef DMorpheusOperationSigner_Add = void Function(
  Pointer<Void> signer,
  Pointer<Void> operation,
);

typedef NMorpheusOperationSigner_Sign = Pointer<Result> Function(
  Pointer<Void> signer,
  Pointer<Void> privateKey,
);
typedef DMorpheusOperationSigner_Sign = Pointer<Result> Function(
  Pointer<Void> signer,
  Pointer<Void> privateKey,
);

class NativeMorpheusOperationSigner {
  final DDelete_MorpheusOperationSigner delete;
  final DMorpheusOperationSigner_New create;
  final DMorpheusOperationSigner_Add add;
  final DMorpheusOperationSigner_Sign sign;

  NativeMorpheusOperationSigner(DynamicLibrary lib) :
    delete = lib.lookupFunction<NDelete_MorpheusOperationSigner, DDelete_MorpheusOperationSigner>(
      'delete_MorpheusOperationSigner',
    ),
    create = lib.lookupFunction<NMorpheusOperationSigner_New, DMorpheusOperationSigner_New>(
      'MorpheusOperationSigner_new',
    ),
    add = lib.lookupFunction<NMorpheusOperationSigner_Add, DMorpheusOperationSigner_Add>(
      'MorpheusOperationSigner_add',
    ),
    sign = lib.lookupFunction<NMorpheusOperationSigner_Sign, DMorpheusOperationSigner_Sign>(
      'MorpheusOperationSigner_sign',
    );
}

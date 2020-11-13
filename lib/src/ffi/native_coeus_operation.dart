import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';


typedef NDelete_CoeusUserOperation = Void Function(Pointer<Void> op);
typedef DDelete_CoeusUserOperation = void Function(Pointer<Void> op);

typedef NCoeusUserOperation_Register = Pointer<Result> Function(
  Pointer<Utf8> domainName,
  Pointer<Utf8> owner,
  Pointer<Void> subtreePolicies,
  Pointer<Utf8> data,
  Int64 expiresAtHeight,
);
typedef DCoeusUserOperation_Register = Pointer<Result> Function(
  Pointer<Utf8> domainName,
  Pointer<Utf8> owner,
  Pointer<Void> subtreePolicies,
  Pointer<Utf8> data,
  int expiresAtHeight,
);

typedef NCoeusUserOperation_Update = Pointer<Result> Function(
  Pointer<Utf8> domainName,
  Pointer<Utf8> data,
);
typedef DCoeusUserOperation_Update = Pointer<Result> Function(
  Pointer<Utf8> domainName,
  Pointer<Utf8> data,
);

typedef NCoeusUserOperation_Renew = Pointer<Result> Function(
  Pointer<Utf8> domainName,
  Int64 expiresAtHeight,
);
typedef DCoeusUserOperation_Renew = Pointer<Result> Function(
  Pointer<Utf8> domainName,
  int expiresAtHeight,
);

typedef NCoeusUserOperation_Transfer = Pointer<Result> Function(
  Pointer<Utf8> domainName,
  Pointer<Utf8> toOwner,
);
typedef DCoeusUserOperation_Transfer = Pointer<Result> Function(
  Pointer<Utf8> domainName,
  Pointer<Utf8> toOwner,
);

typedef NCoeusUserOperation_Delete = Pointer<Result> Function(
  Pointer<Utf8> domainName,
);
typedef DCoeusUserOperation_Delete = Pointer<Result> Function(
  Pointer<Utf8> domainName,
);


class NativeCoeusUserOperation {
  final DDelete_CoeusUserOperation delete;
  final DCoeusUserOperation_Register opRegister;
  final DCoeusUserOperation_Update opUpdate;
  final DCoeusUserOperation_Renew opRenew;
  final DCoeusUserOperation_Transfer opTransfer;
  final DCoeusUserOperation_Delete opDelete;

  NativeCoeusUserOperation(DynamicLibrary lib) :
    delete = lib.lookupFunction<NDelete_CoeusUserOperation, DDelete_CoeusUserOperation>(
      'delete_UserOperation',
    ),
    opRegister = lib.lookupFunction<NCoeusUserOperation_Register, DCoeusUserOperation_Register>(
      'UserOperation_register',
    ),
    opUpdate = lib.lookupFunction<NCoeusUserOperation_Update, DCoeusUserOperation_Update>(
      'UserOperation_update',
    ),
    opRenew = lib.lookupFunction<NCoeusUserOperation_Renew, DCoeusUserOperation_Renew>(
      'UserOperation_renew',
    ),
    opTransfer = lib.lookupFunction<NCoeusUserOperation_Transfer, DCoeusUserOperation_Transfer>(
      'UserOperation_transfer',
    ),
    opDelete = lib.lookupFunction<NCoeusUserOperation_Delete, DCoeusUserOperation_Delete>(
      'UserOperation_delete',
    );
}
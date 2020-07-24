import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/ffi/ffi.dart';

typedef NDelete_SignedBytes = Void Function(
  Pointer<Void> signedBytes,
);
typedef DDelete_SignedBytes = void Function(
  Pointer<Void> signedBytes,
);

typedef NSignedBytes_PublicKey_Get = Pointer<Void> Function(
  Pointer<Void> signedBytes,
);
typedef DSignedBytes_PublicKey_Get = Pointer<Void> Function(
  Pointer<Void> signedBytes,
);

typedef NSignedBytes_Content_Get = Pointer<NativeSlice> Function(
  Pointer<Void> signedBytes,
);
typedef DSignedBytes_Content_Get = Pointer<NativeSlice> Function(
  Pointer<Void> signedBytes,
);

typedef NSignedBytes_Signature_Get = Pointer<Void> Function(
  Pointer<Void> signedBytes,
);
typedef DSignedBytes_Signature_Get = Pointer<Void> Function(
  Pointer<Void> signedBytes,
);

typedef NSignedBytes_Validate = Uint8 Function(
  Pointer<Void> signedBytes,
);
typedef DSignedBytes_Validate = int Function(
  Pointer<Void> signedBytes,
);

typedef NSignedBytes_ValidateWithKeyId = Uint8 Function(
  Pointer<Void> signedBytes,
  Pointer<Void> id,
);
typedef DSignedBytes_ValidateWithKeyId = int Function(
  Pointer<Void> signedBytes,
  Pointer<Void> id,
);

typedef NSignedBytes_ValidateWithDidDoc = Pointer<Result> Function(
  Pointer<Void> signedBytes,
  Pointer<Utf8> didDoc,
  Pointer<IntPtr> fromHeightInc,
  Pointer<IntPtr> untilHeightExc,
);
typedef DSignedBytes_ValidateWithDidDoc = Pointer<Result> Function(
  Pointer<Void> signedBytes,
  Pointer<Utf8> didDoc,
  Pointer<IntPtr> fromHeightInc,
  Pointer<IntPtr> untilHeightExc,
);

class NativeSignedBytes {
  final DDelete_SignedBytes delete;
  final DSignedBytes_PublicKey_Get publicKeyGet;
  final DSignedBytes_Content_Get contentGet;
  final DSignedBytes_Signature_Get signatureGet;
  final DSignedBytes_Validate validate;
  final DSignedBytes_ValidateWithKeyId validateWithKeyId;
  final DSignedBytes_ValidateWithDidDoc validateWithDidDoc;

  NativeSignedBytes(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_SignedBytes, DDelete_SignedBytes>(
          'delete_SignedBytes',
        ),
        publicKeyGet = lib.lookupFunction<NSignedBytes_PublicKey_Get,
            DSignedBytes_PublicKey_Get>(
          'SignedBytes_public_key_get',
        ),
        contentGet = lib
            .lookupFunction<NSignedBytes_Content_Get, DSignedBytes_Content_Get>(
          'SignedBytes_content_get',
        ),
        signatureGet = lib.lookupFunction<NSignedBytes_Signature_Get,
            DSignedBytes_Signature_Get>(
          'SignedBytes_signature_get',
        ),
        validate =
            lib.lookupFunction<NSignedBytes_Validate, DSignedBytes_Validate>(
          'SignedBytes_validate',
        ),
        validateWithKeyId = lib.lookupFunction<NSignedBytes_ValidateWithKeyId,
            DSignedBytes_ValidateWithKeyId>(
          'SignedBytes_validate_with_keyid',
        ),
        validateWithDidDoc = lib.lookupFunction<NSignedBytes_ValidateWithDidDoc,
            DSignedBytes_ValidateWithDidDoc>(
          'SignedBytes_validate_with_did_doc',
        );
}
